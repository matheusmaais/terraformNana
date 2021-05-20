
output "SUBNET_ID"{
    value = module.myapp-subnet.subnet.id
}

output "Instance_IP" {
    value = module.myapp-server.instance_ip
}