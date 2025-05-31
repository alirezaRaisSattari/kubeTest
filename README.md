# Kubernetes Application Deployment

This repository contains a Kubernetes-based application deployment setup with automated build and deployment scripts.

## Project Structure

```
.
├── backend/         # Backend application code
├── nginx/          # Nginx configuration and static files
├── scripts/        # Build and deployment scripts
│   ├── build.sh       # Script for building Docker images
│   ├── deploy.sh      # Script for deploying to Kubernetes
│   └── build-deploy.sh # Combined build and deploy script
```

## Available Scripts

### 1. Build Script (`build.sh`)

Builds all required Docker images for the application.

```bash
# Make the script executable
chmod +x build.sh

# Run the build script
./build.sh
```

This script will:

- Build the backend Docker image
- Build the Nginx Docker image
- Verify all images were built successfully

### 2. Deploy Script (`deploy.sh`)

Deploys the application to your Kubernetes cluster.

```bash
# Make the script executable
chmod +x deploy.sh

# Run the deploy script
./deploy.sh
```

This script will:

- Create necessary namespaces
- Apply Kubernetes configurations
- Deploy all application components
- Verify the deployment status

### 3. Build and Deploy Script (`build-deploy.sh`)

Combines both building and deployment in one command.

```bash
# Make the script executable
chmod +x build-deploy.sh

# Run the build and deploy script
./build-deploy.sh
```

This script will:

1. Build all Docker images
2. Deploy the application to Kubernetes
3. Verify the entire setup

## Troubleshooting

### Common Issues

1. **Image Build Issues**

   ```bash
   # Verify Docker build context
   ls -la backend/
   ls -la nginx/

   # Force rebuild without cache
   docker build --no-cache -t backend:latest backend/
   docker build --no-cache -t nginx:latest nginx/
   ```

2. **Deployment Issues**

   ```bash
   # Check pod status
   kubectl get pods -n system-user

   # View pod logs
   kubectl logs -n system-user -l app=backend
   kubectl logs -n system-user -l app=nginx
   ```

3. **Database Connection Issues**

   ```bash
   # Check PostgreSQL status
   kubectl get pods -n system-user -l app=postgres
   
   # View PostgreSQL logs
   kubectl logs -n system-user -l app=postgres
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

## Prerequisites

- Docker installed and running
- Kubernetes cluster (local or remote) configured
- `kubectl` CLI tool installed
- Access to container registry (if using remote cluster)

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License(i have license so i am bad ass)

This project is licensed under the MIT License - see the LICENSE file for details.
