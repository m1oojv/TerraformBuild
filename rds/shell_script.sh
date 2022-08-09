#!/bin/bash
cd \home
cd \ec2-user
chmod u+r+x ec2-user
sudo yum update -y
sudo amazon-linux-extras install postgresql13 -y
psql --version
export PGPASSWORD=password 
psql -U ${db_username} -h ${aws_db_address} -d postgres -f ec2-user

