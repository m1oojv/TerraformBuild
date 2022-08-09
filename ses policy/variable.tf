variable "domain-arn" {
    default = "arn:aws:ses:ap-southeast-1:075343395323:identity/protoslabs.sg"
    description = "ProtosLabs.sg domain ARN"
    type = string
}

variable "delegate-user-id" {
    default = "431837896730"
    description = "Delegate User ID"
    type = string
}
