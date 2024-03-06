variable "hwc_ak" {
  type        = string
  default     = "KZLBCHFDFAGMFHDXRDAC"
  description = "Access Key of Huawei Cloud account."
}

variable "hwc_sk" {
  type        = string
  default     = "EV8SV6HENxMfquYFDhNng6Fl2FbIpbcqTXRCOyPf"
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