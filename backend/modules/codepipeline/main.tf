resource "aws_codepipeline" "pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact_store.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = var.github_repo
        BranchName       = var.github_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode   = "REPLACE_ON_FAILURE"
        Capabilities = "CAPABILITY_IAM"
        TemplatePath = "build_output::template.yaml"
        StackName    = "${var.lambda_function_name}-stack"
        RoleArn      = aws_iam_role.cloudformation_role.arn
      }
    }
  }
}

resource "aws_iam_role" "cloudformation_role" {
  name = "${var.pipeline_name}-cloudformation-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cloudformation.amazonaws.com"
        }
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "cloudformation_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
#   role       = aws_iam_role.cloudformation_role.name
# }

resource "aws_s3_bucket" "artifact_store" {
  bucket = var.artifact_store_bucket
}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.pipeline_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

# Add necessary IAM policies for CodePipeline role
