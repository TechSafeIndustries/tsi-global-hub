/**
 * TSI BUSINESS - MINIMAL JAVASCRIPT
 * Navigation and Form Handling
 */

class NavigationController {
  constructor() {
    this.nav = document.getElementById('mainNav');
    this.init();
  }

  init() {
    // Compact nav on scroll
    window.addEventListener('scroll', () => {
      if (window.scrollY > 50) {
        this.nav.classList.add('compact');
      } else {
        this.nav.classList.remove('compact');
      }
    });

    // Smooth scroll for nav links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', (e) => {
        e.preventDefault();
        const target = document.querySelector(anchor.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });
  }
}

class ContactFormHandler {
  constructor() {
    this.form = document.getElementById('contactForm');
    this.notice = document.getElementById('formNotice');
    this.init();
  }

  init() {
    if (!this.form) return;

    this.form.addEventListener('submit', (e) => {
      e.preventDefault();
      this.handleSubmit();
    });
  }

  async handleSubmit() {
    const formData = new FormData(this.form);
    const data = Object.fromEntries(formData.entries());

    // Show loading state
    const submitBtn = this.form.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.textContent = 'Submitting...';
    submitBtn.disabled = true;

    try {
      // Simulate form submission (replace with actual endpoint)
      await this.simulateSubmission(data);
      
      this.showNotice('Thank you for your enquiry. A consultant will respond within two business days.', 'success');
      this.form.reset();
    } catch (error) {
      this.showNotice('Unable to submit form. Please email info@techsafe.industries directly.', 'error');
    } finally {
      submitBtn.textContent = originalText;
      submitBtn.disabled = false;
    }
  }

  simulateSubmission(data) {
    return new Promise((resolve) => {
      console.log('Form submitted with data:', data);
      setTimeout(resolve, 1500);
    });
  }

  showNotice(message, type) {
    this.notice.textContent = message;
    this.notice.className = `form-notice ${type}`;
    
    // Clear notice after 10 seconds
    setTimeout(() => {
      this.notice.textContent = '';
      this.notice.className = 'form-notice';
    }, 10000);
  }
}

// Initialize on DOM ready
document.addEventListener('DOMContentLoaded', () => {
  new NavigationController();
  new ContactFormHandler();
});
