resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.app_vpc.id}"

  ingress {
    from_port   = "${var.port}"
    to_port     = "${var.port}"

    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = "${var.port}"
    to_port         = "${var.port}"
    protocol        = "http"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}