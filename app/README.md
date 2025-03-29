# Hello World API

Just a quick REST API I built with FastAPI. Nothing fancy, but it gets the job done for basic testing and demo purposes.

## What it does

This thing gives you three endpoints:

- `/hello_world` - Just spits out a hello world message in JSON
- `/current_time` - Gives you the current time and says hello to whatever name you pass in
- `/healthcheck` - Useful for making sure this thing is still alive

I've set it up to log all requests as JSON to stdout so you can see what's happening.

## Building the Docker image

Build it like this:

```bash
# From the project folder
docker build -t hello-world-api .
```

I used a multi-stage build to keep the image small. Also runs as a non-root user because security and stuff.

## Running locally

After building, run it with:

```bash
docker run -p 3000:3000 hello-world-api
```

Then hit these endpoints in your browser or with curl:
- http://localhost:3000/hello_world
- http://localhost:3000/current_time?name=YourName
- http://localhost:3000/healthcheck

## Pushing to ECR

To get this into ECR:

1. Log in to AWS:
   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
   ```

2. Tag it:
   ```bash
   docker tag hello-world-api:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/hello-world-api:latest
   ```

3. Push it:
   ```bash
   docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/hello-world-api:latest
   ```

Obviously change the account number, region, etc. as needed.
You can also use deploy-ecr.sh script

```chmod +x deploy-ecr.sh`
./deploy-ecr.sh
```

## Troubleshooting

If something's broken:
- Check if the ports match up
- Make sure your firewall isn't blocking stuff
- Check if the container is actually running with `docker ps`

For logs:
```bash
docker logs <container_id>
```
