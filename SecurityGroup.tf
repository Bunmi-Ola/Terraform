# Create a security group for front end
resource "aws_security_group" "Motiva_SG_FrontEnd_Team3" {
  name        = "Motiva_SG_FrontEnd_Team3"
  description = "Allow public access"
 vpc_id      = aws_vpc.Motiva_Team3_VPC.id
  ingress {
  
    from_port        = 80
    to_port          = 80    
    protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
   
  }
  ingress {
  
    from_port        = 22
    to_port          = 22    
    protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
   
  }
  ingress {
  
    from_port        = 443
    to_port          = 443    
    protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "Motiva_SG_FrontEnd_Team3"
  }
}

# Create a security group for back end
resource "aws_security_group" "Motiva_SG_BackEnd_Team3" {
  name        = "Motiva_SG_BackEnd_Team3"
  description = "Allow public access"
 vpc_id      = aws_vpc.Motiva_Team3_VPC.id
  ingress {
  
    from_port        = 3306
    to_port          = 3306    
    protocol         = "tcp"
      cidr_blocks      = ["10.0.1.0/24"]
   
  }
  ingress {
  
    from_port        = 22
    to_port          = 22    
    protocol         = "tcp"
      cidr_blocks      = ["10.0.1.0/24"]
   
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "Motiva_SG_BackEnd_Team3"
  }
}