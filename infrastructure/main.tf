provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block         = var.vpc_cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = var.repository_name
}

module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  app_name = var.app_name
}

module "load_balancer" {
  source = "./modules/load-balancer"

  app_name          = var.app_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = var.container_port
  certificate_arn   = var.certificate_arn
}

module "ecs_service" {
  source = "./modules/ecs-service"

  app_name               = var.app_name
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  container_port         = var.container_port
  container_image        = "${module.ecr.repository_url}:latest"
  cluster_id             = module.ecs_cluster.cluster_id
  cluster_name           = module.ecs_cluster.cluster_name
  target_group_arn       = module.load_balancer.target_group_arn
  alb_security_group_id  = module.load_balancer.security_group_id
}