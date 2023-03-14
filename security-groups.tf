resource "aws_security_group" "yogitest-nsg" {
  name_prefix = "yogitest-nsg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
    tags = {
    Terraform = "true"
    Environment = "test"
  }
}
