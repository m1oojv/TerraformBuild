import boto3
from botocore.exceptions import ClientError

# Create a new SES resource and specify a region.
client = boto3.client('ses',region_name="ap-southeast-1")

# Try to send the email.
try:
    #Provide the contents of the email.
    response = client.send_email(
        Destination={
            'ToAddresses': [
                'yihui98@live.com',
            ],
        },
        Message={
            'Body': {
                'Html': {
                    'Charset': 'UTF-8',
                    'Data': 'This email was sent with Amazon SES.',
                },
            },
            'Subject': {
                'Charset': 'UTF-8',
                'Data': 'Amazon SES Test',
            },
        },
        SourceArn='arn:aws:ses:ap-southeast-1:075343395323:identity/protoslabs.sg',
        ReturnPathArn='arn:aws:ses:ap-southeast-1:075343395323:identity/protoslabs.sg',
        Source='yihui@protoslabs.sg',
        ReturnPath='yihui@protoslabs.sg'
    )
# Display an error if something goes wrong.	
except ClientError as e:
    print(e.response['Error']['Message'])
else:
    print("Email sent! Message ID:"),
    print(response['ResponseMetadata']['RequestId'])