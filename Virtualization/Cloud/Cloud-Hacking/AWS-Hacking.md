
Get AWS CLI to interact with AWS through to third party application used in deployment context

```bash
sudo apt install awscli
aws 
# Configuration required!!
# Configure Access Key ID, AWS Secret, region, Output 
aws configure

# ls a s3 bucket
aws --endpoint-url http://s3.hostname.tld s3 ls
# No 
aws --endpoint-url http://s3.hostname.tld --no-sign-request s3 ls $


# s3 Subcommands
# Single Object operations
mv
cp
rm
# Directory and s3 operations
sync
mb
rb
ls
```
[AWS-CLI Subcommands](https://docs.aws.amazon.com/cli/latest/reference/)

Host enumeration 
```bash
# In a bucket?
# File system in the `/` will contain:
.aws 
# Check for credentials
# AWS Keys are commonly stored in environment variables
# Common place to find credentialss is in environment variables 
env  # Linux
set  # Windows 

```

[ScoutSuite](https://github.com/nccgroup/ScoutSuite) is Multi-Cloud Security Auditing Tool
