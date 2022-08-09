#create ec2 instance

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "myKey"
  public_key = tls_private_key.example.public_key_openssh

}

resource "local_file" "private_key" {
    content  = tls_private_key.example.private_key_pem
    filename = "private_key.pem"
}

resource "aws_instance" "bastion_host" {
  ami           = "ami-0dc5785603ad4ff54"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  subnet_id = aws_subnet.public-subnet-1.id
  private_ip = "10.0.0.11"

  tags = {
    Name = "Bastion host"
  }

  key_name = "myKey"

provisioner "file" {
  source      = "C:/Users/yihui/Desktop/terraform/terraform rds v2/dump_original.sql"
  destination = "/home/ec2-user/"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    //private_key = file("C:/Users/yihui/Desktop/terraform/terraform rds v2/private_key.pem")
    private_key = local_file.private_key.content
    host        = "${aws_instance.bastion_host.public_dns}"
  }

}

user_data = templatefile("C:\\Users\\yihui\\Desktop\\terraform\\terraform rds v2\\shell_script.sh",
  {
    #variables for shell script 
    aws_db_address = "${aws_db_instance.database-instance.address}"
    db_username = "${aws_db_instance.database-instance.username}"
  }
    )


depends_on = [local_file.private_key,aws_security_group.ssh-security-group, aws_subnet.public-subnet-1, aws_db_instance.database-instance]
}


