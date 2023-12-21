#Variables used throughout the terraform code only changes need to be done here

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

#sub static website
variable "sub_domain_name" {
  description = "The domain name used for the 2nd S3 bucket"
  type        = string
  default     = "example.com" #change to personal domain
}

variable "sub_bucket_name" {
  description = "The name of the 2nd S3 bucket"
  type        = string
  default     = "example.com" #change to personal domain
}