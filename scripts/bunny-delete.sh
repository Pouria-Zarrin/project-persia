#!/bin/bash

# Bunny CDN Delete File Script
# Usage: ./bunny-delete.sh <remote-path>

# Configuration
STORAGE_ZONE="persia-media"
STORAGE_HOST="la.storage.bunnycdn.com"
API_KEY="${BUNNY_API_KEY:-}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ -z "$API_KEY" ]; then
    echo -e "${RED}Error: BUNNY_API_KEY environment variable is not set${NC}"
    exit 1
fi

if [ $# -lt 1 ]; then
    echo -e "${YELLOW}Usage: $0 <remote-path>${NC}"
    echo ""
    echo "Examples:"
    echo "  $0 images/old-photo.jpg"
    echo "  $0 videos/demo.mp4"
    exit 1
fi

REMOTE_PATH="$1"

echo -e "${YELLOW}Deleting: $REMOTE_PATH${NC}"

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    --request DELETE \
    --url "https://$STORAGE_HOST/$STORAGE_ZONE/$REMOTE_PATH" \
    --header "AccessKey: $API_KEY")

if [ "$HTTP_CODE" = "200" ]; then
    echo -e "${GREEN}Deleted successfully${NC}"
else
    echo -e "${RED}Failed to delete (HTTP $HTTP_CODE)${NC}"
    exit 1
fi
