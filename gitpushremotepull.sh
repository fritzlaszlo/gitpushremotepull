#!/bin/bash

# Define colors and reset
GREEN='\033[0;32m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
RESET='\033[0m'

# Load environment variables from .env file
if [ -f .env ]; then
    source .env
else
    echo -e "${RED}🚨 Error: .env file not found!${RESET}"
    exit 1
fi

# Check if required variables are set
if [ -z "$SSH_USER" ] || [ -z "$SSH_HOST" ] || [ -z "$REMOTE_PATH" ]; then
    echo -e "${RED}🚨 Error: Missing required environment variables.${RESET}"
    echo -e "${RED}Please make sure SSH_USER, SSH_HOST, and REMOTE_PATH are defined in your .env file.${RESET}"
    exit 1
fi

# Get the current branch
CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)

# Check if a branch was provided as an argument
if [ "$1" != "" ]; then
    BRANCH_TO_PUSH=$1
else
    BRANCH_TO_PUSH=$CURRENT_BRANCH
fi

echo -e "${PURPLE}🚀 Pushing to origin/$BRANCH_TO_PUSH...${RESET}"
git push origin $BRANCH_TO_PUSH

# Check if git push was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}🚨 Error: Git push failed!${RESET}"
    exit 1
fi

echo -e "${GREEN}✅ Git push successful.${RESET}"
echo -e "${PURPLE}🔄 Connecting to remote host to update...${RESET}"

# Set color variables for the remote session
REMOTE_GREEN="\\033[0;32m"
REMOTE_PURPLE="\\033[0;35m"
REMOTE_RESET="\\033[0m"

# SSH to remote and perform git operations
ssh $SSH_USER@$SSH_HOST "cd $REMOTE_PATH && \
                         echo -e \"${REMOTE_PURPLE}🔍 Fetching latest changes...${REMOTE_RESET}\" && \
                         git fetch origin && \
                         echo -e \"${REMOTE_PURPLE}⚙️ Resetting to origin/${BRANCH_TO_PUSH}...${REMOTE_RESET}\" && \
                         git reset --hard origin/${BRANCH_TO_PUSH} && \
                         echo -e \"${REMOTE_GREEN}✅ Remote repository updated successfully!${REMOTE_RESET}\""

if [ $? -ne 0 ]; then
    echo -e "${RED}🚨 Error: Remote update failed!${RESET}"
    exit 1
fi

echo -e "${GREEN}🎉 All operations completed successfully!${RESET}" 