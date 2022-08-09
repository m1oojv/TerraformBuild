# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids   = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  description  = "Subnet for Database Instance"

  tags   = {
    Name = "Database Subnets"
  }
}

# Get the Latest DB Snapshot
# terraform aws data db snapshot
/*
data "aws_db_snapshot" "latest-db-snapshot" {
  db_snapshot_identifier = "${var.database-snapshot-identifier}"
  most_recent            = true
  snapshot_type          = "manual"
} */

# Create Database Instance Restored from DB Snapshots
# terraform aws db instance
resource "aws_db_instance" "database-instance" {
  #"${format("%s %s", var.client-name, "SSH Security Group")}"
  identifier              = "${format("%s%s", var.client-name, "db")}"
  name                    = "${format("%s%s", var.client-name, "db")}"
  instance_class          = "${var.database-instance-class}"
  allocated_storage       =  5
  engine                  = "postgres"
  engine_version          = "13.1"
  username = "testuser"
  password = "password"
  skip_final_snapshot     = true 
  availability_zone       = "ap-southeast-1a"
  db_subnet_group_name    = aws_db_subnet_group.database-subnet-group.name
  multi_az                = "${var.multi-az-deployment}"
  vpc_security_group_ids  = [aws_security_group.database-security-group.id]
  backup_retention_period = 3

  tags = {
    backupPlan = "true"
  }
}

/*
resource "aws_db_snapshot" "test" {
  db_instance_identifier = aws_db_instance.database-instance.id
  db_snapshot_identifier = "testsnapshot1234"
}
*/
