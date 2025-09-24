# Knowledge Garden Vault

**プライバシー保護型知識ベース** (puraibashī hogo-gata chishiki bēsu - Privacy-Protected Knowledge Base)

This repository contains a curated collection of technical notes and learning resources, designed to be consumed via the [Knowledge Garden web interface](https://aimdaalien.github.io/First-Portfolio-Iteration/garden-m3.html).

## 🔒 Privacy Architecture

This vault uses a **dual-layer privacy protection system**:

### Layer 1: .gitignore Exclusion
Private folders (`Career/`, `Myself/`) are excluded at the git level and **never committed** to version control.

### Layer 2: Client-Side Filtering
The web application implements additional filtering logic to prevent accidental exposure of private content.

## 📁 Vault Structure

```
knowledge-garden-vault/
├── 🗺️ Knowledge Base - Main Index.md    # Central navigation hub
├── Programming/                          # Programming concepts & languages
├── Systems/                              # Development tools & systems
├── Computer Related Stuff/               # General computing topics
├── Homelab/                              # Server & infrastructure notes
├── Learning/                             # Learning resources & strategies
└── [Career/]                             # ⚠️ PRIVATE - Not in repo
└── [Myself/]                             # ⚠️ PRIVATE - Not in repo
```

## 🌿 Branch Architecture

### `main` Branch (Production)
- **Purpose**: GitHub Pages deployment
- **Data Source**: GitHub API (`raw.githubusercontent.com`)
- **Update Method**: `git push` to sync changes
- **Use Case**: Public knowledge sharing, portfolio showcase

### `local-dev` Branch (Development)
- **Purpose**: Local development with real-time updates
- **Data Source**: MCP (Model Context Protocol) server
- **Update Method**: Automatic - reflects Obsidian vault instantly
- **Use Case**: Local testing, rapid iteration

## 🚀 Usage

### Viewing the Knowledge Garden
Access the web interface at: `https://aimdaalien.github.io/First-Portfolio-Iteration/garden-m3.html`

The Material Design 3 interface provides:
- 📱 Responsive navigation drawer
- 🌓 Light/dark theme toggle
- 🔗 Wiki-style internal linking
- 📝 GFM (GitHub Flavored Markdown) rendering

### Updating Content (Main Branch)

```bash
# 1. Make changes to your local Obsidian vault
# 2. Copy updated files to this repository
# 3. Commit and push changes

git add .
git commit -m "Update: [describe changes]"
git push origin main
```

### Local Development (Local-Dev Branch)

```bash
# Switch to development branch
git checkout local-dev

# Changes in your Obsidian vault reflect immediately
# No git operations needed for content updates
```

## 🛡️ Security Verification

### Pre-Commit Checklist
Before pushing to GitHub, verify:

```bash
# Check that private folders are ignored
git status | grep -E "Career|Myself"
# Should return: nothing (empty output = correctly ignored)

# View what will be committed
git diff --staged

# Verify .gitignore is working
git check-ignore Career/
# Should return: Career/ (confirms it's ignored)
```

### Privacy Audit Commands

```bash
# Search commit history for private folder references
git log --all --full-history --source -- "Career/*"
git log --all --full-history --source -- "Myself/*"
# Both should return: empty (no history = never committed)

# Check current index for private files
git ls-files | grep -E "Career|Myself"
# Should return: nothing
```

## 🔧 Configuration

### Repository Settings (garden-m3.js)

**Main Branch Configuration:**
```javascript
this.vaultOwner = 'AIMDaAlien';
this.vaultRepo = 'knowledge-garden-vault';
this.branch = 'main';
this.dataSource = 'github';  // Uses GitHub API
```

**Local-Dev Branch Configuration:**
```javascript
this.vaultOwner = 'AIMDaAlien';
this.vaultRepo = 'obsidian-vault';  // MCP vault name
this.branch = 'main';
this.dataSource = 'mcp';  // Uses MCP server
```

## 📊 Maintenance

### Sync Workflow (Main Branch)
```bash
# Regular sync schedule
1. Weekly: Push documentation updates
2. Daily: Push active learning notes (optional)
3. On-demand: Push new topics/categories
```

### Branch Management
```bash
# Switch to main (production)
git checkout main

# Switch to local-dev (development)
git checkout local-dev

# View current branch
git branch --show-current
```

## ⚠️ Important Notes

### DO NOT:
- ❌ Commit files from `Career/` or `Myself/` directories
- ❌ Remove `.gitignore` file
- ❌ Push changes without running privacy verification
- ❌ Share repository access with unauthorized users

### DO:
- ✅ Verify `.gitignore` before each commit
- ✅ Run privacy audit commands regularly
- ✅ Keep main branch synchronized with your public notes
- ✅ Use local-dev branch for testing new features

## 🔗 Links

- **Knowledge Garden**: https://aimdaalien.github.io/First-Portfolio-Iteration/garden-m3.html
- **Portfolio**: https://aimdaalien.github.io/First-Portfolio-Iteration/
- **GitHub Profile**: https://github.com/AIMDaAlien

---

*最終更新: 2025年9月 | Version: 1.0*
