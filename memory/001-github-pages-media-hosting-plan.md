# 001 - GitHub Pages Portfolio Site with Large Media Hosting

## Overview

Build a static portfolio/gallery website hosted on GitHub Pages with external media storage on Bunny CDN for cost-effective hosting of 25GB+ images and videos.

**Estimated Monthly Cost**: $1-5/month (depending on traffic)

---

## Architecture

```
┌─────────────────────┐     ┌─────────────────────┐
│   GitHub Pages      │     │    Bunny CDN        │
│   (Static Site)     │────▶│    (Media Files)    │
│   - HTML/CSS/JS     │     │    - Images         │
│   - Free hosting    │     │    - Videos         │
└─────────────────────┘     └─────────────────────┘
         │                           │
         └───────────┬───────────────┘
                     ▼
              ┌─────────────┐
              │   Visitor   │
              └─────────────┘
```

---

## Phase 1: GitHub Repository Setup

### Step 1.1: Create Repository

1. Go to https://github.com/new
2. Repository name options:
   - `<username>.github.io` - for user site (accessible at `https://<username>.github.io`)
   - `project-persia` - for project site (accessible at `https://<username>.github.io/project-persia`)
3. Set to **Public** (required for free GitHub Pages)
4. Initialize with README

### Step 1.2: Enable GitHub Pages

1. Go to repository **Settings** → **Pages**
2. Source: **Deploy from a branch**
3. Branch: `main` (or `master`)
4. Folder: `/ (root)` or `/docs`
5. Click **Save**

### Step 1.3: Recommended Folder Structure

```
project-persia/
├── index.html              # Homepage
├── gallery.html            # Gallery page
├── about.html              # About page
├── css/
│   └── styles.css          # Stylesheets
├── js/
│   └── main.js             # JavaScript
├── assets/
│   └── icons/              # Small icons/logos only (<100KB each)
├── memory/                 # Project documentation
│   └── 001-github-pages-media-hosting-plan.md
└── README.md
```

> **Important**: Do NOT store large media files in this repository. Use Bunny CDN instead.

---

## Phase 2: Bunny CDN Setup

### Step 2.1: Create Bunny Account

1. Go to https://bunny.net
2. Sign up for an account
3. Add payment method (pay-as-you-go, no minimum)

### Step 2.2: Create Storage Zone

1. Go to **Storage** → **Add Storage Zone**
2. Configuration:
   - **Name**: `persia-media` (or your preferred name)
   - **Main Region**: Choose closest to your primary audience
   - **Replication**: Optional (adds redundancy, increases cost)
3. Click **Create Storage Zone**

### Step 2.3: Create Pull Zone (CDN)

1. Go to **CDN** → **Add Pull Zone**
2. Configuration:
   - **Name**: `persia-cdn`
   - **Origin Type**: Storage Zone
   - **Storage Zone**: Select `persia-media`
3. Click **Create Pull Zone**
4. Note your CDN URL: `https://persia-cdn.b-cdn.net`

### Step 2.4: Upload Media Files

**Option A: Web Interface**
1. Go to **Storage** → Select your zone
2. Create organized folders:
   ```
   /images/
   /images/gallery/
   /images/thumbnails/
   /videos/
   ```
3. Upload files via drag-and-drop

**Option B: FTP Client (for bulk uploads)**
1. Get FTP credentials from Storage Zone settings
2. Use FileZilla or similar:
   - Host: `la.storage.bunnycdn.com`
   - Username: `persia-media`
   - Password: [Get from Bunny dashboard or local .env]
   - Port: 21

**Option C: API Upload (programmatic)**
```bash
curl --request PUT \
  --url "https://storage.bunnycdn.com/persia-media/images/photo1.jpg" \
  --header "AccessKey: YOUR-STORAGE-API-KEY" \
  --header "Content-Type: application/octet-stream" \
  --data-binary @/path/to/local/photo1.jpg
```

---

## Phase 3: Website Implementation

