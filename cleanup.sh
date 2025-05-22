#!/bin/bash

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting cleanup...${NC}"

# Delete all resources in the namespace
echo -e "${RED}Deleting all resources in system-user namespace...${NC}"
kubectl delete -k nginx/
kubectl delete -k backend/
kubectl delete -k postgres/
kubectl delete -k base/

echo -e "${YELLOW}Cleanup completed!${NC}" 