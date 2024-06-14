# Output name of crawler
output "enigmaJHU" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.enigmaJHU.name
}

# Output name of crawler
output "hospitalBEDS" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.hospitalBEDS.name
}

# Output name of crawler
output "countryCODE" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.countryCODE.name
}

# Output name of crawler
output "countyPOP" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.countyPOP.name
}

# Output name of crawler
output "stateABV" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.stateABV.name
}

# Output name of crawler
output "statesDAILY" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.statesDAILY.name
}

# Output name of crawler
output "usDAILY" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.usDAILY.name
}

# Output name of crawler
output "us_total_latest" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.us_total_latest.name
}

# Output name of crawler
output "UScounty" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.UScounty.name
}

# Output name of crawler
output "USstates" {
  description = "Name assigned to crawler"
  value = aws_glue_crawler.USstates.name
}


# Output hostname of Redshift
output "redshift_cluster_hostname" {
  description = "ID of the Redshift instance"
  value = replace(
    aws_redshift_cluster.redshift.endpoint,
    format(":%s", aws_redshift_cluster.redshift.port), ""
  )
}

# Output port of Redshift
output "redshift_port" {
  description = "Port of Redshift cluster"
  value = aws_redshift_cluster.redshift.port
}

# Output Redshift database
output "redshift_database" {
  description = "Database of Redshift cluster"
  value = aws_redshift_cluster.redshift.database_name
}

# Output Redshift password
output "redshift_password" {
  description = "Password of Redshift cluster"
  value = var.db_password
}

# Output Redshift username
output "redshift_username" {
  description = "Username of Redshift cluster"
  value = aws_redshift_cluster.redshift.master_username
}

# Output Role assigned to Redshift
output "redshift_role" {
  description = "Role assigned to Redshift"
  value = aws_iam_role.redshift_role.name
}

# Output Account ID of AWS
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
