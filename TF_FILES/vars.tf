variable "hwc_ak" {
  type        = string
  default     = "X1LUJAQPTHZPVQEZDBYL"
  description = "Access Key of Huawei Cloud account."
}

variable "hwc_sk" {
  type        = string
  default     = "qq8OkFqq4n2Dzn6ug9nLpfpM1eOAkEQ6YfYfjIH0"
  description = "Secret Key of Huawei Cloud account."
}

variable "hwc_region" {
  type        = string
  default     = "sa-brazil-1"
  description = "Region where resources will be provisioned"
}

variable "hwc_az" {
  type        = string
  default     = "sa-brazil-1a"
  description = "Availability Zone where resources will be provisioned"
}

variable "postgresql_pwd" {
  type        = string
  default     = "__Huawei1234!__"
  description = "Password for PostgreSQL database."
}

variable "hwc_ecs_pwd" {
  type        = string
  default     = "__Huawei1234!__"
  description = "Password for ECS."
}

variable "docker_login" {
  type        = string
  nullable    = false
  description = "Login command to connect to SWR's registry."
}

variable "swr_org" {
  type        = string
  default     = "tf_org"
  description = "Name of SWR's organization."
}

variable "image" {
  type        = string
  default     = "tf_image_test"
  description = "Name of the image."
}

variable "docker_path" {
  type        = string
  default     = "C:\\Users\\m50037921\\Documents\\Learning\\TerraformChallenge\\WEBAPP\\"
}