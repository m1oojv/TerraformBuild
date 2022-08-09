# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids   = [aws_subnet.private-subnet-3.id, aws_subnet.private-subnet-4.id]
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
  identifier              = "testdb"
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

}

/*

resource "null_resource" "setup_db" {
  depends_on = [aws_db_instance.database-instance] #wait for the db to be ready
  provisioner "local-exec" {
    

    connection {
      type = "ssh"
      user = "ec2-user"
      host = "${aws_db_instance.database-instance.address}"
      bastion_host = "${aws_instance.bastion_host.public_dns}"
      bastion_port = 22
      bastion_user = "ec2-user" 
      bastion_private_key = file("C:\\Users\\yihui\\Desktop\\terraform4\\private_key.pem")
    }

    command = "psql -U ${aws_db_instance.database-instance.username} -h ${aws_db_instance.database-instance.address} -d postgres -f schema.sql"
    environment = {
      PGPASSWORD = "password"
    }
  }
}

*/
