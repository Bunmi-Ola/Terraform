provider "aws" {
   
}
resource "aws_instance" "test_instance" {
    
  ami           = "ami-0277fbe7afa8a33a6"
  instance_type = "t3.micro"

  tags = {
    Name = "test_instance"
  
  }
}
  resource "aws_s3_bucket" "bunmi_test_bucket"{

  bucket = "bunmi-test-bucket"
  acl    = "public-read"

  tags = {
    Name        = "my_test_bucket"
    
  }
    
}