resource "aws_amplify_app" "example" {
  #name       = "${var.client-name}"
  name = "test"
  repository = "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/test"
  iam_service_role_arn = aws_iam_role.amplify-codecommit.arn
  enable_branch_auto_build = true

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  environment_variables = {
    ENV = "test"
  }

  access_token = "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"
}

/*
resource "aws_amplify_branch" "production" {
  app_id      = aws_amplify_app.example.id
  branch_name = "master"
  framework = "React"
  stage     = "PRODUCTION"
}
*/