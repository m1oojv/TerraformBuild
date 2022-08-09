
data "aws_iam_policy_document" "delegate" {
  statement {
    sid = "AuthorizeMarketer"
    effect = "Allow"
    actions   = ["SES:SendEmail", "SES:SendRawEmail"]
    resources = ["${var.domain-arn}"] #protoslabs.sg domain ARN

    principals {
      identifiers = ["${var.delegate-user-id}"] #add the delegate user's id here
      type        = "AWS"
    }
    condition {
      test = "StringLike"
      variable = "ses:FromAddress"
      values = [
          "*@protoslabs.sg"
      ]
    }
  }
}

resource "aws_ses_identity_policy" "example" {
  identity = "${var.domain-arn}"
  name     = "DelegatePolicy"
  policy   = data.aws_iam_policy_document.delegate.json
}