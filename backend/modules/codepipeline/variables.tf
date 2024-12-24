variable "pipeline_name" {}
variable "codestar_connection_arn" {}
variable "github_repo" {}
variable "github_branch" {}
variable "codebuild_project_name" {}
variable "lambda_function_name" {}
variable "artifact_store_bucket" {}
variable "cloudformation_template_s3_location" {
  description = "S3 location of the CloudFormation template for Lambda deployment"
  type        = string
}
