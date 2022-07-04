resource "aws_kms_key" "my-kms-key" {
  description         = "My KMS Keys for Data Encryption"
  enable_key_rotation = true

//kindly copy paste the manual policy here 
  policy = <<EOF
{
    "Id": "key-consolepolicy-3",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::027619007323:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF
}

//check this before continue  
resource "aws_kms_alias" "smc-kms-alias" {
  target_key_id = "${aws_kms_key.my-kms-key.key_id}"
  name          = "alias/my-terraform-final-encryption-key"
}