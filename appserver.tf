# ----------------------------
# key pair
# ----------------------------
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-keypair"
  public_key = file("./src/fjord-terraform-keypair.pub")

  tags = {
    "Name" = "${var.project}-keypair"
  }
}

# ----------------------------
# EC2 Instance
# ----------------------------
resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.app.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_ec2_profile.name
  vpc_security_group_ids = [
    aws_security_group.app_sg.id,
    aws_security_group.opmng_sg.id
  ]
  key_name = aws_key_pair.keypair.key_name

  tags = {
    "Name" = "${var.project}-app-ec2"
    "Type" = "app"
  }
}

# ----------------------------
# SSM Parameter Store
# ----------------------------
resource "aws_ssm_parameter" "host" {
  name  = "/${var.project}/app/MYSQL_HOST"
  type  = "String"
  value = aws_db_instance.mysql_standalone.address
}
resource "aws_ssm_parameter" "port" {
  name  = "/${var.project}/app/MYSQL_PORT"
  type  = "String"
  value = aws_db_instance.mysql_standalone.port
}
resource "aws_ssm_parameter" "db_name" {
  name  = "/${var.project}/app/MYSQL_DB_NAME"
  type  = "String"
  value = aws_db_instance.mysql_standalone.db_name
}
resource "aws_ssm_parameter" "username" {
  name  = "/${var.project}/app/MYSQL_USERNAME"
  type  = "SecureString"
  value = aws_db_instance.mysql_standalone.username
}
resource "aws_ssm_parameter" "password" {
  name  = "/${var.project}/app/MYSQL_PASSWORD"
  type  = "SecureString"
  value = aws_db_instance.mysql_standalone.password
}
