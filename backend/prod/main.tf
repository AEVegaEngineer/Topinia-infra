provider "aws" {
  region = var.aws_region
}

module "codebuild" {
  source = "../modules/codebuild"

  project_name = var.codebuild_project_name
}

module "lambda" {
  source = "../modules/lambda"

  function_name = var.lambda_function_name
}

module "codestar" {
  source = "../modules/codestar"
}

module "apigateway" {
  source               = "../modules/apigateway"
  api_name             = "opinion-management-service"
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}

module "codepipeline" {
  source = "../modules/codepipeline"

  pipeline_name                       = var.pipeline_name
  codestar_connection_arn             = module.codestar.github_arn
  github_repo                         = var.github_repo
  github_branch                       = var.github_branch
  codebuild_project_name              = module.codebuild.project_name
  lambda_function_name                = module.lambda.function_name
  artifact_store_bucket               = var.artifact_store_bucket
  cloudformation_template_s3_location = "build_output::template.yaml"
}
