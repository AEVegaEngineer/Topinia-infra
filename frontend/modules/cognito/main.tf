resource "aws_cognito_user_pool" "pool" {
  name = "topinia-user-pool"

  # Add other configurations as needed
}

resource "aws_cognito_user_pool_client" "client" {
  name = "topinia-app-client"

  user_pool_id = aws_cognito_user_pool.pool.id

  allowed_oauth_flows  = ["code", "implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  callback_urls        = ["https://topinia.com/callback"]
  logout_urls          = ["https://topinia.com"]

  # Add other configurations as needed
}
