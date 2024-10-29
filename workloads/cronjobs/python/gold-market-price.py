import requests
import boto3
import os

access_token = os.environ['GOLD_API_ACCESS_TOKEN']

headers = {"x-access-token": access_token}
response = requests.get("https://www.goldapi.io/api/XAU/USD", headers=headers)
json_out = response.json()

output = "24k Gold: "+str(json_out["price_gram_24k"])+"\n22k Gold: "+str(json_out["price_gram_22k"])+"\n21k Gold: "+str(json_out["price_gram_21k"])+"\n20k Gold: "+str(json_out["price_gram_20k"])+"\n18k Gold: "+str(json_out["price_gram_18k"])+"\n16k Gold: "+str(json_out["price_gram_16k"])+"\n14k Gold: "+str(json_out["price_gram_14k"])+"\n10k Gold: "+str(json_out["price_gram_10k"])

sns_client = boto3.client("sns")
response = sns_client.publish(
    TopicArn='arn:aws:sns:ap-south-1:975050065855:gold-price',
    Message=output,
    Subject='Indian Gold Market Prices',
)

if response["ResponseMetadata"]["HTTPStatusCode"] == 200:
    print("Email Sent Successfully.")