### Step 3.1: Basic HTML Template

Create `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Persia - Portfolio</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <nav>
            <a href="index.html">Home</a>
            <a href="gallery.html">Gallery</a>
            <a href="about.html">About</a>
        </nav>
    </header>

    <main>
        <h1>Welcome to Project Persia</h1>

        <!-- Image from Bunny CDN -->
        <img
            src="https://persia-cdn.b-cdn.net/images/hero.jpg"
            alt="Hero image"
            loading="lazy"
        >

        <!-- Video from Bunny CDN -->
        <video controls preload="metadata">
            <source
                src="https://persia-cdn.b-cdn.net/videos/intro.mp4"
                type="video/mp4"
            >
            Your browser does not support the video tag.
        </video>
    </main>

    <script src="js/main.js"></script>
</body>
</html>
```

### Step 3.2: Gallery Page with Lazy Loading

Create `gallery.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Project Persia</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <nav>
            <a href="index.html">Home</a>
            <a href="gallery.html">Gallery</a>
            <a href="about.html">About</a>
        </nav>
    </header>

    <main>
        <h1>Gallery</h1>

        <div class="gallery-grid">
            <!-- Repeat for each image -->
            <figure class="gallery-item">
                <a href="https://persia-cdn.b-cdn.net/images/gallery/photo1-full.jpg">
                    <img
                        src="https://persia-cdn.b-cdn.net/images/thumbnails/photo1-thumb.jpg"
                        alt="Photo 1 description"
                        loading="lazy"
                    >
                </a>
                <figcaption>Photo 1 Title</figcaption>
            </figure>

            <figure class="gallery-item">
                <a href="https://persia-cdn.b-cdn.net/images/gallery/photo2-full.jpg">
                    <img
                        src="https://persia-cdn.b-cdn.net/images/thumbnails/photo2-thumb.jpg"
                        alt="Photo 2 description"
                        loading="lazy"
                    >
                </a>
                <figcaption>Photo 2 Title</figcaption>
            </figure>

            <!-- Add more items as needed -->
        </div>
    </main>

    <script src="js/main.js"></script>
</body>
</html>
```

### Step 3.3: Basic Styles

Create `css/styles.css`:

```css
/* Reset and Base */
*, *::before, *::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
    line-height: 1.6;
    color: #333;
    background-color: #fafafa;
}

/* Navigation */
header {
    background: #222;
    padding: 1rem 2rem;
    position: sticky;
    top: 0;
    z-index: 100;
}

nav {
    display: flex;
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

nav a {
    color: #fff;
    text-decoration: none;
    font-weight: 500;
}

nav a:hover {
    color: #aaa;
}

/* Main Content */
main {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

h1 {
    margin-bottom: 2rem;
}

/* Images and Videos */
img, video {
    max-width: 100%;
    height: auto;
    border-radius: 8px;
}

/* Gallery Grid */
.gallery-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 1.5rem;
}

.gallery-item {
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s ease;
}

.gallery-item:hover {
    transform: translateY(-4px);
}

.gallery-item img {
    width: 100%;
    aspect-ratio: 4/3;
    object-fit: cover;
    display: block;
}

.gallery-item figcaption {
    padding: 1rem;
    font-weight: 500;
}

/* Responsive */
@media (max-width: 768px) {
    nav {
        flex-wrap: wrap;
        gap: 1rem;
    }

    main {
        padding: 1rem;
    }

    .gallery-grid {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 1rem;
    }
}
```

### Step 3.4: Optional Lightbox JavaScript

Create `js/main.js`:

