# Full Clean Up
To completely purge all Docker data—including stopped containers, unused networks, dangling images, build caches, and volumes—execute these commands in your terminal:

## 1. The Standard Deep Clean (Safe for Active Volumes)
Cleans stopped containers, unused networks, dangling images, and build caches:
```
docker system prune -a --volumes -f
```
-a: Removes all unused images, not just dangling ones.
--volumes: Deletes unattached persistent storage volumes.
-f: Forces execution without interactive confirmation prompts.

## 2. The Total Destruction Reset (Nuclear Option)
If you have running containers or stuck instances that system prune skips, use this sequence to forcefully terminate and eradicate everything:

```
# 1. Force stop all active containers
docker rm -f $(docker ps -aq) 2>/dev/null || true

# 2. Force remove all images
docker rmi -f $(docker images -q) 2>/dev/null || true

# 3. Delete all volumes
docker volume rm $(docker volume ls -q) 2>/dev/null || true

# 4. Remove all custom networks
docker network rm $(docker network ls -q) 2>/dev/null || true

# 5. Clear build cache
docker builder prune -a -f
```

## 3. Verify System Cleanup
Confirm that local disk usage for Docker is reset to zero:
```
docker system df
```
Expected Output:
```
Plaintext
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          0         0         0B        0B
Containers      0         0         0B        0B
Local Volumes   0         0         0B        0B
Build Cache     0         0         0B        0B
```