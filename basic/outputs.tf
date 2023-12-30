#To workout below, you need to expose public_ip in module outputs.tf
output "public-ip-address" {
  value = module.ec2_instance.public_ip
}