variable "bucketname" {
  description = "Bucket name for S3"
  type = string
  default = "frank-covid-19-bucket"
}

variable "bucket1name" {
  description = "Bucket name for S3"
  type = string
  default = "frank-covid-19-test-bucket"
}

variable "db_password" {
  description = "Password for Redshift master DB user"
  type = string
  default = "Re_cord001!"
}
