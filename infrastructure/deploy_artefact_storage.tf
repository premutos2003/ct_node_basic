resource "aws_s3_bucket" "s3_bucket_deploy_artefact" {
  bucket = "${var.stack}-${var.git_project}"
  region = "${var.region}"
  force_destroy = true

}
resource "aws_s3_bucket_object" "deploy_artefact" {
  source = "../../${var.git_project}.tar"
  bucket = "${aws_s3_bucket.s3_bucket_deploy_artefact.id}"
  key = "${var.stack}/${var.version}"
}