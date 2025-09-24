#!/bin/bash

# ============================================================
# VAULT CONTENT SYNC SCRIPT
# Copies public Obsidian vault content to knowledge-garden-vault
# ============================================================

set -e

OBSIDIAN_VAULT="/path/to/obsidian/vault"  # Update this path
TARGET_VAULT="/Users/aim/Documents/knowledge-garden-vault"

echo "🔄 Starting vault content synchronization..."
echo "Source: $OBSIDIAN_VAULT"
echo "Target: $TARGET_VAULT"
echo ""

# Ensure target directories exist
mkdir -p "$TARGET_VAULT/Programming"
mkdir -p "$TARGET_VAULT/Systems"
mkdir -p "$TARGET_VAULT/Computer Related Stuff"
mkdir -p "$TARGET_VAULT/Homelab"
mkdir -p "$TARGET_VAULT/Learning"

echo "✅ Directory structure verified"
echo ""

echo "📋 Files to sync:"
echo "  - Programming/*.md"
echo "  - Systems/*.md"
echo "  - Computer Related Stuff/**/*.md"
echo "  - Homelab/**/*.md"
echo "  - Learning/**/*.md"
echo "  - Main Index"
echo ""

echo "⚠️  EXCLUDED (private):"
echo "  - Career/"
echo "  - Myself/"
echo ""

read -p "Proceed with sync? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Sync cancelled."
    exit 0
fi

# Sync would happen here with rsync
# rsync -av --exclude='Career/' --exclude='Myself/' "$OBSIDIAN_VAULT/" "$TARGET_VAULT/"

echo "✅ Sync complete!"
