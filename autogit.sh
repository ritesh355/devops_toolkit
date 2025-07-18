#!/bin/bash

PROJECT_NAME="dev_project"
REMOTE_URL=$1
DATE=$(date)
LOG_FILE="$HOME/.autogit_log.txt"

echo "📦 Starting AutoGit setup for: $PROJECT_NAME"

# Check if directory exists
if [ -d "$PROJECT_NAME" ]; then
  read -p "⚠️ Folder '$PROJECT_NAME' already exists. Do you want to overwrite it? (y/n): " choice
  if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    rm -rf "$PROJECT_NAME"
    echo "🗑️ Existing folder removed."
  else
    echo "❌ Operation cancelled."
    exit 1
  fi
fi

# Create project folder and initialize git
mkdir "$PROJECT_NAME" && cd "$PROJECT_NAME" || exit
git init
git branch -M main

# Create a README with project info
echo "# $PROJECT_NAME" > README.md
echo -e "📁 Project: $PROJECT_NAME\n🕒 Created: $DATE" >> README.md

# First commit
git add .
git commit -m "Initial commit by AutoGit"

# Log project creation
echo "$DATE - Created project '$PROJECT_NAME'" >> "$LOG_FILE"

# Optional: Push to remote if URL is provided
if [ -n "$REMOTE_URL" ]; then
  git remote add origin "$REMOTE_URL"
  git push -u origin main
  echo "$DATE - Pushed '$PROJECT_NAME' to remote repo" >> "$LOG_FILE"
fi

echo "✅ '$PROJECT_NAME' successfully initialized and logged!"

