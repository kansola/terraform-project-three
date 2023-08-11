resource "digitalocean_droplet" "www-3" {
    image = "ubuntu-18-04-x64"
    name = "www-3"
    region = "lon1"
    size = "s-1vcpu-1gb"
    ssh_keys = [
      data.digitalocean_ssh_key.terraform-ssh-key.id
    ]



    connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = var.pvt_key
    timeout = "2m"
  }
  
  provisioner "remote-exec" {
    inline = [
         # install nginx
      "sudo apt update -y",
      "sudo adduser --quiet jenkins",
      "echo \"jenkins:password\" | chpasswd",
      "mkdir /home/jenkins/",
      "COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys",
      "sudo chmod 700 ~/.ssh",
      "chmod 600 ~/.ssh/authorized_keys"

      

    ]
  }
}

resource "digitalocean_reserved_ip_assignment" "example" {
  ip_address =  "68.183.254.49"
  droplet_id = digitalocean_droplet.www-3.id
}
