import configparser

def read_config():
    config = configparser.ConfigParser()
    config.read('config.ini')
    
    aws_config = {
        'aws_access_key_id': config.get('aws', 'AWS_ACCESS_KEY'),
        'aws_secret_access_key': config.get('aws', 'AWS_SECRET_KEY'),
        'region_name': config.get('aws', 'AWS_REGION')
    }
    
    athena_config = {
        'database': config.get('athena', 'SCHEMA_NAME'),
        's3_output_location': config.get('athena', 'S3_STAGING_DIR')
    }
    
    return aws_config, athena_config