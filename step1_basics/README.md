# Docker Basics

Start with essential Docker CLI commands. 

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
```