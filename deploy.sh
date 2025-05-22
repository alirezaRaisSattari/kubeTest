#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Timeout values (in seconds)
POSTGRES_TIMEOUT=60  # 1 minutes
BACKEND_TIMEOUT=60   # 1 minutes
NGINX_TIMEOUT=60     # 1 minutes

echo -e "${YELLOW}Starting deployment...${NC}"

# Create namespace
echo -e "${GREEN}Creating namespace...${NC}"
kubectl apply -k base/

# Deploy PostgreSQL
echo -e "${GREEN}Deploying PostgreSQL...${NC}"
kubectl apply -k postgres/

# Wait for PostgreSQL to be ready
echo -e "${YELLOW}Waiting for PostgreSQL to be ready (timeout: ${POSTGRES_TIMEOUT}s)...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=postgres -n system-user --timeout=${POSTGRES_TIMEOUT}s; then
    echo -e "${RED}PostgreSQL failed to become ready within ${POSTGRES_TIMEOUT} seconds${NC}"
    echo -e "${YELLOW}Checking PostgreSQL pod status:${NC}"
    kubectl describe pod -l app=postgres -n system-user
    exit 1
fi

# Deploy Backend
echo -e "${GREEN}Deploying Backend...${NC}"
kubectl apply -k backend/

# Wait for Backend to be ready
echo -e "${YELLOW}Waiting for Backend to be ready (timeout: ${BACKEND_TIMEOUT}s)...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=backend -n system-user --timeout=${BACKEND_TIMEOUT}s; then
    echo -e "${RED}Backend failed to become ready within ${BACKEND_TIMEOUT} seconds${NC}"
    echo -e "${YELLOW}Checking Backend pod status:${NC}"
    kubectl describe pod -l app=backend -n system-user
    exit 1
fi

# Deploy Nginx
echo -e "${GREEN}Deploying Nginx...${NC}"
kubectl apply -k nginx/

# Wait for Nginx to be ready
echo -e "${YELLOW}Waiting for Nginx to be ready (timeout: ${NGINX_TIMEOUT}s)...${NC}"
if ! kubectl wait --for=condition=ready pod -l app=nginx -n system-user --timeout=${NGINX_TIMEOUT}s; then
    echo -e "${RED}Nginx failed to become ready within ${NGINX_TIMEOUT} seconds${NC}"
    echo -e "${YELLOW}Checking Nginx pod status:${NC}"
    kubectl describe pod -l app=nginx -n system-user
    exit 1
fi

# Get service information
echo -e "${GREEN}Deployment completed!${NC}"
echo -e "${YELLOW}Service Information:${NC}"
kubectl get svc -n system-user

echo -e "${YELLOW}Pod Status:${NC}"
kubectl get pods -n system-user

echo -e "${YELLOW}To access the application, use the NodePort shown above${NC}" 