```javascript
// Simple lightbox for gallery images
document.addEventListener('DOMContentLoaded', function() {
    const galleryLinks = document.querySelectorAll('.gallery-item a');

    galleryLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            const imgSrc = this.href;
            const lightbox = document.createElement('div');
            lightbox.className = 'lightbox';
            lightbox.innerHTML = `
                <div class="lightbox-content">
                    <img src="${imgSrc}" alt="Full size image">
                    <button class="lightbox-close">&times;</button>
                </div>
            `;

            document.body.appendChild(lightbox);
            document.body.style.overflow = 'hidden';

            // Close on click
            lightbox.addEventListener('click', function(e) {
                if (e.target === lightbox || e.target.className === 'lightbox-close') {
                    lightbox.remove();
                    document.body.style.overflow = '';
                }
            });

            // Close on Escape key
            document.addEventListener('keydown', function closeOnEsc(e) {
                if (e.key === 'Escape') {
                    lightbox.remove();
                    document.body.style.overflow = '';
                    document.removeEventListener('keydown', closeOnEsc);
                }
            });
        });
    });
});
```

Add lightbox styles to `css/styles.css`:

```css
/* Lightbox */
.lightbox {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.lightbox-content {
    position: relative;
    max-width: 90%;
    max-height: 90%;
}

.lightbox-content img {
    max-width: 100%;
    max-height: 90vh;
    object-fit: contain;
}

.lightbox-close {
    position: absolute;
    top: -40px;
    right: 0;
    background: none;
    border: none;
    color: #fff;
    font-size: 2rem;
    cursor: pointer;
}
```

---

## Phase 4: Optimization Best Practices

### 4.1: Image Optimization

Before uploading to Bunny CDN:

1. **Resize images** to maximum needed dimensions
   - Full gallery images: 1920px max width
   - Thumbnails: 400-600px width

2. **Compress images**
   - Use tools: TinyPNG, ImageOptim, Squoosh
   - Target: 80-85% quality for JPEGs
   - Use WebP format for better compression

3. **Create thumbnails**
   - Separate thumbnail versions for gallery grids
   - Significantly reduces initial page load

### 4.2: Video Optimization

1. **Compress videos** using HandBrake or FFmpeg:
   ```bash
   ffmpeg -i input.mp4 -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k output.mp4
   ```

2. **Create multiple resolutions** for adaptive streaming (optional):
   - 1080p for desktop
   - 720p for tablets
   - 480p for mobile

3. **Use poster images**:
   ```html
   <video poster="https://persia-cdn.b-cdn.net/videos/thumbnails/video1-poster.jpg">
   ```

### 4.3: Bunny CDN Optimization Settings

In Bunny CDN dashboard, enable:

1. **Perma-Cache**: Stores files permanently at edge
2. **Bunny Optimizer** (optional, paid): Auto-optimizes images
3. **Cache settings**: Set long cache times for static assets

---

## Phase 5: Deployment Workflow

### 5.1: Initial Deployment

1. Create all HTML, CSS, JS files locally
2. Test locally using:
   ```bash
   # Python 3
   python -m http.server 8000

   # Or Node.js
   npx serve
   ```
3. Commit and push to GitHub:
   ```bash
   git add .
   git commit -m "Initial site setup"
   git push origin main
   ```
4. Wait 1-2 minutes for GitHub Pages to deploy
5. Visit your site URL

### 5.2: Adding New Media

1. Optimize image/video locally
2. Upload to Bunny CDN Storage
3. Get the CDN URL
4. Add to your HTML
5. Commit and push changes

### 5.3: Custom Domain (Optional)

1. Purchase domain from registrar (Namecheap, Cloudflare, etc.)
2. In GitHub Pages settings, add custom domain
3. Add DNS records:
   ```
   Type: CNAME
   Name: www
   Value: <username>.github.io

   Type: A
   Name: @
   Value: 185.199.108.153
   Value: 185.199.109.153
   Value: 185.199.110.153
   Value: 185.199.111.153
   ```
4. Enable "Enforce HTTPS" in GitHub Pages settings

---

## Cost Breakdown

| Service | Item | Cost |
|---------|------|------|
| GitHub Pages | Hosting | Free |
| Bunny Storage | 30GB | ~$0.30/month |
| Bunny Bandwidth | 50GB | ~$0.50/month |
| Bunny Bandwidth | 100GB | ~$1.00/month |
| Custom Domain | .com | ~$10-15/year |

