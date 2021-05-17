
variable "cidr_block" {
    description = "vpc cidr block" 
    type        = list(object({
        cidr_block = string
        name       = string
    }))
}

variable "environment" {
    description = "Deployment environment"
}

variable "availability_zone"{
    type = list(string)
    }