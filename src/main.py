import boto3
import config
import pandas as pd
from io import StringIO
import time

# create an athena client
def create_athena_client():
    return boto3.client(
        "athena",
        aws_access_key_id=aws_config['aws_access_key_id'],
        aws_secret_access_key=aws_config['aws_secret_access_key'],
        #aws_session_token=aws_config.get('aws_session_token'),  # Include session token if available
        region_name=aws_config['region_name']
    )

# run a query on athena
def start_query_execution(client):
    return client.start_query_execution(
        QueryString="SELECT * FROM enigma_jhu_enigma_jhu",
        QueryExecutionContext={"Database": athena_config['database']},
        ResultConfiguration={
            "OutputLocation": athena_config['s3_staging_dir'],
        },
    )

# query execution message
def wait_for_query_to_complete(client, query_execution_id):
    while True:
        response = client.get_query_execution(QueryExecutionId=query_execution_id)
        status = response['QueryExecution']['Status']['State']
        if status in ['SUCCEEDED', 'FAILED', 'CANCELLED']:
            break
        time.sleep(1)  # Increase sleep time to reduce the number of API calls

# download query results and save results in an output location on s3 bucket
def download_query_results(query_execution_id):
    temp_file_location = "athena_query_results.csv"
    s3_client = boto3.client(
        "s3",
        aws_access_key_id=aws_config['aws_access_key_id'],
        aws_secret_access_key=aws_config['aws_secret_access_key'],
        #aws_session_token=aws_config.get('aws_session_token'),  # Include session token if available
        region_name=aws_config['region_name']
    )
    s3_client.download_file(
        aws_config['s3_bucket'].split('/')[2],  # Extract bucket name from the S3 path
        f"{athena_config['s3_staging_dir']}/{query_execution_id}.csv",
        temp_file_location,
    )
    return temp_file_location

# load the saved query results in a pandas DataFrame
def load_results_to_dataframe(file_location):
    return pd.read_csv(file_location)

def main():
    athena_client = create_athena_client()
    query_response = start_query_execution(athena_client)
    query_execution_id = query_response["QueryExecutionId"]
    wait_for_query_to_complete(athena_client, query_execution_id)
    temp_file_location = download_query_results(query_execution_id)
    df = load_results_to_dataframe(temp_file_location)
    print(df)

if __name__ == "__main__":
    aws_config, athena_config = config.read_config()
    main()