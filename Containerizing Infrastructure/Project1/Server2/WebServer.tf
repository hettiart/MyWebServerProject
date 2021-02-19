resource "aws_instance" "web2" {
   ami = "ami-047a51fa27710816e"
   instance_type = "t2.micro"
   key_name = "kplabs-terraform"

   provisioner "remote-exec" {
     inline = [
       "sudo amazon-linux-extras install -y nginx1.12",
       "sudo systemctl start nginx"
     ]

   connection {
     type = "ssh"
     user = "ec2-user"
     private_key = file("./kplabs-terraform.pem")
     host = self.public_ip
   }
   }
}
