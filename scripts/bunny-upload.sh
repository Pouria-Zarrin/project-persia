#!/bin/bash

# Bunny CDN Bulk Upload Script
# Usage: ./bunny-upload.sh <local-folder> <remote-folder>
# Example: ./bunny-upload.sh ./media/images images/gallery

# Configuration
STORAGE_ZONE="persia-media"
STORAGE_HOST="la.storage.bunnycdn.com"
API_KEY="${BUNNY_API_KEY:-}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if API key is set
if [ -z "$API_KEY" ]; then
    echo -e "${RED}Error: BUNNY_API_KEY environment variable is not set${NC}"
    echo ""
    echo "Set it with:"
    echo "  export BUNNY_API_KEY='your-storage-api-key'"
    echo ""
    echo "Or run with:"
    echo "  BUNNY_API_KEY='your-key' ./bunny-upload.sh <local-folder> <remote-folder>"
    exit 1
fi

# Check arguments
if [ $# -lt 1 ]; then
    echo -e "${YELLOW}Usage: $0 <local-folder> [remote-folder]${NC}"
    echo ""
    echo "Arguments:"
    echo "  local-folder   - Path to local folder containing files to upload"
    echo "  remote-folder  - (Optional) Remote folder path in Bunny storage"
    echo ""
    echo "Examples:"
    echo "  $0 ./photos                    # Upload to root"
    echo "  $0 ./photos images/gallery     # Upload to images/gallery/"
    echo "  $0 ./videos videos             # Upload to videos/"
    exit 1
fi

LOCAL_FOLDER="$1"
REMOTE_FOLDER="${2:-}"

# Validate local folder exists
if [ ! -d "$LOCAL_FOLDER" ]; then
    echo -e "${RED}Error: Local folder '$LOCAL_FOLDER' does not exist${NC}"
    exit 1
fi

# Count files
FILE_COUNT=$(find "$LOCAL_FOLDER" -type f | wc -l)
if [ "$FILE_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No files found in '$LOCAL_FOLDER'${NC}"
    exit 0
fi

echo -e "${GREEN}Bunny CDN Bulk Upload${NC}"
echo "================================"
echo "Storage Zone: $STORAGE_ZONE"
echo "Local Folder: $LOCAL_FOLDER"
echo "Remote Folder: ${REMOTE_FOLDER:-'(root)'}"
echo "Files to upload: $FILE_COUNT"
echo "================================"
echo ""

# Upload counter
UPLOADED=0
FAILED=0

# Upload each file
find "$LOCAL_FOLDER" -type f | while read -r FILE; do
    # Get relative path from local folder
    RELATIVE_PATH="${FILE#$LOCAL_FOLDER/}"

    # Build remote path
    if [ -n "$REMOTE_FOLDER" ]; then
        REMOTE_PATH="$REMOTE_FOLDER/$RELATIVE_PATH"
    else
        REMOTE_PATH="$RELATIVE_PATH"
    fi

    # Get file size for display
    FILE_SIZE=$(du -h "$FILE" | cut -f1)

    echo -n "Uploading: $RELATIVE_PATH ($FILE_SIZE)... "

    # Upload via Bunny API
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
        --request PUT \
        --url "https://$STORAGE_HOST/$STORAGE_ZONE/$REMOTE_PATH" \
        --header "AccessKey: $API_KEY" \
        --header "Content-Type: application/octet-stream" \
        --data-binary "@$FILE")

    if [ "$HTTP_CODE" = "201" ] || [ "$HTTP_CODE" = "200" ]; then
        echo -e "${GREEN}OK${NC}"
        ((UPLOADED++))
    else
        echo -e "${RED}FAILED (HTTP $HTTP_CODE)${NC}"
        ((FAILED++))
    fi
done

echo ""
echo "================================"
echo -e "Upload complete: ${GREEN}$UPLOADED succeeded${NC}, ${RED}$FAILED failed${NC}"
echo ""
echo "Your files are available at:"
echo "  https://persia-cdn.b-cdn.net/${REMOTE_FOLDER:-''}"
