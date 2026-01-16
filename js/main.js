// Lightbox for gallery images
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
