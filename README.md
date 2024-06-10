# Covid-19 Redshift Warehouse Project

![Covid19 Redshift Warehouse Project with Terraform](Covid19-DE-Project-Architecture.png)
> Architecture Diagram

## Project Overview

As a prospective Data Engineer, I wish to use this project to exhibit the
knowledge I have acquired over the past few months of studying. 

The main goal of the project is to build infrastructure on AWS with the use of code. Also, I will show how to seemlessly move data from one to another within this infrastructure, query and also do some transformations.

## Setup Imstructions

### Prerequisities

+ Python 3.10 (any version of python >= 3.6)
+ AWS account ** (Iam account preferrable) ** and you have to install [aws cli v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
+ You also have to install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli)

### Steps to follow

1. Use aws cli to configure your aws credentials:
```
aws configure
'AWS_ACCESS_KEY'
'AWS_SECRET_KEY'
'AWS_REGION'

```