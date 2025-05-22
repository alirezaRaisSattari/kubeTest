# Local Build and Deployment Guide

This guide provides detailed steps for building and deploying the application components locally.

## Build Process

### Using build.sh (Recommended)

The easiest way to build all images is using the provided build script:

```bash
# Make the script executable
chmod +x build.sh

# Run the build script
./build.sh
```

The script will:
1. Build the backend image
2. Build the nginx image
3. Verify all images were built successfully

### Manual Build Steps (Alternative)

If you need to build images individually, you can follow these steps:

#### 1. Build Backend Image

```bash
# Navigate to the backend directory
cd backend

# Build the Docker image
docker build -t backend:latest .
```

#### 2. Build Nginx Image

```bash
# Navigate to the nginx directory
cd nginx

# Build the Docker image
docker build -t nginx:latest .
```

## Troubleshooting Guide

### 1. Image Build Issues

If the build script fails:
```bash
# Check if build.sh is executable
ls -l build.sh

# Run build.sh with bash explicitly
bash build.sh

# Check Docker build context
ls -la backend/
ls -la nginx/

# Verify Dockerfile syntax
docker build --no-cache -t backend:latest backend/
docker build --no-cache -t nginx:latest nginx/
```

### 2. Deployment Issues

If pods are in CrashLoopBackOff:
```bash
# Check pod logs
kubectl logs -n system-user -l app=backend
kubectl logs -n system-user -l app=nginx

# Verify image exists in cluster
kubectl describe pod -n system-user -l app=backend | grep Image
kubectl describe pod -n system-user -l app=nginx | grep Image

# Check if code is properly built
docker run --rm backend:latest ls /app
docker run --rm nginx:latest ls /usr/share/nginx/html
```

### 3. Database Connection Issues

If backend can't connect to PostgreSQL:
```bash
# Check PostgreSQL pod status
kubectl get pods -n system-user -l app=postgres

# Verify PostgreSQL logs
kubectl logs -n system-user -l app=postgres

# Test database connection
kubectl exec -n system-user -it $(kubectl get pod -n system-user -l app=backend -o jsonpath='{.items[0].metadata.name}') -- pg_isready -h postgres -p 5432
```

## Best Practices

1. Always use specific version tags in production
2. Implement proper health checks
3. Use secrets for sensitive information
4. Set appropriate resource limits
5. Implement proper logging
6. Use init containers for dependency checks
7. Implement proper backup strategies
8. Use proper security contexts
9. Implement proper monitoring
10. Use proper network policies