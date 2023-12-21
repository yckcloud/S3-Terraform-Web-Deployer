
![Banner](https://github.com/yckcloud/S3-Terraform-Web-Deployer/assets/142577108/aca794c4-6527-4a67-b985-2dc97010fedb)

# AWS/Terraform Web Deployer

Terraform code to deploy static websites to AWS S3 bucket in seconds with a custom domain

## Prerequisites
- Cloudflare account and domain - https://www.cloudflare.com/en-gb/
- AWS account - https://aws.amazon.com/
- Terraform - https://developer.hashicorp.com/terraform/install
- PowerShell 
- Make sure existing DNS records don't exist for records we will be creating

## Getting Started
Initialize Terraform in each folder "aws" and "cloudflare"

```bash
cd aws
terraform init

cd cloudflare
terraform init
```

## Cloudflare
Navigate to cloudflare\dns.tf and enter api token, make sure token has permissions below:

### Permissions

zone - page rules - edit

zone - dns - edit

### Zone Resources

include - specific zone - domain

![permissions for cloudflare pic](https://github.com/yckcloud/S3-Terraform-Web-Deployer/assets/142577108/789e62af-9db5-4668-8bec-9236ad9f1545)

https://developers.cloudflare.com/fundamentals/api/get-started/create-token/ 

```bash
#Cloudflare authentication
provider "cloudflare" {
  api_token = "" 
```
Whilst in cloudflare\dns.tf you will also need to update "zone_id" and "value"
https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/

Get Zone id from cloudflare and replace "DOMAIN and REGION" from value with your own domain and region you will be using eg.  www.example.com.eu-west2.amazonaws.com.

Repeat this same process with second record in the file
```bash
resource "cloudflare_record" "example" {
  allow_overwrite = "true"
  zone_id = "" 
  name    = "www"
  value   = "www.DOMAIN.com.s3-website.REGION.amazonaws.com" 

```
At the bottom of the dns.tf file there is one more value we need to specify for a page rule we are setting. Enter Zone id which we used previously and replace "target" DOMAIN with your own. eg "example.com/*"
```bash
#Cloudflare page rule which enforces the use of HTTPS for domain
resource "cloudflare_page_rule" "example3" {
  zone_id = ""
  target  = "DOMAIN.com/*" 
```

## AWS
Navigate to aws\providers.tf and enter access key and secret key https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html 

It is best practise to create a iam user specifically for this. DO NOT use root account.
https://gmusumeci.medium.com/how-to-create-an-iam-account-and-configure-terraform-to-use-aws-static-credentials-a8ea4dd4fdfc

```bash
#AWS proivder configuration and authentication
provider "aws" {
  region  = "eu-west-2" #change region to suit your needs
  access_key = "" #enter aws access key
  secret_key = "" #enter aws secret
}
```
Navigate to aws\variables.tf and enter variables for static website domain name and bucket name

Repeat this for sub static website domain name and bucket name in the file
```bash
#static website 
variable "domain_name" {
  description = "The domain name used for the 1st S3 bucket"
  type        = string
  default     = "www.example.com" #change to personal domain
}

variable "bucket_name" {
  description = "The name of the 1st S3 bucket"
  type        = string
  default     = "www.example.com" #change to personal domain
}
```
Place your website content in the "uploads" folder which is found at aws\uploads. It will upload all content from this folder to S3 bucket

Once all this is configured run the below command in both folders "cloudflare" & "aws":
```bash
terraform plan 
```
Make sure everything is okay and run the below command in the folders "cloudflare" & "aws":
```bash
terraform apply
```
Browse to site at www.yourdomain.com and enjoy!