**Typical monthly cost for 30GB storage + 100GB bandwidth: ~$1.30/month**

---

## Alternative: Backblaze B2 + Cloudflare (Nearly Free)

If you want even lower costs:

1. **Backblaze B2**: 10GB free, then $0.005/GB/month
2. **Cloudflare**: Free CDN with Bandwidth Alliance (free egress from B2)

Setup is more complex but can reduce costs to nearly zero for moderate traffic.

---

## Troubleshooting

### Images not loading
- Check CDN URL is correct
- Verify file was uploaded to correct path
- Check browser console for CORS errors

### Slow video loading
- Ensure video is compressed
- Consider using `preload="metadata"` instead of `preload="auto"`
- Add poster image to show while loading

### GitHub Pages not updating
- Check Actions tab for deployment status
- Clear browser cache
- Wait a few minutes for propagation

---

## Progress Log

### Session: 2026-01-16

#### Completed Tasks

| Task | Status | Details |
|------|--------|---------|
| Install GitHub CLI | Done | Installed `gh` v2.45.0 via apt on Ubuntu 24.04 |
| Authenticate GitHub CLI | Done | Logged in as `Pouria-Zarrin` via web browser auth |
| Create GitHub Repository | Done | Public repo created at `Pouria-Zarrin/project-persia` |
| Initialize Git | Done | Configured user identity, branch set to `main` |
| Push Initial Code | Done | Initial commit with 7 files pushed to origin |
| Enable GitHub Pages | Done | Pages enabled with legacy build from `main` branch |

#### Repository Details

- **GitHub Repo**: https://github.com/Pouria-Zarrin/project-persia
- **Live Site URL**: https://pouria-zarrin.github.io/project-persia/
- **Branch**: `main`
- **Pages Source**: `/` (root)

#### Files Created

```
project-persia/
├── index.html              # Homepage (basic template)
├── gallery.html            # Gallery page with placeholder
├── about.html              # About page
├── css/
│   └── styles.css          # Full responsive styles + lightbox
├── js/
│   └── main.js             # Lightbox functionality
├── assets/
│   └── icons/              # (empty, for small icons)
└── memory/
    └── 001-github-pages-media-hosting-plan.md
```

#### Commands Executed

```bash
# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/keyrings/githubcli-archive-keyring.gpg
sudo apt install gh -y

# Authenticate (manual step via browser)
gh auth login

# Initialize repository
git init
git config user.email "pouria79zarrin@gmail.com"
git config user.name "Pouria Zarrin"
git branch -m main
git add .
git commit -m "Initial commit: Basic site structure with HTML, CSS, JS"

# Create and push to GitHub
gh repo create project-persia --public --description "Portfolio/Gallery website with GitHub Pages" --source=. --push

# Enable GitHub Pages
gh api repos/Pouria-Zarrin/project-persia/pages -X POST -F build_type=legacy -F source[branch]=main -F source[path]=/
```

---

## Next Steps

| Priority | Task | Status |
|----------|------|--------|
| 1 | Set up Bunny CDN account | Pending |
| 2 | Create storage zone and pull zone | Pending |
| 3 | Upload media files to CDN | Pending |
| 4 | Update HTML with CDN media URLs | Pending |
| 5 | Customize site content and styling | Pending |
| 6 | (Optional) Set up custom domain | Pending |

---

## Quick Reference

### Local Development
```bash
# Serve locally
python -m http.server 8000
# or
npx serve

# View at http://localhost:8000
```

### Deploy Changes
```bash
git add .
git commit -m "Description of changes"
git push origin main
# Wait 1-2 minutes for GitHub Pages to rebuild
```

### Check Deployment Status
```bash
gh api repos/Pouria-Zarrin/project-persia/pages --jq '.status'
```

---

*Document created: 2026-01-16*
*Last updated: 2026-01-16*
*Project: Project Persia*
