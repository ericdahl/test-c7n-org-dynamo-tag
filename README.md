# test-c7n-org-dynamodb-tag

Test repo illustrating issue with c7n-org queries when using tags on DynamoDB


# Steps

## 1. Create two dynamodb tables, one with tags, one without

```
terraform init
terraform apply
```

## 2. Run docker-compose to run c7n and c7n-org

```
docker-compose up
```

### Example output

```
Attaching to test-c7n-org-dynamo-tag_c7n_1, test-c7n-org-dynamo-tag_c7n-org_1
c7n_1      | 2019-09-28 20:49:18,678: custodian.policy:INFO policy:missing_name_tag resource:dynamodb-table region:us-east-1 count:1 time:1.24
test-c7n-org-dynamo-tag_c7n_1 exited with code 0

c7n-org_1  | 2019-09-28 20:49:19,007: c7n_org:INFO Ran account:mytestaccount region:us-east-1 policy:missing_name_tag matched:2 time:2.15
c7n-org_1  | 2019-09-28 20:49:19,014: c7n_org:INFO Policy resource counts Counter({'missing_name_tag': 2})
test-c7n-org-dynamo-tag_c7n-org_1 exited with code 0

```

**Expected** Both tools report 1 untagged table

**Actual** c7n-org reports 2 untagged tables while c7n reports 1

Resources file:

```
root@00e6f8595bda:/# cat /tmp/c7n-org/mytestaccount/us-east-1/missing_name_tag/resources.json 
[
  {
    "AttributeDefinitions": [
      {
        "AttributeName": "id",
        "AttributeType": "S"
      }
    ],
    "TableName": "c7n-test",
    "KeySchema": [
      {
        "AttributeName": "id",
        "KeyType": "HASH"
      }
    ],
    "TableStatus": "ACTIVE",
    "CreationDateTime": "2019-09-28T20:16:31.626000+00:00",
    "ProvisionedThroughput": {
      "NumberOfDecreasesToday": 0,
      "ReadCapacityUnits": 1,
      "WriteCapacityUnits": 1
    },
    "TableSizeBytes": 0,
    "ItemCount": 0,
    "TableArn": "arn:aws:dynamodb:us-east-1:1234:table/c7n-test",
    "TableId": "0037cd5e-4f6a-4b5d-8dc1-c24db728ef47",
    "Tags": [],
    "c7n:MatchedFilters": [
      "tag:Name"
    ]
  },
  {
    "AttributeDefinitions": [
      {
        "AttributeName": "id",
        "AttributeType": "S"
      }
    ],
    "TableName": "c7n-test-without-name",
    "KeySchema": [
      {
        "AttributeName": "id",
        "KeyType": "HASH"
      }
    ],
    "TableStatus": "ACTIVE",
    "CreationDateTime": "2019-09-28T20:33:10.033000+00:00",
    "ProvisionedThroughput": {
      "NumberOfDecreasesToday": 0,
      "ReadCapacityUnits": 1,
      "WriteCapacityUnits": 1
    },
    "TableSizeBytes": 0,
    "ItemCount": 0,
    "TableArn": "arn:aws:dynamodb:us-east-1:1234:table/c7n-test-without-name",
    "TableId": "c8127c92-8598-4d44-b05e-9e7498f6d343",
    "Tags": [],
    "c7n:MatchedFilters": [
      "tag:Name"
    ]
  }
root@00e6f8595bda:/# 
```