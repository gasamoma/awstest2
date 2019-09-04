# awstest2
Test 2 - AWS, Terraform and Kitchen
NOTE: I haven't tried Kitchen before, but as far as i read to it this is the way to integrate it
feel free to add PR to the WIP with any corrections
---
To apply the project do 
`terraform init`
`terraform apply`
if you want to change some of the variables feel fre to do it with the apply command with any of
variable "bucket_name" 
variable "region" 
variable "versioning"
destroy at the end with 
`terraform destroy`