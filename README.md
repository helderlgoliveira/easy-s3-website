# Easy S3 Website

Easy deploy a simple S3 Website in AWS with Terraform.

# Two Steps

## 1. Fill variables in `terraform.tfvars` file:

```tf
bucket_name        = "my-website-bucket"
website_files_path = "/path/to/folder"
```

## 2. Deploy

```
terraform init
terraform apply -auto-approve
```

# Removing infrastructure

```
terraform destroy -auto-approve
```


