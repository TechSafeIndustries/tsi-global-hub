# TechSafe Industries Global Hub

> **Intelligence & Governance Partner for High-Risk Industries**

A premium, interactive web experience showcasing the TechSafe Industries ecosystem and the data flow between our four integrated pillars.

---

## 🇦🇺 Project Overview

The **TSI Global Hub** is the digital front door to TechSafe Industries, demonstrating how our four pillars work together to protect **People, Property, and Planet** through the **3Ps Framework**.

### The Four Pillars

1. **TechSafe Business** — Governance umbrella and 3Ps framework delivery system
2. **TechSafe Smart Tools** — Input sensors (wearables, gas/dust pods) capturing real-world signals
3. **TechSafeAI** — The SaaS "Brain" processing inputs, filtering data, and recording evidence
4. **TechSafe DigiBoards** — Output screens delivering live KPIs and emergency messaging

---

## 🎨 Design Standards

This project follows **UI/UX Pro Max** standards with TSI canonical branding:

### Colour Palette
- **Background:** Dark Navy Blue `#0A1F3E`
- **Primary Accent:** TechSafe Blue `#2DB8F9`
- **Primary Text:** White `#FFFFFF`
- **Secondary Text:** Mid Grey `#A6A6A6`

### Typography
- **Primary Font:** Inter (Google Fonts)
- **Display Font:** Space Grotesk (Google Fonts)

### Visual Identity
- TSI logo (`logo_tsi_bbg01.png`)
- SAI character assets (`AI_SAI01.png`, `AI_SAI02.png`)
- Glassmorphic effects with Navy/Blue gradients
- Micro-animations and smooth transitions

---

## 🤖 SAI Meet & Greet Logic

The interactive SAI (Smart AI) assistant guides users through three phases:

### Phase 1: Welcome (Hero Section)
- **AI_SAI02.png** appears in the hero section
- SAI welcomes users with Australian English greeting
- Speech bubble introduces the TechSafe ecosystem

### Phase 2: Explanation
- SAI explains: *"I'm SAI. I take inputs from your TechSafe Smart Tools, process them in the TechSafeAI backend, and push live updates to your TechSafe DigiBoards."*
- Speech bubble remains visible for 8 seconds

### Phase 3: Persistent Assistant
- SAI transitions to **AI_SAI01.png** as floating assistant
- Positioned in bottom-right corner
- Clickable for interactive tips and guidance
- Follows users throughout their journey

---

## 📊 Data Flow Visualisation

The site maps the complete data journey:

```
Smart Tools (Sensors) → TechSafeAI (Processing) → DigiBoards (Display)
         ↓                      ↓                        ↓
   Field Capture          AI Filtering            Frontline Visibility
```

### Flow Steps
1. **Capture** — Wearables and sensors detect field conditions
2. **Transmit** — Data streams to TechSafeAI cloud infrastructure
3. **Process** — AI filters, records evidence, identifies patterns
4. **Display** — DigiBoards show real-time KPIs and alerts

---

## 🛠️ Technical Stack

### Core Technologies
- **HTML5** — Semantic markup with accessibility features
- **Vanilla CSS** — Custom design system with CSS variables
- **Vanilla JavaScript** — Class-based ES6 architecture
- **Zero frameworks** — Maximum performance and control

### Key Features
- ✅ Responsive design (mobile-first approach)
- ✅ Smooth scroll with navigation offset
- ✅ Intersection Observer for scroll animations
- ✅ Glassmorphic UI elements
- ✅ Keyboard navigation support
- ✅ ARIA labels for screen readers
- ✅ Optimised performance (sub-2s load time target)

---

## 📁 Project Structure

```
tsi-global-hub/
├── index.html          # Main HTML structure
├── styles.css          # Complete design system
├── script.js           # Interactive functionality
├── logo_tsi_bbg01.png  # TSI brand logo
├── AI_SAI01.png        # SAI floating assistant avatar
├── AI_SAI02.png        # SAI welcome/hero character
└── README.md           # This file
```

---

## 🚀 Quick Start

### 1. Local Development Server

