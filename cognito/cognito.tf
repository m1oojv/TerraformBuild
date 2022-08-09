resource "aws_cognito_user_pool" "test" {
  name = "testpool"

  alias_attributes = ["preferred_username"]

  password_policy{
      minimum_length = 10
      require_lowercase = true
      require_numbers = true
      temporary_password_validity_days = 200
  }

  mfa_configuration          = "ON"

  software_token_mfa_configuration {
    enabled = true
  }

  account_recovery_setting {
      recovery_mechanism {
            name = "verified_email" #verified_phone_number or admin_only
            priority = 1
      }

  }

  admin_create_user_config {
    allow_admin_create_user_only = false #user can sign themselves up via an app

  }
  schema {
      attribute_data_type = "String"
      name = "custom-attribute"
      mutable = true
      string_attribute_constraints {
        max_length = 10
        min_length = 3
      }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT" #DEVELOPER to use your Amazon SES configuration
    reply_to_email_address = "test@gmail.com"
  }
}

resource "aws_cognito_user_pool_client" "client" {
    name = "client"

    user_pool_id =  aws_cognito_user_pool.test.id
    generate_secret = true
}