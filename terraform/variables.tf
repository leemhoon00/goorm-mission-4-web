variable "s3_name" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "zone_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "domain" {
  type = string
}
