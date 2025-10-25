resource "aws_instance" "k3s_master" {
  ami                    = "ami-0360c520857e3138f"  # Ubuntu 22.04
  instance_type          = "t3.small"
  key_name               = "quakewatch-key"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              EOF

  tags = { Name = "k3s-master" }
}

resource "aws_instance" "k3s_worker" {
  ami                    = "ami-0360c520857e3138f"
  instance_type          = "t3.small"
  key_name               = "quakewatch-key"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              MASTER_IP=${aws_instance.k3s_master.private_ip}
              curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=mysecret sh -
              EOF

  depends_on = [aws_instance.k3s_master]

  tags = { Name = "k3s-worker" }
}
