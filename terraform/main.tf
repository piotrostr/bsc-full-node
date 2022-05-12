data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "m5zn.2xlarge"
  key_name      = "key"
  depends_on = [
    aws_security_group.ssh_security_group
  ]
  vpc_security_group_ids = [
    aws_security_group.ssh_security_group.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    timeout     = "4m"
    host        = self.public_ip
    password    = var.SSH_PASSWORD
  }
}

resource "aws_security_group" "ssh_security_group" {
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
}

resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}
