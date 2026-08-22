# manually create resources
    1. key -> terraform-key
    2. security group -> terraform-SG -> 22, 80,3306

# terraform resources
    1. ec2 -> terraform-server -> console
    2. ec2 -> ami -> ubuntu
    3. ec2 -> key -> terraform-key
    4. ec2 -> security group -> terraform-SG
    5. ec2 -> 3 replicas -> app-1, db-1, web-1
    6. ec2 -> instance type -> t3.micro

  ##  day 04
    variable 
    1. define -> variable.tf 
    2. assign -> variable.tf
    3. call   -> main.tf

## priority 
    1. terraform apply -var "instance_type=t3.large"
    2. variable.auto.tfvar
    3. variable.tf
    4. tarraform.tfvar

## terraform command
    1. terraform init     -> Prepare your working directory for other commands
    2. terraform validate -> Check whether the configuration is valid
    3. terraform plan     -> Show changes required by the current configuration
    4. terraform apply    -> Create or update infrastructure
    5. terraform destroy  -> Destroy previously-created infrastructure
    6. terraform fmt      -> formating check like for indentation 
    7. terraform taint + terraform apply ->  if I do kadya in some resource manually and want to delete and recreate some resource so terrafrom taint resource_type.logical_name
    the terrafrom apply 
    8. terraform apply -replace -> work like terraform taint

    ## Day 05
    State file
    What is terraform backend?
    -> where your state file is stored is terraform backend
        Two types :
            1. local backend
            2. remote backend

        state lock -> backend 
                    : only one user can execute at a one time 
        
        to store state file remotly 
        s3 -> common
              version
              state lock
              encription support

        terraform cloud     |
        hashicorp consol    |  both are paid 

# terraform state file command

read operation

terraform state list   -> resource name
terraform state show (address of resource) -> detailed on perticular resource
terraform state pull -> pull all data from state file

write operation
 terraform state mv old_resource_name new_resource_name   -> to rename existing resource 
 
 terraform state rm resource_name  -> to remove from .tfstate no command will work on it resource will exist ouside terrform also commant main.tf resource block like export

 terrafrom state import resource_name_address unique-id like ARN then remove comment from main.tf file of resource block 
 ## same like this you can import resources that was created by mannually

 ### modules 
    its mainly focus on optimzing of code 
    root_dir -> put terraform and provider block
            |->modules 
                     |->ec2 -> all ec2 files 
                     |->s3  -> all s3 files
                     |->output ->

        add block named module in root main.tf file to call files from 
