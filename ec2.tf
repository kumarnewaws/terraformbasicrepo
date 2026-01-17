resource "aws_instance" "DemBasicS3ec2" {
  ami                         = "ami-02b8269d5e85954ef"
  instance_type               = "t3.micro"
  key_name                    = "Desktop_key"
  subnet_id                   = aws_subnet.DemoSubnet-1.id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  tags = {
    "Name" = "${var.vpc_name}-WebServer"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  user_data = <<EOF
#!/bin/bash
apt update -y
apt install nginx -y
service nginx start
PVTIP=`curl -sL http://169.254.169.254/latest/meta-data/local-ipv4`
echo "*************************************************************" 
echo "<h1>$PVTIP</h1>" >> /var/www/html/index.nginx-debian.html
echo "*************************************************************"
echo "<h1>${var.vpc_name}-WebServer" >> /var/www/html/index.nginx-debian.html
echo "*************************************************************"
EOF
}
