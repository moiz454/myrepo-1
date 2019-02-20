## Terraform configurations

To create only VPC and Subnets for DEV environment, run the configs, like this:

	cd dev && terraform init && terraform apply -target=module.vpc -auto-approve

To create specific application servers in DEV environment, run the configs, like this:

	cd dev && terraform init && terraform apply -target=module.hello-world -auto-approve

To create entire DEV environment with app servers, run the configs, like this:

	cd dev && terraform init && terraform apply -auto-approve

The common modules can be reused when creating other environments like QA, STAGING and PRODUCTION, with customized parameters for each environment.

Note: Please RUN these terraform configs from the instance in DEV VPC
