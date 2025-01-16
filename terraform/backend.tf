terraform {
  backend "s3" {
    bucket = "txkel-devops-assignment-7-16-01-25" # Your existing S3 bucket name
    key    = "dev/terraform.tfstate"        # Path to state file within bucket
    region = "us-east-1"                    # Your bucket's region

  }
}