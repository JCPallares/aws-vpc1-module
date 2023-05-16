# aws-vpc1-module

## Purpose of the module

The purpose of this module is to build a VPC with a bastion server what is used to connect via ssh to a linux server in aws with terraform.

### Prerequisites / Dependencies:
* Following modules are required to be installed as prerequisites:
  * [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
  * AWS `Access Key ID`
  * AWS `Secret Access Key`

### How to deploy:

* Rename the `yourterraform.tfvars` file to `terraform.tfvars` and edit the `""` values.
* Execute terraform commands:
```bash
terraform init
terraform plan
terraform apply
```

## Inputs in .tfvars
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access_key_id | AWS access key to use for deploying resources | `string` | n/a | yes |
| secret_access_key | AWS secret access key to use for deploying resources| `string` | n/a | yes |
| region | Name of the AWS region where ROSA resources will be deployed | `string` | n/a | yes |
| vpc_azs | Name of the availability zone | `string` | n/a | yes |
| vpc_name | Name of the VPC | `string` | n/a | yes |
| vpc_cidr | cidr block of the VPC | `string` | n/a | yes |
| vpc_private_subnet | Name of the private subnet | `string` | n/a | yes |
| vpc_public_subnet | Name of the public subnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_cidr | cidr block of the vpc |
| vpc_public_subnet_cidr | cidr block of the public subnet |
| vpc_private_subnet_cidr | cidr block of the private subnet |
| bastion_public_dns | public dns of the bastion server |
| linux_server_private_ip | private IP of the linux server |
| vpc_id | vpc ID |
| vpc_private_route_id | vpc private route ID|

#### Access to VPC-1 virtual machines:

1. Get Bastion, Linux, Server IP:
```bash
terraform output bastion_public_dns
terraform output linux_server_private_ip
```

2. Connect to the Bastion Server SSH
```bash
ssh -i .ssh/key.pem ubuntu@<bastion_ip>
```

3. Once inside of Bastion Server you can connect to the other virtual machines in the private network using the same ssh key


* Create the file `key.pem` 
```bash
vi key.pem
```

* Copy the content of your local key.pem key and paste it into the file

4. Now you can access to the linux or window server with the same key
```bash
ssh -i key.pem ubuntu@<linux_ip>

or

ssh -i key.pem ubuntu@<windows_ip>
```

### Resources deployed in AWS

#### Network Module
* [aws_vpc]
* [aws_internet_gateway]
* [aws_route_table public]
* [aws_route_table_association public]
* [aws_route_table private]
* [aws_route_table_association private]
* [aws_eip]
* [aws_nat_gateway]
* [aws_vpc]
* [aws_subnet public]
* [aws_subnet private]
#### Security Group Module
* [aws_security_group public]
* [aws_security_group private] 
#### Bastion Module
* [aws_ami]
* [aws_instance]
#### Linux Server Module
* [aws_instance]

### How to destroy:

* Execute terraform commands:
```bash
terraform destroy
```

### Pricing Information

NAT Gateway USD/hour 0,045 USD & per/Gig 0,045 USD (EE.UU east Ohio)
