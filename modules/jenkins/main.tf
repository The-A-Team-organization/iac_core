locals {
  github_cidrs = [
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20"
  ]
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name = "jenkins_public_subnet_${var.availability_zone}_${var.env}"
  })
}

resource "aws_route_table" "jenkins_route_table" {
  vpc_id = var.vpc_id
  tags = merge(var.common_tags, {
    Name    = "jenkins_route_table_${var.env}"
    Project = "Illuminati"
  })
}

resource "aws_route" "jenkins_route" {
  route_table_id         = aws_route_table.jenkins_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "public_subnet_association_jenkins" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_route_table.id
}

resource "aws_security_group" "jenkins_sg" {
  name   = "jenkins_sg_${var.env}"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = locals.github_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "jenkins_role" {
  name = "jenkins_role_${var.env}"


  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_role_policy_attachment" "jenkins_ssm" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


resource "aws_iam_role_policy_attachment" "jenkins_ecr" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}


resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = aws_iam_role.jenkins_role.name
}


resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name

  tags = merge(var.common_tags, {
    Name = "jenkins_instance"
  })


}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
  tags = merge(var.common_tags, {
    Name = "jenkins_eip_${var.env}"
  })
}
