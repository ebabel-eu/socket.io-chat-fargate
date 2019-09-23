# Socket.IO Chat on AWS Fargate

A simple chat demo for socket.io that is to run on AWS ECR Registry and AWS Fargate.

Source: [Building a Socket.io chat app and deploying it using AWS Fargate](https://medium.com/containers-on-aws/building-a-socket-io-chat-app-and-deploying-it-using-aws-fargate-86fd7cbce13f)

## Initial setup

```
docker build -t chat .
docker run -d --name chat -p 3000:3000 chat
docker ps
```

## Deploy to AWS ECR

```
docker tag chat:latest ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/chat:latest
docker push ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/chat:latest
```

Note: `ACCOUNT_ID` is an integer. It can be found when logging in to AWS console, where username johndoe @ ACCOUNT_ID is in the top right corner. Do not use any hyphens.

## Specifiy an AWS region

If it's not already done on your machine, you need to configure which region to work with.

```
aws configure
```

You will also need your AWS Access Key ID, and your AWS Secret Access Key. The default output format can be json (default), text (useful for grep parsing), or table (human readable).

## Deploy to Fargate

```
aws cloudformation deploy --stack-name=production --template-file=recipes/public-vpc.yml --capabilities=CAPABILITY_IAM
```
