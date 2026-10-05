<<<<<<< HEAD
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
=======
# Docker Hands-On Tutorial

Here you will learn the core foundations of containerization by building, testing, and running apps like Python and Java alongside a PostgreSQL database using essential Docker CLI commands. 

You will also cover Dockerfile best practices, database initialization scripts, and custom image builds—setting the stage for multi-container orchestration.

https://www.docker.com/products/docker-hub/

### Colima
Colima is a container runtime for macOS (and Linux) with minimal setup. It supports Docker, Containerd, and Kubernetes out of the box.

https://colima.run/docs/getting-started/


## 1. Engine & Daemon Status
Verify that the Docker daemon is running and check its global state.

### Check if Docker daemon is responsive and view runtime metrics
```
docker info
```

### Display client and server version information
```
docker version
```

### Check system resource utilization (disk usage by containers, images, volumes)
```
docker system df
```

## 2. Quick Connectivity Test
Run a lightweight, self-contained container to confirm Docker can pull images and execute containers successfully.
```
docker run --rm hello-world
```

## 3. Container Status & Health Check
Inspect active, stopped, or failing containers.

### List all RUNNING containers
```
docker ps
```

### List ALL containers (including exited and created)
```
docker ps -a
```

### View real-time resource usage (CPU, Memory, I/O) for running containers
```
docker stats --no-stream
```

## 4. Detached Background Container (Loops System Stats)
Runs in the background (-d), stays active for 60 seconds (or indefinitely), and logs timestamped system information every 5 seconds.
```
docker run -d --name alpine-test alpine sh -c "
  echo '=== Container Started ==='
  uname -a
  while true; do
    echo \"[$(date)] Uptime: \$(uptime) | Mem Free: \$(free -m | grep Mem | awk '{print \$4}')MB\"
    sleep 5
  done
"
```

### View the generated info logs
```
docker logs -f alpine-test
```

### Check container status
```
docker ps -f name=alpine-test
```

### Tail live logs in real-time
```
docker logs -f --tail 50 alpine-test
```

### Inspect detailed configuration, networking, and mount metadata
```
docker inspect alpine-test
```

### Check processes running inside a specific container
```
docker top alpine-test
```

### Stop and remove when done
```
docker stop alpine-test && docker rm alpine-test
```

## 5. NGINX / HTTP Echo (Stays Alive with Port Mapping)
If you want to test networking and keep a container running indefinitely while showing host and process info:
```
docker run -d --name web-test -p 9090:80 nginx:alpine
```

### Verify status 
```
docker ps
```

### Test response 
```
http://localhost:9090
```

### Clean up 
```
docker rm -f web-test
>>>>>>> 1828357 (Initial commit)
```