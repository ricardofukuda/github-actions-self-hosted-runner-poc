# JUST TO STORE TERRAFORM STATE FOR DEMO TEST
resource "aws_s3_bucket" "state" {
  bucket = "tf-fukuda-atlantis-terragrunt-terraform-integration-test"

  force_destroy = true
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration { # required by terragrunt/terraform to init bucket
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encrypt" {
  bucket = aws_s3_bucket.state.id

  rule { # required by terragrunt/terraform to init bucket
    apply_server_side_encryption_by_default {
      kms_master_key_id = "arn:aws:kms:us-east-1:${local.account_id}:alias/aws/s3"
      sse_algorithm     = "aws:kms"
    }

    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_policy" "policy" { # required by terragrunt/terraform to init bucket
  bucket = aws_s3_bucket.state.id
  policy = data.template_file.bucket-policy.rendered
}
