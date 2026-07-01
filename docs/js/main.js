/* =============================================
   PORTFOLIO SITE — MAIN JS
   ============================================= */

// Nav toggle (mobile)
const toggle = document.querySelector('.nav-toggle');
const navLinks = document.querySelector('.nav-links');
if (toggle && navLinks) {
  toggle.addEventListener('click', () => {
    navLinks.classList.toggle('open');
  });
  // Close on link click
  navLinks.querySelectorAll('a').forEach(a => {
    a.addEventListener('click', () => navLinks.classList.remove('open'));
  });
}

// Active nav link based on current page
const currentPage = window.location.pathname.split('/').pop() || 'index.html';
document.querySelectorAll('.nav-links a').forEach(a => {
  const href = a.getAttribute('href');
  if (href === currentPage || (currentPage === '' && href === 'index.html')) {
    a.classList.add('active');
  }
});

// Intersection Observer — reveal on scroll
const reveals = document.querySelectorAll('[data-reveal]');
if (reveals.length) {
  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.style.animationPlayState = 'running';
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.12 });
  reveals.forEach(el => {
    el.style.animationPlayState = 'paused';
    io.observe(el);
  });
}

// Typed effect for hero subtitle
function typeEffect(el, strings, speed = 75, pause = 2200) {
  if (!el) return;
  let si = 0, ci = 0, deleting = false;

  function tick() {
    const current = strings[si];
    el.textContent = deleting ? current.slice(0, ci--) : current.slice(0, ci++);
    let delay = deleting ? speed / 2 : speed;

    if (!deleting && ci > current.length) {
      deleting = true;
      delay = pause;
    } else if (deleting && ci < 0) {
      deleting = false;
      si = (si + 1) % strings.length;
      ci = 0;
      delay = 400;
    }
    setTimeout(tick, delay);
  }
  tick();
}

const typedEl = document.getElementById('typed');
if (typedEl) {
  typeEffect(typedEl, [
    'Data Analyst',
    'AI/ML Practitioner',
    'Python Developer',
    'Content Creator',
    'Sports Analytics Enthusiast',
  ]);
}

// Copy email to clipboard
document.querySelectorAll('.copy-email').forEach(btn => {
  btn.addEventListener('click', () => {
    navigator.clipboard.writeText(btn.dataset.email).then(() => {
      const orig = btn.textContent;
      btn.textContent = 'Copied!';
      setTimeout(() => btn.textContent = orig, 1500);
    });
  });
});
