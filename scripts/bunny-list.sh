#!/bin/bash

# Bunny CDN List Files Script
# Usage: ./bunny-list.sh [remote-folder]

# Configuration
STORAGE_ZONE="persia-media"
STORAGE_HOST="la.storage.bunnycdn.com"
API_KEY="${BUNNY_API_KEY:-}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ -z "$API_KEY" ]; then
    echo -e "${RED}Error: BUNNY_API_KEY environment variable is not set${NC}"
    exit 1
fi

REMOTE_FOLDER="${1:-}"

echo -e "${GREEN}Bunny CDN File Listing${NC}"
echo "================================"
echo "Storage Zone: $STORAGE_ZONE"
echo "Folder: ${REMOTE_FOLDER:-'(root)'}"
echo "================================"
echo ""

# List files via API
RESPONSE=$(curl -s \
    --request GET \
    --url "https://$STORAGE_HOST/$STORAGE_ZONE/$REMOTE_FOLDER/" \
    --header "AccessKey: $API_KEY")

# Check for errors
if echo "$RESPONSE" | grep -q "Unauthorized"; then
    echo -e "${RED}Error: Unauthorized - check your API key${NC}"
    exit 1
fi

# Parse and display
echo "$RESPONSE" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if not data:
        print('(empty folder)')
    else:
        for item in data:
            name = item.get('ObjectName', 'unknown')
            is_dir = item.get('IsDirectory', False)
            size = item.get('Length', 0)

            if is_dir:
                print(f'  📁 {name}/')
            else:
                # Format size
                if size < 1024:
                    size_str = f'{size} B'
                elif size < 1024*1024:
                    size_str = f'{size/1024:.1f} KB'
                elif size < 1024*1024*1024:
                    size_str = f'{size/(1024*1024):.1f} MB'
                else:
                    size_str = f'{size/(1024*1024*1024):.2f} GB'
                print(f'  📄 {name} ({size_str})')
except json.JSONDecodeError:
    print('Error parsing response')
except Exception as e:
    print(f'Error: {e}')
"
