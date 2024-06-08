import boto3
import config
import pandas as pd
from io import StringIO
import time

def run_query(client, query, covid_19_db, output):
    response = client.start_query_execution(
        QueryString=query,
        QueryExecutionContext={'Database': covid_19_db},
        ResultConfiguration={'OutputLocation': output}
    )
    
    query_execution_id = response['QueryExecutionId']
    status = 'RUNNING'
    
    while status in ['RUNNING', 'QUEUED']:
        response = client.get_query_execution(QueryExecutionId=query_execution_id)
        status = response['QueryExecution']['Status']['State']
        if status in ['SUCCEEDED', 'FAILED', 'CANCELLED']:
            break
        time.sleep(1)
    
    if status == 'SUCCEEDED':
        result = client.get_query_results(QueryExecutionId=query_execution_id)
        rows = result['ResultSet']['Rows']
        headers = [col['VarCharValue'] for col in rows[0]['Data']]
        data = [[col.get('VarCharValue', None) for col in row['Data']] for row in rows[1:]]
        return pd.DataFrame(data, columns=headers)
    else:
        raise Exception(f"Query failed with status: {status}")

if __name__ == "__main__":
    aws_config, athena_config = config.read_config()
    
    session = boto3.Session(
        aws_access_key_id=aws_config['aws_access_key_id'],
        aws_secret_access_key=aws_config['aws_secret_access_key'],
        region_name=aws_config['region_name']
    )
    
    athena_client = session.client('athena')
    
    query = "SELECT * FROM enigma_jhu_enigma_jhu LIMIT 10;"
    try:
        df = run_query(athena_client, query, athena_config['database'], athena_config['s3_output_location'])
        print(df)
    except Exception as e:
        print(f"Error: {e}")