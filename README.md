This repo contains terraform docs from very basic to advanced

- basic - just a simple config with one ec2 instance instance

## State file remote backend notes

- It shouldn't be stored in GH, becuase if teams mates doesnt apply the changes and pushes the code. State file will not be updated with new changes.
- Statefile always needs to be updated with all changes to maintain consistency across all peers.
- Use remote backend like s3, storage accounts to store the state file. s3 bucket access can be restricted with IAM rules and policies
- terraform init reads the state file from remote backend

## Useful commands

- terraform int
- terraform plan
- terraform apply
- terraform destroy
- terraform apply -var-file=staging.tfvars.
- terraform workspace new dev
- terraform workspace new staging
- terraform workspace select dev
- terraform workspace show
