variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnet"
  type        = list(string)
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}


variable "domain_name" {
  description = "Domain name for the SSL certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "ID of the Route 53 hosted zone"
  type        = string
}