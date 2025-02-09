provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region.
}

resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-manoj"  # Replace with your desired key name
  public_key = file("~/.ssh/mkterrlogin.pub")  # Replace with the path to your public key file
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr

    tags = {
        Name = var.nametag
    }
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true #instances launched into the subnet should be assigned a public IP address
    tags = {
        Name = var.nametag
    }
}

# subnet becomes public when we internet gate way to route table and that routetable to subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

    tags = {
        Name = var.nametag
    }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
        Name = var.nametag
    }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
        Name = var.nametag
    }
}

resource "aws_instance" "server" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t3.medium" #"t2.micro"
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/mkterrlogin")  # Replace with the path to your private key
    host        = self.public_ip #we can use self only in same resource block else resource.exampe.publicip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      # Below code is only for flask
      # "echo 'Hello from the remote instance'",
      # "sudo apt update -y",  # Update package lists (for ubuntu)
      # "sudo apt-get install -y python3-pip",  # Example package installation
      # "cd /home/ubuntu",
      # "sudo pip3 install flask",
      # "sudo nohup python3 app.py &", #This line has to be fixed, as this is not running as a process

      #Below code is for flask and celery
      # "echo 'Hello from the remote instance'",
      # "sudo apt update -y",  # Update package lists (for ubuntu)
      # #"sudo apt-get install -y python3-pip redis-server",  # Example package installation
      # "sudo apt-get install -y python3-pip rabbitmq-server"
      # "cd /home/ubuntu",
      # "sudo pip3 install flask celery",
      # # Start Redis service (make sure Redis is running)
      # #"sudo systemctl start redis-server",
      # # Optionally enable Redis to start on boot
      # #"sudo systemctl enable redis-server",
      # "sudo nohup python3 app.py &", #This line has to be fixed, as this is not running as a process


      ### with rabbitmq"
      "echo 'Hello from the remote instance'",
      # "sudo apt update -y",  # Update package lists (for ubuntu)
      # "sudo apt-get install -y python3-pip",  # Example package installation
      # "cd /home/ubuntu",
      # "sudo pip3 install flask celery",
      # "sudo apt install rabbitmq-server -y",
      # "sudo systemctl enable rabbitmq-server",
      # "sudo systemctl start rabbitmq-server",
    ]
  }
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
  description = "The public IP of the EC2 instance"
}

#ssh -i ~/.ssh/mkterrlogin ubuntu@100.27.186.199 - to connect above ec2,
#sudo python3 app.py
#celery -A app.celery worker --loglevel=info -c 4

#lscpu, nproc, grep -c ^processor /proc/cpuinfo



