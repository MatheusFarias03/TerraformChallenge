terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.62.0"
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

# Create an EIP.
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

# Create an ECS
resource "huaweicloud_compute_instance" "tf_instance" {
	name = "tf-instance"
	image_id = "5f67dd87-7685-4a71-ae63-1dca02fd724c"
	flavor_id = "s6.medium.2"
	security_groups = ["default"]
	availability_zone = var.hwc_az
	admin_pass = var.hwc_ecs_pwd

	network {
		uuid = huaweicloud_vpc_subnet.tf_subnet.id
	}
}

# Associate the EIP with the ECS.
resource "huaweicloud_compute_eip_associate" "associated" {
	public_ip = huaweicloud_vpc_eip.tf_eip.address
	instance_id = huaweicloud_compute_instance.tf_instance.id
}

# Create organization.
resource "huaweicloud_swr_organization" "tf_org" {
  name = var.swr_org
}

# On the local machine, push the image to Huawei's SWR.
resource "null_resource" "push_image_swr" {
	depends_on = [
		huaweicloud_swr_organization.tf_org
	]

	provisioner "local-exec" {
		interpreter = ["PowerShell", "-Command"]
		command = <<-EOT
			${var.docker_login} ;
            docker build -t swr.${var.hwc_region}.myhuaweicloud.com/${var.swr_org}/${var.image} ${var.docker_path} ;
			docker push swr.${var.hwc_region}.myhuaweicloud.com/${var.swr_org}/${var.image}
		EOT
	}
}

# Send command to install docker in Huawei's ECS.
resource "null_resource" "install_docker" {
	depends_on = [
		huaweicloud_compute_eip_associate.associated,
		huaweicloud_compute_instance.tf_instance,
		null_resource.push_image_swr
	]

	connection {
		type = "ssh"
		user = "root"
		password = var.hwc_ecs_pwd
		host = huaweicloud_vpc_eip.tf_eip.address
	}

	provisioner "remote-exec" {
		inline = [
			"sudo apt update -y",
			"sudo apt install docker.io -y",
			"${var.docker_login}",
			"docker pull swr.${var.hwc_region}.myhuaweicloud.com/${var.swr_org}/${var.image}",
			"docker run -d -p 5000:5000 swr.${var.hwc_region}.myhuaweicloud.com/${var.swr_org}/${var.image}"
		]
	}
}

# Create a PostreSQL RDS.
# resource "huaweicloud_rds_instance" "rds_instance" {
# 	name = "rds_instance"
# 	flavor = "rds.pg.n1.large.2"
# 	vpc_id = huaweicloud_vpc.tf_vpc.id
# 	subnet_id = huaweicloud_vpc_subnet.tf_subnet.id
# 	security_group_id = "ae59ae1f-6141-4db1-899a-379bc493c6e8"
# 	availability_zone = [var.hwc_az]

# 	db {
# 		type = "PostgreSQL"
# 		version = "12"
# 		password = var.postgresql_pwd
# 	}

# 	volume {
# 		type = "CLOUDSSD"
# 		size = 40
# 	}
# }
