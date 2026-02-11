/**
 * TSI GLOBAL HUB - PRODUCTIVITY INTELLIGENCE
 * Bold, assertive, conversion-focused
 */

// Diagnostic Funnel Handler
class DiagnosticFunnel {
  constructor() {
    this.answers = {};
    this.questionBtns = document.querySelectorAll('.option-btn');
    this.result = document.getElementById('diagnosticResult');
    this.init();
  }

  init() {
    this.questionBtns.forEach(btn => {
      btn.addEventListener('click', (e) => this.handleAnswer(e));
    });
  }

  handleAnswer(event) {
    const btn = event.currentTarget;
    const question = btn.dataset.question;
    const answer = btn.dataset.answer;

    // Remove selected from siblings
    const siblings = btn.closest('.question-options').querySelectorAll('.option-btn');
    siblings.forEach(s => s.classList.remove('selected'));

    // Mark as selected
    btn.classList.add('selected');

    // Store answer
    this.answers[question] = answer;

    // Check if all answered
    if (Object.keys(this.answers).length >= 5) {
      setTimeout(() => this.showResult(), 500);
    }
  }

  showResult() {
    const score = this.calculateSeverity();
    const resultData = this.getResultData(score);

    document.getElementById('resultSeverity').textContent = resultData.badge;
    document.getElementById('resultSeverity').style.background = resultData.color;
    document.getElementById('resultTitle').textContent = resultData.title;
    document.getElementById('resultDescription').textContent = resultData.description;

    this.result.classList.add('show');
    this.result.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  calculateSeverity() {
    const criticalAnswers = ['fragmented', 'yes', 'luck', 'no', 'systemic', 'unclear'];
    let criticalCount = 0;

    Object.values(this.answers).forEach(answer => {
      if (criticalAnswers.includes(answer)) criticalCount++;
    });

    return criticalCount;
  }

  getResultData(score) {
    if (score >= 4) {
      return {
        badge: 'ðŸš¨ CRITICAL HURT POINTS',
        color: 'linear-gradient(135deg, #EF4444, #B91C1C)',
        title: 'Your Organisation Is Operating on Luck',
        description: 'Multiple critical gaps detected. Fragmented systems, reactive management, and compliance blind spots are costing you millions in lost productivity. An HSE Business Assessment will identify exactly where you\'re bleeding margin and how to stop it.'
      };
    } else if (score >= 2) {
      return {
        badge: 'âš ï¸ MODERATE RISK',
        color: 'linear-gradient(135deg, #F59E0B, #D97706)',
        title: 'You Have Manageable Gaps with High-Risk Exposure',
        description: 'Some systems are working, but blind spots remain. Without unified intelligence, you\'re vulnerable to cascade failures. Our assessment will show you where integration can eliminate risk and boost productivity.'
      };
    } else {
      return {
        badge: 'âœ“ LOW RISK - OPTIMISE FURTHER',
        color: 'linear-gradient(135deg, #10B981, #059669)',
        title: 'Strong Foundation, Room for Excellence',
        description: 'You\'re managing well, but even high-performing organisations have optimisation opportunities. Let us identify where advanced intelligence can take you from good to industry-leading.'
      };
    }
  }
}

// Modal Handler
class ModalHandler {
  constructor() {
    this.modal = document.getElementById('bookingModal');
    this.openBtns = [
      document.getElementById('btnBookConsult'),
      document.getElementById('btnDirectConsult'),
      ...document.querySelectorAll('.btn-result-secondary')
    ].filter(Boolean);
    this.closeBtn = document.getElementById('modalClose');
    this.form = document.getElementById('bookingForm');
    this.init();
  }

  init() {
    this.openBtns.forEach(btn => {
      btn?.addEventListener('click', () => this.open());
    });

    this.closeBtn?.addEventListener('click', () => this.close());
    this.modal?.addEventListener('click', (e) => {
      if (e.target === this.modal) this.close();
    });

    this.form?.addEventListener('submit', (e) => this.handleSubmit(e));
  }

  open() {
    this.modal?.classList.add('show');
    document.body.style.overflow = 'hidden';
  }

  close() {
    this.modal?.classList.remove('show');
    document.body.style.overflow = '';
  }

  handleSubmit(e) {
    e.preventDefault();
    const formData = new FormData(this.form);

    // In production, send to backend
    console.log('Booking submitted:', Object.fromEntries(formData));

    alert('Thank you! SAI has received your request. A TechSafe consultant will contact you within 24 hours.');
    this.close();
    this.form.reset();
  }
}

// Assessment Button Handler
class AssessmentHandler {
  constructor() {
    this.btn = document.getElementById('btnAssessment');
    this.init();
  }

  init() {
    this.btn?.addEventListener('click', () => {
      // In production, redirect to assessment form or CRM
      alert('HSE Business Assessment request initiated. SAI will connect you with our team.');
    });
  }
}

// Navigation Controller
class NavigationController {
  constructor() {
    this.nav = document.getElementById('mainNav');
    this.scrollThreshold = 50;
    this.init();
  }

  init() {
    window.addEventListener('scroll', () => this.handleScroll());
    this.handleScroll();
  }

  handleScroll() {
    const scrolled = window.scrollY > this.scrollThreshold;
    this.nav?.classList.toggle('scrolled', scrolled);
  }
}

// Floating SAI
class FloatingSAI {
  constructor() {
    this.sai = document.getElementById('floatingSai');
    this.messages = [
      "Still relying on luck? Let's fix that.",
      "Fragmented systems cost you millions. I can show you where.",
      "Take the diagnostic — it only takes 2 minutes.",
      "Your competitors are integrating. Are you?",
      "Blind spots don't fix themselves. Let's talk."
    ];
    this.init();
  }

  init() {
    this.sai?.addEventListener('click', () => this.showMessage());
  }

  showMessage() {
    const msg = this.messages[Math.floor(Math.random() * this.messages.length)];
    const tooltip = document.createElement('div');
    tooltip.className = 'sai-tooltip';
    tooltip.textContent = msg;
    tooltip.style.cssText = `
      position: fixed;
      bottom: 120px;
      right: 32px;
      background: rgba(255,255,255,0.95);
      color: #0A1F3E;
      padding: 16px 20px;
      border-radius: 12px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.3);
      max-width: 280px;
      font-size: 0.95rem;
      font-weight: 600;
      z-index: 10001;
      animation: fadeIn 0.3s ease-out;
    `;

    document.body.appendChild(tooltip);

    setTimeout(() => {
      tooltip.style.transition = 'opacity 0.3s';
      tooltip.style.opacity = '0';
      setTimeout(() => tooltip.remove(), 300);
    }, 4000);
  }
}

// Smooth Scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

// Initialize
document.addEventListener('DOMContentLoaded', () => {
  console.log('ðŸš€ TechSafe Productivity Intelligence initializing...');

  new DiagnosticFunnel();
  new ModalHandler();
  new AssessmentHandler();
  new NavigationController();
  new FloatingSAI();

  console.log('âœ… All systems operational. Stop operating on luck.');
});

