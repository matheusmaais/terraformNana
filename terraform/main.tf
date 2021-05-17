// export AWS_SECRET_ACCESS_KEY= &&
// export AWS_ACCESS_KEY_ID=

#To configure credentials on global context:
#install aws cli.. 
#$aws configure
provider "aws" {
    region     = "eu-west-3"
}

#################################################################
##########################################
#Creates a vpc and subnet inside of it
##########################################
resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_block[0].cidr_block
    tags = {
        Name = var.cidr_block[0].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id            = aws_vpc.development-vpc.id
    cidr_block        = var.cidr_block[1].cidr_block
    availability_zone = var.availability_zone[0]

    tags = {
        Name    = var.cidr_block[1].name,
        vpc_env = var.environment[0]
    }
}

##output - like variables, outputs could.. and maybe should be placed in another file (outputs.tf)
output "Development_Vpc_ID" {
    value = aws_vpc.development-vpc.id
}

output "Development_Subnet_ID" {
    value = aws_subnet.dev-subnet-1.id
}
#################################################################

##########################################
#But if you want to create a subnet inside of a pre existent vpc.. How Do we do it without navegate in the UI and grab the vpc id??
#data let you query inside the aws api, the result of query is exported under your given name
#in this example we will create a subnet inside a default vpc (all filters about criterias is on documentation)
##########################################
// data "aws_vpc" "existing_vpc" {
//     default = true
// }

// resource "aws_subnet" "dev-subnet-2" {
//     vpc_id            =  data.aws_vpc.existing_vpc.id
//     #cidr_block has to be diferent to the existing ones, the last block was 32, we put 48
//     cidr_block        = "172.31.48.0/20" 
//     availability_zone = "eu-west-3a"

//     tags = {
//         Name = "development-subnet-2"
//     }
// }


