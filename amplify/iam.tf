#Policy document specifying what service can assume the role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["amplify.amazonaws.com"]
    }
  }
}
#IAM role providing read-only access to CodeCommit
resource "aws_iam_role" "amplify-codecommit" {
  name                = "AmplifyCodeCommit"
  assume_role_policy  = join("", data.aws_iam_policy_document.assume_role.*.json)
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"]
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.amplify-codecommit.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "UpdatedAmplifyAdminAccess",
            "Effect": "Allow",
            "Action": [
                "amplify:CreateApp",
                "amplify:CreateBackendEnvironment",
                "amplify:GetApp",
                "amplify:CreateDeployment",
                "amplify:CreateDomainAssociation",
                "amplify:CreateWebHook",
                "amplify:GetBackendEnvironment",
                "amplify:ListApps",
                "amplify:ListBackendEnvironments",
                "amplify:CreateBranch",
                "amplify:GetBranch",
                "amplify:GenerateAccessLogs",
                "amplify:GetArtifactUrl",
                "amplify:GetBackendEnvironment",
                "amplify:GetDomainAssociation",
                "amplify:GetJob",
                "amplify:GetWebHook",
                "amplify:UpdateApp",
                "amplify:ListArtifacts",
                "amplify:ListBranches",
                "amplify:ListDomainAssociations",
                "amplify:ListJobs",
                "amplify:ListTagsForResource",
                "amplify:ListWebHooks",
                "amplify:DeleteBranch",
                "amplify:DeleteApp",
                "amplify:DeleteBackendEnvironment",
                "amplify:DeleteDomainAssociation",
                "amplify:DeleteJob",
                "amplify:DeleteWebHook",
                "amplify:StartDeployment",
                "amplify:StartJob",
                "amplify:StopJob",
                "amplify:TagResource",
                "amplify:UntagResource",
                "amplify:UpdateApp",
                "amplify:UpdateBranch",
                "amplify:UpdateDomainAssociation",
                "amplify:UpdateWebHook",
                "amplifybackend:*"
            ],
            "Resource": "*"
        }
    ]
  })

}