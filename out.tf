output "aws_ami_id" {
    value = aws_instance.pappu.ami
  
}
output "aws_instance_ip" {
    value = aws_instance.pappu.public_ip

  
}