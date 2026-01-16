# 002 - Project Status & Credentials Reference

**Last Updated**: 2026-01-16
**Project**: War on Persia (waronpersia.com)

---

## Current Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         waronpersia.com                                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐     │
│  │   Cloudflare    │    │  GitHub Pages   │    │   Bunny CDN     │     │
│  │   (DNS + CDN)   │───▶│  (Static Site)  │    │  (Media Files)  │     │
│  │                 │    │                 │    │                 │     │
│  │  - DNS records  │    │  - HTML/CSS/JS  │    │  - Images       │     │
│  │  - SSL/TLS      │    │  - Blog         │    │  - Videos       │     │
│  │  - DDoS protect │    │  - Gallery      │    │  - Large files  │     │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘     │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Service Credentials & Access

### 1. GitHub

| Item | Value |
|------|-------|
| **Account** | Pouria-Zarrin |
| **Email** | pouria79zarrin@gmail.com |
| **Repository** | https://github.com/Pouria-Zarrin/project-persia |
| **Pages URL** | https://pouria-zarrin.github.io/project-persia/ |
| **CLI Tool** | `gh` v2.45.0 |
| **Auth Method** | OAuth Token (keyring) |
| **Token Scopes** | gist, read:org, repo, workflow |

**Verify Authentication**:
```bash
gh auth status
```

---

### 2. Bunny CDN

| Item | Value |
|------|-------|
| **Storage Zone** | `persia-media` |
| **Storage Host** | `la.storage.bunnycdn.com` |
| **CDN URL** | `https://persia-cdn.b-cdn.net` |
| **FTP Port** | 21 |

**FTP Credentials**:
```
Host: la.storage.bunnycdn.com
Username: persia-media
Password: ***REMOVED***
Port: 21
```

**API Upload**:
```bash
export BUNNY_API_KEY='your-storage-api-key'
./scripts/bunny-upload.sh <local-folder> <remote-folder>
```

**CLI Scripts Available**:
- `scripts/bunny-upload.sh` - Bulk upload files
- `scripts/bunny-list.sh` - List files in storage
- `scripts/bunny-delete.sh` - Delete files

---

### 3. Cloudflare

| Item | Value |
|------|-------|
| **Account Email** | pouria79zarrin@gmail.com |
| **Domain** | waronpersia.com |
| **CLI Tool** | Wrangler v4.59.2 |
| **Auth Method** | OAuth Token |
| **Account ID** | ***REMOVED*** |

**Verify Authentication**:
```bash
wrangler whoami
```

**DNS Setup Script**:
```bash
export CLOUDFLARE_API_TOKEN='your-api-token'
./scripts/cloudflare-dns.sh
```

**To Create API Token**:
1. Go to: https://dash.cloudflare.com/profile/api-tokens
2. Click **Create Token**
3. Use **Edit zone DNS** template
4. Zone Resources: `Include → Specific zone → waronpersia.com`
5. Create and copy token

---

## Domain Configuration

### Custom Domain Setup

| Item | Value |
|------|-------|
| **Domain** | waronpersia.com |
| **Registrar** | Cloudflare |
| **GitHub CNAME** | Configured via `gh api` |
| **CNAME File** | `/home/pgold/project-persia/CNAME` |

### Required DNS Records (Cloudflare)

```
Type: CNAME
Name: @
Target: pouria-zarrin.github.io
Proxy: OFF (DNS only) - initially

Type: CNAME
Name: www
Target: pouria-zarrin.github.io
Proxy: OFF (DNS only) - initially
```

### Verify DNS Propagation
```bash
dig waronpersia.com +short
dig www.waronpersia.com +short
```

---

## Project Structure

```
project-persia/
├── CNAME                    # Custom domain file
├── index.html               # Homepage - hero, featured work, recent posts
├── gallery.html             # Gallery - filterable grid, lightbox
├── blog.html                # Blog - post listing
├── about.html               # About - profile, contact links
├── css/
│   └── styles.css           # Minimal theme, responsive, CSS variables
├── js/
│   └── main.js              # Gallery filtering, lightbox (image + video)
├── assets/
│   └── icons/               # Small icons only
├── scripts/
│   ├── bunny-upload.sh      # Bulk upload to Bunny CDN
│   ├── bunny-list.sh        # List files in Bunny storage
│   ├── bunny-delete.sh      # Delete files from Bunny
│   └── cloudflare-dns.sh    # Configure DNS records
├── memory/
│   ├── 001-github-pages-media-hosting-plan.md
│   └── 002-project-status-and-credentials.md
└── .gitignore               # Ignores .env, media/, node_modules/
```

