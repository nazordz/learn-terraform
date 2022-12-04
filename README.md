# How to init terraform project
1. Create **main.tf** file
2. add required providers inside the file
3. Run get command:
```bash
terraform get
```

# Create or update resource
Run in terminal:
```bash
terraform apply
```

# Destroy resource
1. Delete code from file then run: **(Recommended)**
```bash
terraform apply
```
2. run command in terminal 
```bash
terraform destroy -target resource_name.name
```
if **target** param's not included it will destroy all resources.

## Example:
```bash
terraform destroy -target google_compute_subnetwork.dev_subnet_02
```

# Check Changes
if you added or removed some code and want to know what gonna happen to your resource before apply it, you can run:
```bash
terraform plan
```

# Auto Approve
If you want to apply without confirmation
```bash
terraform apply -auto-approve
```

# Terraform State
Terraform can know which resource have been defined.

there's two file in project that store states.
1. **terraform.tfstate** : Store current state
2. **terraform.tfstate.backup** : Store previous state

# Variable
There's multiple way to declare variable in terraform:

1. Input value with prompt in terminal
2. Input value with arguments `-arg`. For example:
```bash
terraform apply -arg VAR_NAME=VAR_VALUE
```
3. Create `terraform.tfstate` file and input value in that file (Recommended). 
You can add argument `-var-file="FILE_NAME.tfvars"` to choose tfvars file if you have more than one.
```bash
terraform apply -var-file="terraform-dev.tfvars"
```
4. [Declare environment variable](https://developer.hashicorp.com/terraform/cli/config/environment-variables)