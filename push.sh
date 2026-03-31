#!/bin/bash

# Get current timestamp for commit message
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Check for changes
if git diff-index --quiet HEAD --; then
    echo "ℹ️  No changes to commit"
    exit 0
fi

# Git operations
echo "🔄 Adding changes..."
git add .

echo "🔄 Committing..."
if git commit -m "Auto commit: $TIMESTAMP"; then
    echo "✅ Commit successful: $TIMESTAMP"

    echo "🔄 Pushing to remote..."
    if git push; then
        echo "✅ Push successful"
    else
        echo "❌ Push failed"
        exit 1
    fi
else
    echo "❌ Commit failed"
    exit 1
fi

clear
echo "✅ Auto commit and push completed: $TIMESTAMP"%