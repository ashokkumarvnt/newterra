provider "aws" {
    region = "ap-south-1"

  
}
resource "aws_instance" "pappu" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.aws_instance_type
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = "ssg_key"

      provisioner "remote-exec" {
        inline = [ 
            "sudo apt update",
            "sudo apt install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx",
            "sudo apt update",
            "sudo rm /var/www/html/index.nginx-debian.html",
             "sudo chmod 777 /var/www/html"
         ]
        
      }

      provisioner "file" {
        source = "C:/Users/itssgc/OneDrive - Godrej & Boyce Mfg. Co. Ltd/Desktop/sks edu/muguntha"
        destination = "/var/www/html"
      
    }
     provisioner "local-exec" {
        command = "echo $(aws_instance.pappu.public_ip) >> details.txt"
       
     }
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file("C:/Users/itssgc/Downloads/ssg_key.pem")
      
    }

 

}