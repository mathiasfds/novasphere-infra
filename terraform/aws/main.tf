# main.tf — Ressources NovaSphere (paramétré)

# --- Nommage local ---
# Les locals permettent de centraliser les règles de nommage et les tags communs 
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# --- AMI Ubuntu 24.04 ---
# Récupère dynamiquement l'ID de l'image la plus récente fournie par Canonical 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --- Key Pair SSH ---
# Envoie ta clé publique SSH locale vers AWS pour permettre la connexion 
resource "aws_key_pair" "deployer" {
  key_name   = "${local.name_prefix}-key"
  public_key = file(var.ssh_public_key_path)
  tags       = local.common_tags
}

# --- Security Group ---
resource "aws_security_group" "web" {
  name        = "${local.name_prefix}-sg"
  description = "Security Group pour ${local.name_prefix}"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # TODO 3 : Utilisation de la variable définie dans variables.tf 
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })
}

# --- Instance EC2 ---
resource "aws_instance" "web" {
  # TODO 4 : Référence à l'ID récupéré par la data source ci-dessus 
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-web"
  })
}
