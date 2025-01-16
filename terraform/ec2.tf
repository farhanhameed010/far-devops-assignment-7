# Create Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-security-group"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom port 81"
    from_port   = 81
    to_port     = 81
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
    Name        = "${var.environment}-ec2-sg"
    Environment = var.environment
  }
}

# Create Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key

  tags = {
    Name        = "${var.environment}-keypair"
    Environment = var.environment
  }
}

# Data source for Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Create EC2 Instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu_22_04.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = "${var.environment}-web-server"
    Environment = var.environment
  }
}

