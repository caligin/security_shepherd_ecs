provider "aws" {
    region = "eu-west-1"
}


resource "aws_ecr_repository" "bastion" {
  name = "shepherd_bastion"
}
resource "aws_ecr_repository" "app" {
  name = "shepherd_app"
}
resource "aws_ecr_repository" "database" {
  name = "shepherd_database"
}
output "bastion_registry_url" {
  value = "${aws_ecr_repository.bastion.repository_url}"
}
output "app_registry_url" {
  value = "${aws_ecr_repository.app.repository_url}"
}
output "database_registry_url" {
  value = "${aws_ecr_repository.database.repository_url}"
}


resource "aws_ecs_cluster" "shepherd" {
  name = "shepherd"
}


data "template_file" "ecs_task_shepherd" {
  template = "${file("ecs_task_shepherd.json.tpl")}"
  vars {
    mysql_root_password = "CowSaysMoo"
    shepherd_database_image = "${replace(aws_ecr_repository.database.repository_url, "https://", "")}"
    shepherd_app_image = "${replace(aws_ecr_repository.app.repository_url, "https://", "")}"
    shepherd_bastion_image = "${replace(aws_ecr_repository.bastion.repository_url, "https://", "")}"
  }
}
resource "aws_ecs_task_definition" "shepherd" {
  family = "shepherd"
  container_definitions = "${data.template_file.ecs_task_shepherd.rendered}"
}


resource "aws_ecs_service" "shepherd" {
  name = "shepherd"
  cluster = "${aws_ecs_cluster.shepherd.id}"
  task_definition = "${aws_ecs_task_definition.shepherd.arn}"
  desired_count = 1
}
