#!/bin/bash

set -e

# Assign inputs to variables
RESOURCE_ID="$1"
DESCRIPTION="$2"
VERSION="$3"
MESSAGE="$4"
FILE="$5"
DOMAIN="$6"

# Build the redfetch command
CMD="redfetch push \"$RESOURCE_ID\""

if [ -n "$DESCRIPTION" ]; then
  CMD="$CMD --description \"$DESCRIPTION\""
fi

if [ -n "$VERSION" ]; then
  CMD="$CMD --version \"$VERSION\""
fi

if [ -n "$MESSAGE" ]; then
  CMD="$CMD --message \"$MESSAGE\""
fi

if [ -n "$FILE" ]; then
  CMD="$CMD --file \"$FILE\""
fi

if [ -n "$DOMAIN" ]; then
  CMD="$CMD --domain \"$DOMAIN\""
fi

# Ensure the API key is set
if [ -z "$REDGUIDES_API_KEY" ]; then
  echo "Error: REDGUIDES_API_KEY is not set."
  exit 1
fi

# Export the API key as an environment variable for redfetch
export REDGUIDES_API_KEY

# Execute the command
echo "Running command: $CMD"
eval $CMD