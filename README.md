Provision an Amazon Linux 2 EC2 instance with:

Root and app EBS volumes

Mounted EFS

Configurable Security Group

Support for multiple AWS accounts via CLI profiles

Environment isolation using Terraform workspaces, currently tested for two(dev, prod)





📁 Structure

terraformTCSBANCS/

├── main.tf

├── variables.tf

├── outputs.tf                # for displaying outputs

├── terraform.tfvars          # for dev configuration

├── terraform.prod.tfvars     # for prod configuration

├── userdata.sh.tpl           # EBS and EFS user_data script for EC2

