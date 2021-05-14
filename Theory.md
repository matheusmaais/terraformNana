

What is Terraform?
    * Automate and manage infrastructure, plataform and services that run on plataform
    * Declarative style
    * Tool for infra provisioning
    * Infrastructure as code

2 main componentes:
    * TF core ( 2 input sources ( tf config where you defined what needs  to be created), and TF state), core take 2 inputs and create the plan that what need to be done

Cloud agnostic
--------------------------

Installing Terraform:
    install via package manager
    Download Library

All terraform concepts will use AWS like cloud provider
--------------------------

REMOVE RESOURCES WITHOUT DELETE CODE:
In this example, we want to remove dev-subnet-2, but is not recommended
$terraform destroy -target aws_subnet.dev-subnet-2
--------------------------
$terraform apply --auto-approve
$terraform destroy --auto-approve
$terraform state list
$terraform show resource.name (good way to get resource atributes) #IT"S VERY USEFULL#