#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting build and deploy process...${NC}"

# Step 1: Build images
echo -e "${GREEN}Step 1: Building images...${NC}"
./build.sh
if [ $? -ne 0 ]; then
    echo -e "${RED}Build process failed${NC}"
    exit 1
fi

# Step 2: Deploy application
echo -e "${GREEN}Step 2: Deploying application...${NC}"
./deploy.sh
if [ $? -ne 0 ]; then
    echo -e "${RED}Deployment failed${NC}"
    exit 1
fi

echo -e "${GREEN}Build and deploy process completed!${NC}" 