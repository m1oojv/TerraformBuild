resource "aws_efs_file_system" "efs" {
  creation_token = "my-product"
  encrypted = true

  tags = {
    Name = "${format("%s%s", var.client-name, "EFS")}"
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

#enable backup policy
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "private1" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.private-subnet-1.id
}

resource "aws_efs_mount_target" "private2" {
    file_system_id = aws_efs_file_system.efs.id
    subnet_id      = aws_subnet.private-subnet-2.id
  }
