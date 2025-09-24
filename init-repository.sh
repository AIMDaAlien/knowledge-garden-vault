#!/bin/bash

# ============================================================
# KNOWLEDGE GARDEN VAULT - GIT INITIALIZATION SCRIPT
# ============================================================
# This script initializes a dual-branch Git repository with:
# - main branch: GitHub-based production deployment
# - local-dev branch: MCP hybrid development environment
# ============================================================

set -e  # Exit on any error

VAULT_DIR="/Users/aim/Documents/knowledge-garden-vault"
REPO_NAME="knowledge-garden-vault"
GITHUB_USER="AIMDaAlien"

echo "🔧 Initializing Knowledge Garden Vault Repository..."
cd "$VAULT_DIR"

# ============================================================
# STEP 1: Initialize Git Repository
# ============================================================
echo ""
echo "📦 Step 1: Initializing Git repository..."
git init
echo "✅ Git repository initialized"

# ============================================================
# STEP 2: Configure Git User (if not set globally)
# ============================================================
echo ""
echo "👤 Step 2: Checking Git configuration..."
if [ -z "$(git config user.name)" ]; then
    echo "⚠️  Git user.name not set. Please configure:"
    echo "   git config --global user.name \"Your Name\""
    exit 1
fi
if [ -z "$(git config user.email)" ]; then
    echo "⚠️  Git user.email not set. Please configure:"
    echo "   git config --global user.email \"your.email@example.com\""
    exit 1
fi
echo "✅ Git user configured: $(git config user.name) <$(git config user.email)>"

# ============================================================
# STEP 3: Verify Privacy Protection
# ============================================================
echo ""
echo "🔒 Step 3: Verifying privacy protection (.gitignore)..."
if [ ! -f ".gitignore" ]; then
    echo "❌ ERROR: .gitignore file not found!"
    exit 1
fi

# Verify Career/ and Myself/ are ignored
if ! grep -q "^Career/" .gitignore || ! grep -q "^Myself/" .gitignore; then
    echo "❌ ERROR: Private folders not properly configured in .gitignore!"
    exit 1
fi
echo "✅ Privacy protection verified"

# ============================================================
# STEP 4: Initial Commit (Main Branch)
# ============================================================
echo ""
echo "📝 Step 4: Creating initial commit on main branch..."
git add .
git commit -m "Initial commit: Knowledge Garden Vault with privacy protection

- Added vault structure and content
- Configured .gitignore for Career/ and Myself/ exclusion
- Added README with dual-branch architecture documentation
- Material Design 3 integration ready"
echo "✅ Initial commit created"

# ============================================================
# STEP 5: Create Local-Dev Branch
# ============================================================
echo ""
echo "🌿 Step 5: Creating local-dev branch for MCP hybrid development..."
git branch local-dev
echo "✅ local-dev branch created"

# ============================================================
# STEP 6: Create Remote Repository Connection
# ============================================================
echo ""
echo "🔗 Step 6: Configuring remote repository..."
echo ""
echo "⚠️  MANUAL STEP REQUIRED:"
echo "   1. Go to https://github.com/new"
echo "   2. Repository name: $REPO_NAME"
echo "   3. Description: Privacy-protected knowledge base with Material Design 3 interface"
echo "   4. Set to: PUBLIC"
echo "   5. DO NOT initialize with README, .gitignore, or license (we have them)"
echo "   6. Click 'Create repository'"
echo ""
echo "After creating the repository on GitHub, run:"
echo "   git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo "   git push -u origin main"
echo "   git push origin local-dev"
echo ""

# ============================================================
# STEP 7: Privacy Audit
# ============================================================
echo ""
echo "🛡️  Step 7: Running privacy audit..."
echo ""
echo "Checking for private content in staging area..."
PRIVATE_FILES=$(git ls-files | grep -E "Career|Myself" || true)
if [ -n "$PRIVATE_FILES" ]; then
    echo "❌ ERROR: Private files detected in staging area:"
    echo "$PRIVATE_FILES"
    echo ""
    echo "This should never happen. Please investigate immediately."
    exit 1
fi
echo "✅ No private content detected in repository"

echo ""
echo "🎉 Repository initialization complete!"
echo ""
echo "📋 Next Steps:"
echo "   1. Create GitHub repository: https://github.com/new"
echo "   2. Connect remote: git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo "   3. Push main branch: git push -u origin main"
echo "   4. Push local-dev branch: git push origin local-dev"
echo ""
echo "Current branch: $(git branch --show-current)"
echo "Available branches:"
git branch
