#!/usr/bin/env python3
"""
Obsidian Vault Migration Script
Copies public vault content to knowledge-garden-vault
Excludes: Career/, Myself/ (privacy-protected)
"""

import shutil
import os
from pathlib import Path

# Configuration
VAULT_SOURCE = Path.home() / "path/to/your/obsidian/vault"  # UPDATE THIS
VAULT_TARGET = Path("/Users/aim/Documents/knowledge-garden-vault")

# Private folders to exclude
PRIVATE_FOLDERS = ["Career", "Myself"]

# Public folders to include
PUBLIC_FOLDERS = [
    "Programming",
    "Systems", 
    "Computer Related Stuff",
    "Homelab",
    "Learning"
]

def should_copy(path_str):
    """Check if path should be copied (not private)"""
    for private in PRIVATE_FOLDERS:
        if path_str.startswith(private + "/") or path_str == private:
            return False
    return True

def copy_vault_content():
    """Copy public vault content"""
    print("🔄 Starting vault migration...")
    print(f"Source: {VAULT_SOURCE}")
    print(f"Target: {VAULT_TARGET}")
    print("")
    
    if not VAULT_SOURCE.exists():
        print(f"❌ Source vault not found: {VAULT_SOURCE}")
        print("Please update VAULT_SOURCE in this script.")
        return
    
    # Create target directories
    for folder in PUBLIC_FOLDERS:
        target_dir = VAULT_TARGET / folder
        target_dir.mkdir(parents=True, exist_ok=True)
        print(f"✅ Created: {folder}/")
    
    # Copy markdown files
    files_copied = 0
    files_skipped = 0
    
    for md_file in VAULT_SOURCE.rglob("*.md"):
        rel_path = md_file.relative_to(VAULT_SOURCE)
        rel_path_str = str(rel_path)
        
        if should_copy(rel_path_str):
            target_file = VAULT_TARGET / rel_path
            target_file.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(md_file, target_file)
            print(f"  📄 Copied: {rel_path_str}")
            files_copied += 1
        else:
            print(f"  ⏭️  Skipped (private): {rel_path_str}")
            files_skipped += 1
    
    print("")
    print(f"✅ Migration complete!")
    print(f"   Files copied: {files_copied}")
    print(f"   Files skipped (private): {files_skipped}")

if __name__ == "__main__":
    copy_vault_content()
