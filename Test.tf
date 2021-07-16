#deploying a web server
resource "aws_instance" "Motiva_Team3_webserver" {
  ami           = "ami-08755c4342fb5aede" # eu-west-3
  subnet_id  = aws_subnet.Motiva_Team3_Public_SN_01.id
  vpc_se  cjcjnvngtr8vcdcvx c xcurity_group_ids = aws_vpc.Motiva_Team3_VPC.id
  instance_type = "t2.micro"
  associate_public_ip_address = true

user_data = <<-EOF
    #!/bin/bash
sudo yum update -y
sudo yum install httpd php php-mysqlnd -y
cd /var/www/html
echo “This is a Sample Web Server” > TestIndex.html
sudo yum install wget -y
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content

wget https://s3.amazonaws.com/bucketforwordpresslab-
donotdelete/htaccess.txt

mv htaccess.txt .htaccess
chkconfig httpd on
service httpd start
    EOF 
    tags = {
        Name = "PAP_WEB_SERVER"
    }

}

#creating iam role with s3 full access 
resource "aws_iam_role" "test" {
  name = "test_role"
  assume_role_policy = "..."
}