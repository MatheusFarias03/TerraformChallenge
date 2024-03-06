terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.61.1"
    }
  }
}

# Configure the HUAWEI CLOUD provider.
provider "huaweicloud" {
	region = var.hwc_region
	access_key = var.hwc_ak
	secret_key = var.hwc_sk
}

# Create a VPC.
resource "huaweicloud_vpc" "tf_vpc" {
	name = "tf_vpc"
	cidr = "192.192.0.0/16"
}

# Create a subnet.
resource "huaweicloud_vpc_subnet" "tf_subnet" {
	name = "tf-subnet"
	cidr = "192.192.1.0/24"
	gateway_ip = "192.192.1.1"
	vpc_id = huaweicloud_vpc.tf_vpc.id
}

# Create a EIP.
resource "huaweicloud_vpc_eip" "tf_eip" {
	publicip {
		type = "5_bgp"
	}
	bandwidth {
		name = "tf-bandwith"
		size = 10
		share_type = "PER"
		charge_mode = "traffic"
	}
}
