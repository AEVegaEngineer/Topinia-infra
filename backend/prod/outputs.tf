output "pipeline_arn" {
  value = module.codepipeline.pipeline_arn
}

output "lambda_function_name" {
  value = module.lambda.function_name
}
