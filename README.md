# Kubernetes Application Deployment

This repository contains Kubernetes manifests for deploying a full-stack application with PostgreSQL, Node.js backend, and Nginx frontend using Kustomize.

## Directory Structure

```
├── base/
│   ├── namespace.yaml
│   └── kustomization.yaml
├── postgres/
│   ├── secret.yaml
│   ├── pvc.yaml
│   ├── statefulset.yaml
│   ├── service.yaml
│   └── kustomization.yaml
├── backend/
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── init-container-script.sh
│   └── kustomization.yaml
├── nginx/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
├── deploy.sh
├── build.sh
├── cleanup.sh
├── README.md
└── BUILD.md
```

## Prerequisites

- Kubernetes cluster (Minikube or Docker Desktop)
- kubectl configured
- Docker installed

## Quick Start

1. Build the local images:
```bash
./build.sh
```

2. Deploy the application:
```bash
./deploy.sh
```

3. Clean up all resources:
```bash
./cleanup.sh
```

## Manual Deployment Steps

If you prefer to deploy manually, follow these steps:

1. Create the namespace:
```bash
kubectl apply -k base/
```

2. Deploy PostgreSQL:
```bash
kubectl apply -k postgres/
```

3. Deploy Backend:
```bash
kubectl apply -k backend/
```

4. Deploy Nginx:
```bash
kubectl apply -k nginx/
```

5. Check deployment status:
```bash
kubectl get pods -n system-user
```

## Accessing the Application

The application will be accessible through the Nginx NodePort service. Get the node port using:

```bash
kubectl get svc -n system-user nginx
```

## Notes

- Make sure to update the secrets with your own base64 encoded values
- Adjust resource limits and requests according to your needs
- The PostgreSQL StatefulSet uses persistent storage, ensure your cluster has the required storage class
- All resources are deployed in the `system-user` namespace
- The deployment uses Kustomize for better resource management 