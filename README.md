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

This will create a `deployment` stack, which will be the parent of the next setup, but this time this is done in the AWS Console web app.

- Navigate to `CloudFormation` in AWS Console
- Click on the button `Create stack`
- Choose to upload the recipe in `recipes\public-service.yml`
- Enter these details:
  - Stack name: chat
  - ContainerCpu: 256
  - ContainerMemory: 512
  - ContainerPort: 3000 (because the Node.js socket.io is running on port 3000 inside the Docker container)
  - DesiredCount: 1 (because that's enough for a small app being developed)
  - ImageUrl: ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/chat (this was setup earlier, use the same)
  - Path: *
  - Priority: 1
  - Role: (leave blank since this app doesn't connect to other AWS services like S3)
  - ServiceName: chat
  - Stack name: production (that's the name of the parent that was setup earlier using command line)
