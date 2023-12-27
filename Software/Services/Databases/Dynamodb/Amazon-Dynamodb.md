# Amazon Dynamodb

Amazon DynamoDB is a fully managed NoSQL database service


```
aws --endpoint-url $url --no-sign-request s3 cp cmd.php s3://adserver/images/
```

List tables
```bash
aws dynamodb list-tables --endpoint-url  $URL --no-sign-request
```

Scan tables
```bash
aws dynamodb scan --table-name $table_name --endpoint-url $url --no-sign-request
```

Create simple a table with: [create-table](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/create-table.html)
```bash
aws --endpoint-url $url dynamodb create-table --table-name $tableName --attribute-definitions AttributeName=title,AttributeType=S AttributeName=data,AttributeType=S --key-schema AttributeName=title,KeyType=HASH  AttributeName=data,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=10 
```

Add with JSON a item to a table with: [put-item](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/put-item.html)
```bash
aws --endpoint-url $url dynamodb put-item --table-name alerts --item '{"title": {"S": "titlename"}, "data": {"S": "Some string goes here.."}}'
```


## References

[DynamoDB documentation](https://docs.aws.amazon.com/cli/latest/reference/dynamodb)