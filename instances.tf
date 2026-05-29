resource "aws_instance" "web_server" {
  # The correct RHEL 9 ID you found
  ami           = "ami-0a59ec92177ec3fad" 
  
  # The true Free Tier type for us-east-1
  instance_type = "t3.micro"               

  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello World!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "RHEL-Free-Tier-Fix"
  }
}