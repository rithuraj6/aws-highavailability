data "aws_vpc" "boarding" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.boarding.id]
  }

  tags = {
    Name = "boarding-week2-subnet-private*"
  }
}
