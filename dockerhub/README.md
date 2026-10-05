# Docker Hub

World's largest public software artifact registry and distribution platform, managing, and sharing Docker images. 

https://hub.docker.com/


## Useful links

https://app.docker.com/signup

https://hub.docker.com/search

https://hub.docker.com/_/python


## Pull and save localy Docker images
```
docker pull python

docker pull python:3.11.17-trixie
```

## Build and run the Docker images
Navigate to the directory bash_app and run
```
docker build -t my-python-app .

docker run -it --rm --name my-running-app my-python-app

docker stop my-python-app && docker rm my-python-app
```

## Build and launch a web Python app with a Dockerfile

### Step 1: Built Image
Navigate to the directory web_app containing the Dockerfile and run
```
docker build -f Dockerfile_python -t python-web-demo:v1 .
```

### Step 2: Verify the Built Image
```
docker images python-web-demo:v1
```

### Step 3: Run the Container
Map container port 5000 to host port 8080
```
docker run -d \
  --name python-web-demo \
  -p 8080:5000 \
  python-web-demo:v1
```

### Step 4: Test Access
Open your web browser or execute curl
```
curl http://localhost:8080
```

#### View live container logs
```
docker logs python-web-demo
```

### Inspect processes running inside the container
```
docker top python-web-demo
```

### Open an interactive shell inside the running Python container
```
docker exec -it python-web-demo bash
```

### Stop and remove the container
```
docker stop python-web-demo && docker rm python-web-demo
<<<<<<< HEAD
```
=======
```
>>>>>>> 1828357 (Initial commit)
