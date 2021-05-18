##########################
/*VPC - SUBNET - SG - SECTION*/
##########################

resource "aws_vpc" "myapp-vpc"{
    cidr_block = var.vpc_cidr_blocks
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "myapp-subnet-1" {
    vpc_id            = aws_vpc.myapp-vpc.id
    cidr_block        = var.subnet_cidr_blocks
    availability_zone = var.avail_zone
    tags = {
        Name = "${var.env_prefix}-subnet-1"
    }
}

resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = aws_vpc.myapp-vpc.id
    tags   = {
        Name = "${var.env_prefix}-rtb"
    }
}

resource "aws_route_table" "myapp-route-table" {
    vpc_id = aws_vpc.myapp-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id
    }

    tags = {
        Name = "${var.env_prefix}-rtb"
    }
}

resource "aws_route_table_association" "myapp-rtb-association"{
    subnet_id      = aws_subnet.myapp-subnet-1.id
    route_table_id = aws_route_table.myapp-route-table.id
}

#########################################################################
#if you want to use default route table provided by aws
#remove resources = aws_route_table_association, aws_route_table and put the code bellow:

/*resource "aws_default_route_table" "main-rtb"{
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id
    }

    tags = {
        Name = "${var.env_prefix}-main-rtb"
    }
}*/
#########################################################################

#########################################################################

##Trick to get my external IP (my localmachine external IP)
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

output "my_IP"{
    value = "${chomp(data.http.myip.body)}"
}
##################################
#SECURITY GROUP
resource "aws_security_group" "myapp-sg" {
    name   = "myapp-sg"
    vpc_id = aws_vpc.myapp-vpc.id

    ingress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        #cidr_block = ["0.0.0.0/0"]
        #177.92.105.94
        #cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        #177.92.105.94
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1" #any protocol
        cidr_blocks     = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    tags = {
        Name = "${var.env_prefix}-security-group"
    }
}

#to use vpc default security group
/*resource "aws_default_security_group" "default-sg" {
    vpc_id = aws_vpc.myapp-vpc.id

    ingress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        #cidr_block = ["0.0.0.0/0"]
        #177.92.105.94
        cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        #177.92.105.94
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1" #any protocol
        cidr_blocks     = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    tags = {
        Name = "${var.env_prefix}-default-security-group"
    }
}*/
