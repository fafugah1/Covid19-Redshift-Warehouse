aws s3 cp s3://covid19-lake/enigma-jhu/csv/ s3://frank-covid-19-bucket/enigma-jhu/csv/ --recursive

aws s3 cp s3://covid19-lake/enigma-nytimes-data-in-usa/csv/ s3://frank-covid-19-bucket/enigma-nytimes-data-in-usa/csv/ --recursive

aws s3 cp s3://covid19-lake/rearc-covid-19-testing-data/csv/ s3://frank-covid-19-bucket/rearc-covid-19-testing-data/csv/ --recursive

aws s3 cp s3://covid19-lake/rearc-usa-hospital-beds/json/ s3://frank-covid-19-bucket/rearc-usa-hospital-beds/json/ --recursive

aws s3 cp s3://covid19-lake/static-datasets/csv/ s3://frank-covid-19-bucket/static-datasets/csv --recursive
