# Dockerfile

Dockerfile is a plain-text configuration file containing sequential instructions that Docker executes to build an immutable container image.

In this examples the Dockerfile serves as the build specification for both the Python apps. Instead of manually installing Python packages, copying code, or configuring web servers in a running shell every time, the Dockerfile codifies the runtime environment into a repeatable build artifact.

![dockerfile](utils_srcs/rsc_dockerfile.png)

## Core Mechanics of a Dockerfile

Base Image (FROM): Defines the starting operating system and language runtime layer (e.g., python:3.10-slim).

Layer Caching: Every directive (COPY, RUN, ENV) creates an intermediate read-only image layer. Docker caches these layers; if requirements.txt does not change, Docker skips re-installing dependencies during subsequent builds.

Execution Context: Commands inside the Dockerfile run during the image build phase (docker build), whereas ENTRYPOINT or CMD directives run when the container initializes (docker run).

## Build and run a Docker image
Navigate to the directory `bash_app` and run
```
docker build -t my-python-app .

docker run -it --rm --name my-running-app my-python-app

docker stop my-python-app && docker rm my-python-app
```

## Build and launch a Web App with Python 

### Step 1: Built Image
Navigate to the directory `web_app` containing the Dockerfile and run
```
docker build -f Dockerfile -t python-web-demo:v1 .
```

### Step 2: Verify the Built Image
```
docker images python-web-demo
```

### Step 3: Run the Container
Map container port 5000 to host port 8080
```
docker run -d \
  --name python-web-demo \
  -p 8585:5000 \
  python-web-demo:v1

docker exec -it python-web-demo bash
```

### Step 4: Test Access
Open your web browser or execute curl
```
curl http://localhost:8585
```

# Rebuild or recreate
Now lets update the web_app/templates/index.html, resize image file to 400px x 80px. Then  rebuild or recreate. Docker containers use immutable image layers. Edits on your local host will not sync to the container automatically.
```
docker build -t python-web-demo:v2 .

docker rm -f python-web-demo

docker run -d \
  --name python-web-demo \
  -p 8585:5000 \
  python-web-demo:v2
```

### Stop and remove the container
```
docker rm -f python-web-demo

docker rmi -f $(docker images "python-web-demo" -q)

docker images | grep python-web-demo
```