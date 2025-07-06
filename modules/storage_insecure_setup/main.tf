// ------------------------------------------------------------------
// MODULES DIRECTORY: ./modules/storate_insecure_setup/main.tf
// This is the main file for our module. It defines the insecure
// storage resources
// ------------------------------------------------------------------

resource "aws_s3_bucket" "public_read_bucket" {
    bucket = "${var.bucket_prefix}-public-read-${random_id.id.hex}" 
}

// To apply a public ACL we must first disable the block public access settting
resource "aws_s3_bucket_public_access_block" "public_read_block" {
    bucket = aws_s3_bucket.public_read_bucket.id
    
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

// Next we need to set the ownership controls to allow ACLs to be set

resource "aws_s3_bucket_ownership_controls" "public_read_ownership" {
    bucket = aws_s3_bucket.public_read_bucket.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
  
}

// Finally we apply the insecure public read ACL
resource "aws_s3_bucket_acl" "public_read_acl" {
    depends_on = [ 
        aws_s3_bucket_public_access_block.public_read_block,
        aws_s3_bucket_ownership_controls.public_read_ownership
     ]

     bucket = aws_s3_bucket.public_read_bucket.id
     acl = "public_read"
  
}