#cidr_block = ["10.0.0.0/16","10.0.40.0/24"] (list)
#list - objects (objects composed by cidr_block and name, to acess.. cidr_bloc.parameter)
cidr_block = [
    {cidr_block = "10.0.0.0/16", name = "dev-vpc"},
    {cidr_block = "10.0.40.0/24", name = "dev-subnet"}
]

environment = ["development", "staging", "production"]

availability_zone = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]