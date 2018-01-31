resource "aws_instance" "deploy_instance" {
  ami = "ami-8ad749e5"
  instance_type = "t2.micro"

  provisioner "file" {
    source      = "../${var.git_project}"
    destination = "/app"
  }

  provisioner "file" {
    source      = "../Dockerfile"
    destination = "/app/${var.git_project}"
  }

  provisioner "remote-exec" {
      inline = [
        "apt-get update",
        "apt-get install docker",
        "cd app/${var.git_project}",
        "docker build . -t ${var.git_project}",
        "docker run -p ${var.port} ${var.git_project}"
      ]
  }

  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags {
    stack = "${var.stack}"
    name = "${var.git_project}"
  }
}