**Option A: Python**
```bash
# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

**Option B: Node.js**
```bash
npx http-server -p 8000
```

**Option C: PHP**
```bash
php -S localhost:8000
```

### 2. Open in Browser
Navigate to: **http://localhost:8000**

### 3. Test Responsiveness
- Desktop: 1920×1080 and 1440×900
- Tablet: 768×1024 (iPad)
- Mobile: 375×667 (iPhone) and 360×640 (Android)

---

## 🎯 Features & Interactions

### Navigation
- Fixed header with glassmorphic background
- Scroll-triggered compact mode
- Smooth scroll to sections with offset
- Underline hover animations

### Hero Section
- SAI welcome animation (Phase 1)
- Speech bubble with explanation (Phase 2)
- Floating background glow effect
- Responsive grid layout

### Pillar Cards
- Hover effects with glow borders
- Click interactions with visual feedback
- Connection highlighting (Smart Tools → AI → DigiBoards)
- Numbered badges with gradients
- Tag system for features

### Data Flow Diagram
- Staggered scroll-in animations
- Step-by-step progression arrows
- Hover effects on flow visuals
- Mobile-responsive stacking

### Floating SAI Assistant
- Phase 3 persistent presence
- Bottom-right corner positioning
- Click for random helpful tips
- Pulse animation and glow effects
- Bob animation (gentle floating)

---

## ♿ Accessibility

### Standards Compliance
- WCAG 2.1 AA guidelines followed
- Semantic HTML5 elements
- ARIA labels and roles
- Keyboard navigation support
- Focus indicators on interactive elements
- Reduced motion media query support

### Testing Checklist
- ✅ Screen reader compatible (NVDA/JAWS tested)
- ✅ Keyboard-only navigation
- ✅ Colour contrast ratios (4.5:1 minimum)
- ✅ Alt text on all images
- ✅ Descriptive link text

---

## 📱 Responsive Breakpoints

| Breakpoint | Width | Target Device | Layout Changes |
|------------|-------|---------------|----------------|
| Desktop | 1024px+ | Desktops, large tablets | 2-column hero, 4-column pillars |
| Tablet | 768px–1023px | iPads, small laptops | 1-column hero, 2-column pillars |
| Mobile | <768px | Phones | Single column, stacked flow |

---

## 🎨 Brand Resources Used

All assets sourced from `@tsi-branding` skill:

### Logos
- `logo_tsi_bbg01.png` — Primary logo (dark navy background)

### SAI Character
- `AI_SAI01.png` — Floating assistant avatar
- `AI_SAI02.png` — Welcome/hero character

### Future Assets Available
- `logo_tsi_wbg01.png` — White background variant
- `tsilogo_int_gov_ptnr.png` — Intelligence & Governance logo
- `ppe_vest_tsi01.png`, `ppe_vest_tsi02.png` — Reflective gear imagery
- `ppe_sg_tsi01.png`, `ppe_sg_tsi02.png` — Safety glasses imagery

---

## 🧪 Browser Compatibility

| Browser | Version | Status |
|---------|---------|--------|
| Chrome | 90+ | ✅ Full support |
| Firefox | 88+ | ✅ Full support |
| Safari | 14+ | ✅ Full support |
| Edge | 90+ | ✅ Full support |
| Opera | 76+ | ✅ Full support |

**Note:** Internet Explorer is not supported (uses modern CSS features).

---

## 📈 Performance Optimisations

### Implemented Techniques
- ✅ CSS variables for dynamic theming
- ✅ Debounced scroll handlers
- ✅ Intersection Observer (vs scroll listeners)
- ✅ CSS transforms for animations (GPU-accelerated)
- ✅ Minimal JavaScript footprint
- ✅ Font subsetting (Google Fonts)
- ✅ Image optimisation (PNG compression)

### Performance Targets
- **First Contentful Paint:** <1.5s
- **Time to Interactive:** <3.0s
- **Lighthouse Score:** 90+

---

## 🌐 SEO Optimisation

### On-Page SEO
- ✅ Descriptive `<title>` tag
- ✅ Meta description (Australian English)
- ✅ Semantic HTML structure (`<header>`, `<nav>`, `<section>`, `<footer>`)
- ✅ Single `<h1>` per page
- ✅ Proper heading hierarchy (H1 → H2 → H3)
- ✅ Descriptive alt text on images
- ✅ Internal linking structure

---

## 🔮 Future Enhancements

### Planned Features
- [ ] Contact form with validation
- [ ] Case study carousel
- [ ] Video demo integration
- [ ] Interactive 3D data flow diagram
- [ ] Multi-language support (maintain AU English as primary)
- [ ] Dark/light mode toggle (dark is default)
- [ ] SAI chatbot integration
- [ ] Analytics dashboard preview

### Technical Debt
- [ ] Add unit tests for JavaScript classes
- [ ] Implement service worker for offline support
- [ ] Add CSS autoprefixer for legacy browser support
- [ ] Consider WebP image format with PNG fallback

---

## 📝 Changelog

### Version 1.0.0 (2026-02-06)
- ✅ Initial release
- ✅ SAI Meet & Greet logic (Phases 1-3)
- ✅ Four Pillars showcase
- ✅ Data Flow visualisation
- ✅ 3Ps Framework section
- ✅ Responsive design system
- ✅ Accessibility compliance
- ✅ TSI canonical branding applied

---

## 👥 Credits

**Design & Development:** Antigravity AI (Google Deepmind)  
**Branding:** TechSafe Industries  
**Language Standard:** Australian English  
**Framework:** 3Ps (People, Property, Planet)

---

## 📧 Contact & Support

For questions, customisations, or enterprise deployments:

**Email:** info@techsafe.industries  
**Website:** [TechSafe Industries](#)  
**Tagline:** Intelligence & Governance Partner

---

**Built with Australian standards. Powered by SAI. Protecting People, Property, Planet.**
