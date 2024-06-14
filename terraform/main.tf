# creating project test bucket
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


# creating main project bucket
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
  name = "covid19_db"   # Change the name to avoid conflict
}

# Define the AWS Glue Crawler for enigma_jhu folder
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


# Define the AWS Glue Crawler for hospital_beds folder
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


# Define the AWS Glue Crawler for country_code folder
resource "aws_glue_crawler" "countryCODE" {
  name = "country_code"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/static-datasets/csv/countrycode/"
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

# Define the AWS Glue Crawler for country_population folder
resource "aws_glue_crawler" "countyPOP" {
  name = "country_population"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/static-datasets/csv/CountyPopulation/"
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

# Define the AWS Glue Crawler for state_abv folder
resource "aws_glue_crawler" "stateABV" {
  name = "state_abv"
  role = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.covid_19.name
  s3_target {
    path = "s3://frank-covid-19-bucket/static-datasets/csv/state-abv/"
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

# Define the AWS Glue Crawler for states_daily folder
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

# Define the AWS Glue Crawler for us_daily folder
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

# Define the AWS Glue Crawler for us_total_latest folder
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

# Define the AWS Glue Crawler for us_county folder
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

# Define the AWS Glue Crawler for us_states folder
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

#####################################################################

// Configure IAM role with read-only access to S3. This role will be assigned to the Redshift cluster to read data from S3.
resource "aws_iam_role" "redshift_role" {
  name = "s3-redshift-role" // Changed name to avoid conflict
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "redshift.amazonaws.com"
      }
    }]
  })
}

// Configure Redshift cluster.
resource "aws_redshift_cluster" "redshift" {
  cluster_identifier   = "redshift-cluster"
  skip_final_snapshot  = true
  database_name        = "mydb"
  master_username      = "awsuser"
  master_password      = var.db_password
  node_type            = "dc2.large"
  cluster_type         = "single-node"
  publicly_accessible  = true
  iam_roles            = [aws_iam_role.redshift_role.arn]
  vpc_security_group_ids = [aws_security_group.sgs_redshift.id]
}

// Configure security group for Redshift allowing all inbound/outbound traffic
resource "aws_security_group" "sgs_redshift" {
  name = "sgs_redshift_covid_19" // Changed name to avoid conflict

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}