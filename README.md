# Socket.IO Chat on AWS FarGate

A simple chat demo for socket.io that is to run on AWS ECR Registry and AWS FarGate.

## How to use

ACCOUNT_ID is an integer. It can be found when logging in to AWS console, where username john @ ACCOUNT_ID is in the top right corner. Do not use any hyphens.

```
docker build -t chat .
docker run -d --name chat -p 3000:3000 chat
docker ps
docker tag chat:latest ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/chat:latest
docker push ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/chat:latest
```
