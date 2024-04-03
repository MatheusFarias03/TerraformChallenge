# Terraform Configuration for Provisioning Infrastructure on HUAWEI CLOUD

This Terraform configuration automates the provisioning of infrastructure resources on HUAWEI CLOUD. It creates a Virtual Private Cloud (VPC), subnet, Elastic IP (EIP), Elastic Cloud Server (ECS) instance, and associates the EIP with the ECS instance. Additionally, it sets up an organization in Huawei's SWR (ServiceStage Image Repository), pushes a Docker image to the SWR repository, installs Docker on the ECS instance, and runs the image on it.

## Prerequisites

Before running this Terraform configuration, ensure the following:

1. **HUAWEI CLOUD Account**: You must have a HUAWEI CLOUD account with appropriate permissions to create and manage resources.

2. **Access Key and Secret Key**: Obtain the Access Key and Secret Key of your HUAWEI CLOUD account.

3. **Terraform Installation**: Install Terraform on your local machine. You can download it from [here](https://www.terraform.io/downloads.html) and follow the installation instructions.

4. **Docker Installation**: Ensure Docker is installed and running on your local computer. You can download Docker Desktop from [here](https://www.docker.com/products/docker-desktop).

## Configuration

1. **Variables**: Update the `variables.tf` file with your HUAWEI CLOUD access key, secret key, region, availability zone, passwords, and Docker-related configurations.

2. **Security Group**: Ensure that port `5000` is open on the security group associated with your ECS instance on HUAWEI CLOUD. This is necessary for accessing the Docker image running on the ECS instance.

## Usage

1. **Initialize Terraform**: Run `terraform init` in the directory containing the Terraform configuration files to initialize the working directory.

2. **Plan**: Run `terraform plan` to see the execution plan. It will show you what actions Terraform will take when you apply the configuration.

3. **Apply**: Run `terraform apply` to apply the Terraform configuration and provision the infrastructure resources on HUAWEI CLOUD.

## Important Note

- Ensure that Docker is up and running before executing the Terraform configuration.

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs/index.html): Refer to the official Terraform documentation for more information on Terraform usage and features.

- [HUAWEI CLOUD Documentation](https://support.huaweicloud.com/intl/en-us/index.html): Explore the HUAWEI CLOUD documentation for specific details on using HUAWEI CLOUD services.

- [HUAWEI CLOUD Terraform Documentation](https://github.com/huaweicloud/terraform-provider-huaweicloud): HUAWEI CLOUD documentation specific for it's use with terraform.

- For any issues or questions related to this Terraform configuration, please open an issue in this repository.

