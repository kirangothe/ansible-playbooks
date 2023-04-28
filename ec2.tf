resource "aws_instance" "myec2" {
  ami                    = "ami-08df646e18b182346"
  instance_type          = "t2.micro"
  availability_zone = "ap-southeast-2"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = "kgsd"

  tags = {
    name = "php-mysql"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} >> /etc/ansible/hosts"
  }
}
