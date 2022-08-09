variable "vpc-cidr" {
    default = "10.0.0.0/16"
    description = "VPC CIDR"
    type = string
}

variable "public-subnet-1-cidr" {
    default = "10.0.0.0/24"
    description = "Public Subnet 1 CIDR"
    type = string
}

variable "public-subnet-2-cidr" {
    default = "10.0.1.0/24"
    description = "Public Subnet 2 CIDR"
    type = string
}

variable "private-subnet-1-cidr" {
    default = "10.0.2.0/24"
    description = "Private Subnet 1 CIDR"
    type = string
}

variable "private-subnet-2-cidr" {
    default = "10.0.3.0/24"
    description = "Private Subnet 2 CIDR"
    type = string
}

variable "private-subnet-3-cidr" {
    default = "10.0.4.0/24"
    description = "Private Subnet 3 CIDR"
    type = string
}

variable "private-subnet-4-cidr" {
    default = "10.0.5.0/24"
    description = "Private Subnet 4 CIDR"
    type = string
}

variable "ssh-location" {
    default = "112.199.144.122/32"
    description = "IP Address that can SSH into the EC2 Instance"
    type = string
}

variable "database-snapshot-identifier" {
    default = "arn:aws:rds:ap-southeast-1:431837896730:snapshot:test"
    description = "Database Snapshot ARN"
    type = string
}

variable "database-instance-class" {
    default = "db.t3.micro"
    description = "Database Instance Type"
    type = string
}

variable "database-instance-identifier" {
    default = "database-test"
    description = "Database Instance Identifier"
    type = string
}

variable "multi-az-deployment" {
    default = false
    description = "Create standby database instance"
    type = bool
}

variable "my-ip" {
    default = "112.199.144.122"
    description = "My own IP address"
    type = string
}

variable "client-name" {
    default = "protoslabs"
    description = "Client's company name"
    type = string
}
