resource "aws_instance" "test_app" {
  depends_on = ["aws_s3_bucket_object.deploy_artefact"]
  ami = "ami-244c7a39"
  key_name = "twitter_key"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  provisioner "remote-exec" {
    inline = [
      "$ sudo pip install --upgrade awscli",
      "$ export PATH=/home/ec2-user/.local/bin:$PATH",
      "$ aws --version",
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "aws s3 cp ${aws_s3_bucket.s3_bucket_deploy_artefact.bucket}/${aws_s3_bucket_object.deploy_artefact.key} .",
      "docker load < ${aws_s3_bucket_object.deploy_artefact.key}.tar.gz"
    ]
  }

}

output "instance_ip" {
  value = "${aws_instance.test_app.public_ip}"
}

