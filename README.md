# tf-up-and-running

a codethrough of `Terraform Up & Running by Yevgeniy Brikman`

## auth

export AWS IAM credentials into your environment

```bash
export AWS_ACCESS_KEY_ID=abcdefg
export AWS_SECRET_ACCESS_KEY=hijklmnop

```

### setup and teardown

setup:

```bash
# initialize state lock
cd s3-lock
terraform init
terraform apply
cd ..

# deploy autoscaling group with remote state
cd asg
terraform init
terraform workspace new tf-up-and-running # switch to empty workspace
terraform apply

```

applying the autoscaler will output public dns to a `Hello World` server

``` bash
# <terraform apply output>
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

alb_dns_name = <publicDNS>

curl <publicDNS>
Hello World

```

teardown: 

```bash
# tear down autoscaling group
cd asg
terraform destroy
cd ..

# tear down state lock
cd s3-lock
terraform init
terraform destroy # destroying the bucket requires the S3 console

```

### mysql rds

`mysql/main.tf` requires a secret `tf-up-and-running-mysql-password` set up in AWS Secrets Manager
