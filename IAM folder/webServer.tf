
#creat IAM role with s3 full access
resource "aws_iam_role" "Motiva_Team3_iam_role" {
  name        = "Motiva_Team3_iam_role"
  description = "Provides full access to all buckets"
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#attach s3 full access IAM policy to  role
resource "aws_iam_role_policy_attachment" "Motiva_Team3_s3bucket-full-access-policy-attachment" {
    role = "${aws_iam_role.Motiva_Team3_iam_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "Motiva_Team3_ec2-instance-profile" {
  name = "Motiva_Team3_ec2-instance-profile"
   role = "${aws_iam_role.Motiva_Team3_iam_role.name}" 
}

#create key
resource "aws_key_pair" "Motiva_Team3_key" {
  key_name   = "Motiva_Team3_key"
  public_key = file("C:/Users/olasu/Documents/DevOps Training/keys/miniProject.pub")
}
#deploying a web server
resource "aws_instance" "Motiva_Team3_webserver" {
  ami           = "ami-08755c4342fb5aede" # eu-west-3
  subnet_id  = aws_subnet.Motiva_Team3_Public_SN_01.id  
  vpc_security_group_ids = ["${aws_security_group.Motiva_SG_FrontEnd_Team3.id}"]  
  instance_type = "t2.micro"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.Motiva_Team3_ec2-instance-profile.name}"
  key_name               = aws_key_pair.Motiva_Team3_key.key_name
#  connection {
#           type        = "ssh"
#           user        = "ec2-user"
#           private_key = file("C:/Users/olasu/Documents/DevOps Training/keys/miniProject")
#           host        = self.public_ip
#   }
  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install httpd php php-mysqlnd -y
cd /var/www/html
echo “This is a Sample Web Server” > TestIndex.html
sudo yum install wget -y
sudo su
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content   
chown -R apache:apache wp-content
wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
mv htaccess.txt .htaccess
chkconfig httpd on
service httpd start
EOF 
tags = {
        Name = "Motiva_Team3_webserver"
    }

}

resource "aws_ami_from_instance" "Motiva_Team3_webserver_ami" {
  name               = "Motiva_Team3_webserver_Image"
  source_instance_id = "${aws_instance.Motiva_Team3_webserver.id}"
  snapshot_without_reboot = true
  
   depends_on = [
      aws_instance.Motiva_Team3_webserver,
      ]

  tags = {
      Name = "Motiva_Team3_webserver_ami"
  }
}
