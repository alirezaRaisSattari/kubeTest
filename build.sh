#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting local build process...${NC}"

# Build Backend Image
echo -e "${GREEN}Building backend image...${NC}"
cd backend
docker build --no-cache -t backend:latest .
if [ $? -ne 0 ]; then
    echo -e "${RED}Backend image build failed${NC}"
    exit 1
fi
cd ..

# Build Nginx Image
echo -e "${GREEN}Building nginx image...${NC}"
cd nginx
docker build -t nginx:latest .
if [ $? -ne 0 ]; then
    echo -e "${RED}Nginx image build failed${NC}"
    exit 1
fi
cd ..

# Verify images were built
echo -e "${YELLOW}Verifying built images...${NC}"
docker images | grep -E 'backend|nginx'

echo -e "${GREEN}Build process completed!${NC}"
echo -e "${YELLOW}You can now run ./deploy.sh to deploy the application${NC}" 