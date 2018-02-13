resource "aws_instance" "test_app" {
  ami = "ami-af0fc0c0"
  key_name = "twitter_key"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.public-subnet.id}"
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
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]

}
