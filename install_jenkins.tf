resource "null_resource" "install_jenkins" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y openjdk-17-jre-headless gnupg2",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list",
	"sudo touch /etc/apt/trusted.gpg.d/jenkins.gpg",
	"sudo chmod 644 /etc/apt/trusted.gpg.d/jenkins.gpg",
	"sudo apt-key --keyring /etc/apt/trusted.gpg.d/jenkins.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 	5BA31D57EF5975CA",
      "sudo apt update",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins",
    ]
  }

  connection {
    type        = "ssh"
    host        = "ec2-13-236-119-71.ap-southeast-2.compute.amazonaws.com"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/jenkins_key")
  }
}
