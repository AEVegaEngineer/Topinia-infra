variable "aws_region" {
  default = "us-east-1"
}

variable "codebuild_project_name" {
  default = "opinion-management-service-build"
}

variable "lambda_function_name" {
  default = "opinion-management-service-lambda"
}

variable "pipeline_name" {
  default = "opinion-management-service-pipeline"
}

variable "github_repo" {
  description = "GitHub repository in the format 'owner/repo'"
  default     = "AEVegaEngineer/topinia-backend"
}

variable "github_branch" {
  default = "master"
}

variable "artifact_store_bucket" {
  default = "opinion-management-service-store-bucket"
}