---

## Website Features

### Pages
| Page | URL | Features |
|------|-----|----------|
| Home | `/index.html` | Hero section, featured work grid, recent posts |
| Gallery | `/gallery.html` | Filter by All/Images/Videos, lightbox |
| Blog | `/blog.html` | Post listing with dates |
| About | `/about.html` | Two-column layout, contact links |

### Design
- **Theme**: Minimal/Clean
- **Colors**: Light background (#fafafa), dark text (#222)
- **Typography**: System fonts
- **Responsive**: Mobile, tablet, desktop

### JavaScript Features
- Gallery filtering (All / Images / Videos)
- Image lightbox with keyboard support (Escape to close)
- Video lightbox with autoplay
- Smooth scroll for anchor links

---

## Progress Log

### Session 1: 2026-01-16

| Time | Task | Status |
|------|------|--------|
| - | Install GitHub CLI | ✅ Done |
| - | Authenticate GitHub CLI | ✅ Done |
| - | Create GitHub repository | ✅ Done |
| - | Initialize git, configure identity | ✅ Done |
| - | Create basic site structure | ✅ Done |
| - | Enable GitHub Pages | ✅ Done |
| - | Create Bunny CDN CLI scripts | ✅ Done |
| - | Redesign with minimal theme | ✅ Done |
| - | Add blog page | ✅ Done |
| - | Add gallery filtering | ✅ Done |
| - | Add video lightbox support | ✅ Done |
| - | Install Wrangler CLI | ✅ Done |
| - | Authenticate Cloudflare | ✅ Done |
| - | Purchase domain (waronpersia.com) | ✅ Done |
| - | Configure GitHub Pages CNAME | ✅ Done |
| - | Create Cloudflare DNS script | ✅ Done |
| - | Add DNS records in Cloudflare | 🔄 Pending |
| - | Upload media to Bunny CDN | 🔄 Pending |

---

## Git Commits

| Commit | Message |
|--------|---------|
| `bc5ac20` | Initial commit: Basic site structure with HTML, CSS, JS |
| `ced8423` | Add Bunny CDN CLI scripts for bulk upload, list, and delete |
| `816fbf7` | Redesign site with minimal theme, add blog page, gallery filtering, video lightbox |
| `532e860` | Create CNAME (GitHub auto-created) |

---

## Quick Commands Reference

### Git Operations
```bash
# Check status
git status

# Commit and push
git add .
git commit -m "Description"
git push origin main

# Pull latest
git pull origin main
```

### GitHub CLI
```bash
# Check auth
gh auth status

# Check Pages status
gh api repos/Pouria-Zarrin/project-persia/pages --jq '.status, .html_url'

# View repo in browser
gh repo view --web
```

### Bunny CDN
```bash
# Set API key
export BUNNY_API_KEY='your-key'

# Upload folder
./scripts/bunny-upload.sh ./photos images/gallery

# List files
./scripts/bunny-list.sh images/

# Delete file
./scripts/bunny-delete.sh images/old.jpg
```

### Cloudflare
```bash
# Check auth
wrangler whoami

# Set up DNS (requires API token)
export CLOUDFLARE_API_TOKEN='your-token'
./scripts/cloudflare-dns.sh
```

### Local Development
```bash
# Serve locally
python -m http.server 8000
# or
npx serve

# Open http://localhost:8000
```

---

## URLs

| Service | URL |
|---------|-----|
| **Live Site** | https://waronpersia.com (pending DNS) |
| **GitHub Pages** | https://pouria-zarrin.github.io/project-persia/ |
| **GitHub Repo** | https://github.com/Pouria-Zarrin/project-persia |
| **Bunny CDN** | https://persia-cdn.b-cdn.net/ |
| **Cloudflare Dashboard** | https://dash.cloudflare.com |
| **GitHub Pages Settings** | https://github.com/Pouria-Zarrin/project-persia/settings/pages |

---

## Next Steps

1. **Add DNS records in Cloudflare** (pending API token)
   - CNAME @ → pouria-zarrin.github.io
   - CNAME www → pouria-zarrin.github.io

2. **Wait for DNS propagation** (5-15 minutes)

3. **Verify HTTPS** is working on waronpersia.com

4. **Upload media to Bunny CDN**

5. **Update HTML** with actual CDN image/video URLs

6. **Customize content** (text, blog posts, about page)

---

*Document created: 2026-01-16*
*Project: War on Persia*
