resource "aws_s3_bucket" "covid__19" {
  bucket = var.bucket1name
}

resource "aws_s3_bucket_ownership_controls" "covid__19" {
  bucket = aws_s3_bucket.covid__19.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "covid__19" {
  bucket = aws_s3_bucket.covid__19.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "covid__19" {
  depends_on = [
    aws_s3_bucket_ownership_controls.covid__19,
    aws_s3_bucket_public_access_block.covid__19,
  ]

  bucket = aws_s3_bucket.covid__19.id
  acl    = "public-read"
}

resource "aws_s3_bucket" "covid_19" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "covid_19" {
  bucket = aws_s3_bucket.covid_19.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "covid_19" {
  bucket = aws_s3_bucket.covid_19.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "covid_19" {
  depends_on = [
    aws_s3_bucket_ownership_controls.covid_19,
    aws_s3_bucket_public_access_block.covid_19,
  ]

  bucket = aws_s3_bucket.covid_19.id
  acl    = "public-read"
}


# Define an IAM Role for the Glue Crawler
resource "aws_iam_role" "glue_role" {
  name = "s3-glue-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the Amazon S3 full access policy to the IAM role
resource "aws_iam_policy_attachment" "glue_s3_full_access" {
  name       = "glue-s3-role"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach the AWS Glue Console full access policy to the IAM role
resource "aws_iam_policy_attachment" "glue_console_full_access" {
   name       = "glue-s3-role"
   roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

# Attach the AWS Glue service role policy to the IAM role
resource "aws_iam_policy_attachment" "glue_service_role" {
  name       = "glue-s3-role"
  roles      = [aws_iam_role.glue_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Define an AWS Glue Database
resource "aws_glue_catalog_database" "covid_19" {
  name = "covid_19_db"
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "enigmaJHU" {
  name = "enigma_jhu"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  table_prefix = "enigma_jhu_"
  s3_target {
    path = "s3://frank-covid-19-bucket/enigma-jhu/"
  }
  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}


# Define the AWS Glue Crawler
resource "aws_glue_crawler" "hospitalBEDS" {
  name = "hospital_beds"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  table_prefix = "hospital_beds_"
  s3_target {
    path = "s3://frank-covid-19-bucket/rearc-usa-hospital-beds/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}


# Define the AWS Glue Crawler
resource "aws_glue_crawler" "countryCODE" {
  name = "country_code"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/static_datasets/csv/countrycode/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "countyPOP" {
  name = "country_population"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/static_datasets/csv/Countypopulation/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "stateABV" {
  name = "state_abv"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/static_datasets/csv/state-abv/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "statesDAILY" {
  name = "states_daily"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/rearc-covid-19-testing-data/csv/states_daily/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "usDAILY" {
  name = "us_daily"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/rearc-covid-19-testing-data/csv/us_daily/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "us_total_latest" {
  name = "us-total-latest"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/rearc-covid-19-testing-data/csv/us-total-latest/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "UScounty" {
  name = "us_county"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/enigma-nytimes-data-in-usa/csv/us_county/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

# Define the AWS Glue Crawler
resource "aws_glue_crawler" "USstates" {
  name = "us_states"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/enigma-nytimes-data-in-usa/csv/us_states/"
  }

  configuration = jsonencode({
    "Version": 1.0,
    "CrawlerOutput": {
      "Partitions": {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}