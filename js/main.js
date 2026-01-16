/* ===================================
   Project Persia - Main JavaScript
   =================================== */

document.addEventListener('DOMContentLoaded', function() {

    // ===================================
    // Gallery Filtering
    // ===================================
    const filterBtns = document.querySelectorAll('.filter-btn');
    const galleryItems = document.querySelectorAll('.gallery-item');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            // Update active button
            filterBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            const filter = this.dataset.filter;

            // Filter items
            galleryItems.forEach(item => {
                if (filter === 'all' || item.dataset.type === filter) {
                    item.classList.remove('hidden');
                } else {
                    item.classList.add('hidden');
                }
            });
        });
    });

    // ===================================
    // Lightbox for Images
    // ===================================
    const galleryLinks = document.querySelectorAll('.gallery-item a:not(.video-item)');

    galleryLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            const imgSrc = this.dataset.full || this.querySelector('img')?.src;
            if (!imgSrc || imgSrc === '#') return;

            openLightbox('image', imgSrc);
        });
    });

    // ===================================
    // Lightbox for Videos
    // ===================================
    const videoLinks = document.querySelectorAll('.video-item');

    videoLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            const videoSrc = this.dataset.video;
            if (!videoSrc) return;

            openLightbox('video', videoSrc);
        });
    });

    // ===================================
    // Lightbox Functions
    // ===================================
    function openLightbox(type, src) {
        const lightbox = document.createElement('div');
        lightbox.className = 'lightbox';

        let content;
        if (type === 'video') {
            content = `
                <div class="lightbox-content">
                    <video controls autoplay>
                        <source src="${src}" type="video/mp4">
                        Your browser does not support the video tag.
                    </video>
                    <button class="lightbox-close">&times;</button>
                </div>
            `;
        } else {
            content = `
                <div class="lightbox-content">
                    <img src="${src}" alt="Full size image">
                    <button class="lightbox-close">&times;</button>
                </div>
            `;
        }

        lightbox.innerHTML = content;
        document.body.appendChild(lightbox);
        document.body.style.overflow = 'hidden';

        // Close handlers
        lightbox.addEventListener('click', function(e) {
            if (e.target === lightbox || e.target.classList.contains('lightbox-close')) {
                closeLightbox(lightbox);
            }
        });

        document.addEventListener('keydown', function closeOnEsc(e) {
            if (e.key === 'Escape') {
                closeLightbox(lightbox);
                document.removeEventListener('keydown', closeOnEsc);
            }
        });
    }

    function closeLightbox(lightbox) {
        // Pause video if playing
        const video = lightbox.querySelector('video');
        if (video) {
            video.pause();
        }

        lightbox.remove();
        document.body.style.overflow = '';
    }

    // ===================================
    // Smooth scroll for anchor links
    // ===================================
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });

});
