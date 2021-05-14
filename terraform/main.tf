provider "aws" {
    region     = "eu-west-3"
    access_key = ""
    secret_key = ""
}
##########################################
#Creates a vpc and subnet inside of it
##########################################
resource "aws_vpc" "development-vpc" {
    cidr_block = "10.0.0.0/16"   
    tags = {
        Name = "development-vpc"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id            =  aws_vpc.development-vpc.id
    cidr_block        = "10.0.10.0/24"
    availability_zone = "eu-west-3a"

    tags = {
        Name    = "development-subnet-1",
        vpc_env = "dev"
    }
}


##########################################
#But if you want to create a subnet inside of a pre existent vpc.. How Do we do it without navegate in the UI and grab the vpc id??
#data let you query inside the aws api, the result of query is exported under your given name
#in this example we will create a subnet inside a default vpc (all filters about criterias is on documentation)
##########################################
data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id            =  data.aws_vpc.existing_vpc.id
    #cidr_block has to be diferent to the existing ones, the last block was 32, we put 48
    cidr_block        = "172.31.48.0/20" 
    availability_zone = "eu-west-3a"

    tags = {
        Name = "development-subnet-2"
    }
}

##output
output "dev1_pvc_id" {
    value = aws_vpc.development-vpc.id
}

output "dev1_subnet_id" {
    value = aws_subnet.dev-subnet-1.id
}

