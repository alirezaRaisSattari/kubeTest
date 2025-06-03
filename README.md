# Kubernetes Application Deployment

This repository contains a comprehensive Kubernetes-based application deployment setup that demonstrates modern cloud-native architecture principles. The project implements a scalable, maintainable, and production-ready application deployment infrastructure using Kubernetes.

## Features

### 1. Microservices Architecture

- **Backend Service**: A scalable backend application
- **Nginx Service**: Handles reverse proxy and static file serving
- **PostgreSQL Database**: Persistent data storage with proper volume management
- **Service Discovery**: Automatic service discovery and load balancing
- **Health Monitoring**: Built-in health checks and readiness probes

### 2. Infrastructure as Code

- **Kubernetes Manifests**: All infrastructure defined as code
- **Automated Deployment**: Scripts for consistent deployment across environments
- **Environment Separation**: Clear separation between different deployment environments
- **Resource Management**: Proper resource requests and limits defined

### 3. DevOps Features

- **Automated Build Pipeline**: Streamlined Docker image building process
- **Deployment Automation**: One-click deployment to Kubernetes clusters
- **Rolling Updates**: Zero-downtime deployments with rolling update strategy
- **Rollback Capability**: Easy rollback to previous versions if needed
- **Monitoring Ready**: Prepared for integration with monitoring tools

### 4. Security Features

- **Network Policies**: Defined network security rules
- **Secret Management**: Secure handling of sensitive information
- **RBAC Integration**: Role-Based Access Control ready
- **Security Contexts**: Proper security contexts for pods
- **TLS Support**: Ready for SSL/TLS configuration

## Project Structure

```
.
├── backend/         # Backend application and Kubernetes manifests
├── nginx/          # Nginx configuration and Kubernetes manifests
├── postgres/       # PostgreSQL database configuration and manifests
├── base/          # Base Kubernetes configurations and shared resources
├── build.sh       # Script for building Docker images
├── deploy.sh      # Script for deploying to Kubernetes cluster
├── cleanup.sh     # Script for cleaning up Kubernetes resources
├── build-and-deploy.sh # Combined script for building and deploying
└── docker-compose.yml  # Local development environment setup
```

### Directory and File Descriptions

#### Core Directories

1. **backend/**
   - Contains the backend application source code
   - Includes Kubernetes deployment manifests
   - Service configurations
   - ConfigMaps and Secrets definitions

2. **nginx/**
   - Nginx web server configuration files
   - Static file serving setup
   - Reverse proxy configurations
   - Kubernetes manifests for Nginx deployment

3. **postgres/**
   - PostgreSQL database configurations
   - Persistent volume claims
   - Database initialization scripts
   - Backup and recovery configurations

4. **base/**
   - Common Kubernetes resources
   - Shared configurations
   - Base templates for other components
   - Cross-cutting concerns (RBAC, NetworkPolicies, etc.)

#### Automation Scripts

1. **build.sh**

   ```bash
   # Handles Docker image building process
   - Builds backend application image
   - Builds Nginx image with configurations
   - Tags images appropriately
   - Performs basic validation checks
   ```

2. **deploy.sh**

   ```bash
   # Manages Kubernetes deployments
   - Creates required namespaces
   - Applies Kubernetes manifests
   - Sets up networking and storage
   - Verifies deployment status
   ```

3. **cleanup.sh**

   ```bash
   # Handles resource cleanup
   - Removes deployed applications
   - Cleans up namespaces
   - Removes persistent volumes (if specified)
   - Resets cluster state
   ```

4. **build-and-deploy.sh**

   ```bash
   # Combines build and deploy operations
   - Runs build script
   - Executes deployment script
   - Provides status updates
   - Handles errors and rollbacks
   ```

5. **docker-compose.yml**
   - Local development environment setup
   - Service definitions for local testing
   - Development-specific configurations
   - Easy-to-use local environment

## Architecture

### Components

1. **Frontend Proxy (Nginx)**
   - Serves as reverse proxy
   - Handles static file serving
   - Load balancing
   - SSL/TLS termination

2. **Backend Service**
   - RESTful API endpoints
   - Business logic implementation
   - Database interaction
   - Horizontally scalable

3. **Database (PostgreSQL)**
   - Persistent data storage
   - Data backup and recovery
   - High availability setup
   - Volume management

### Key Technical Features

1. **High Availability**
   - Multiple replicas for critical services
   - Auto-healing capabilities
   - Load balancing across pods
   - Health monitoring and automatic recovery

2. **Scalability**
   - Horizontal pod autoscaling
   - Resource-based scaling
   - Configurable resource limits
   - Load-based scaling policies

3. **Monitoring & Logging**
   - Prometheus metrics ready
   - Structured logging
   - Tracing support
   - Performance monitoring

4. **Backup & Recovery**
   - Database backup automation
   - Point-in-time recovery
   - Volume snapshots
   - Disaster recovery procedures

## Configuration

### Environment Variables

The application supports various environment variables for configuration:

```bash
# Database Configuration
DB_HOST=postgres
DB_PORT=5432
DB_NAME=myapp
DB_USER=postgres
DB_PASSWORD=<secret>

# Application Configuration
APP_PORT=8080
APP_ENV=production
LOG_LEVEL=info

# Nginx Configuration
NGINX_PORT=80
NGINX_SSL_PORT=443
```

### Resource Requirements

Minimum cluster requirements:

- Kubernetes 1.19+
- 2 CPU cores
- 4GB RAM
- 20GB storage

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
