

# Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "ssg"
  }

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  # Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
