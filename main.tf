provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_security_group" "ec2_sg" {
  name        = "${terraform.workspace}-ec2-sg"
  description = "Security group for EC2 with EFS"

  ingress {
    from_port   = var.sg_ingress_port
    to_port     = var.sg_ingress_port
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "efs" {
  creation_token = "${terraform.workspace}-efs"
  tags = {
    Name = "${terraform.workspace}-efs"
  }
}

resource "aws_efs_mount_target" "efs_mount" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.ec2_sg.id]
}

resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  security_groups        = [aws_security_group.ec2_sg.name]

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = var.app_volume_size
    volume_type = "gp2"
  }

  user_data = templatefile("${path.module}/userdata.sh.tpl", {
    efs_dns = "${aws_efs_file_system.efs.dns_name}"
  })

  tags = {
    Name = "${terraform.workspace}-ec2"
  }

  depends_on = [aws_efs_mount_target.efs_mount]
}
