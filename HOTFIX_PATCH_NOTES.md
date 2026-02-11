# TSI GLOBAL HUB - HOTFIX PATCH NOTES

## Executive Summary
Completed comprehensive hotfix addressing PowerShell server stability, UTF-8 encoding issues, and hero background image consistency across the TSI Global Hub platform.

## Changes Applied

### 1. PowerShell Scripts (Server Management)

#### run.ps1
```diff
+ Call stop.ps1 before starting to ensure clean port
+ Use Start-Process for better process control
+ Add 1.5s startup delay
+ Verify HTTP 200 response
+ Keep server alive with Wait-Process
```

#### stop.ps1
```diff
+ Use $portPid variable (avoid read-only $pid)
+ Add -ErrorAction SilentlyContinue for reliability
+ Add 500ms sleep after kill for TIME_WAIT cleanup
+ Clear output messages ("Stopped PID X" / "No listener found")
```

### 2. UTF-8 Mojibake Fixes

#### industries/mining/index.html
```diff
- Centralise incidents... " } # â€� with human
+ Centralise incidents... — with human

- Incident †' Closure
+ Incident → Closure

- Assess †' approve †' record †' report
+ Assess → approve → record → report

- Inputs †' Governance †' Visibility
+ Inputs → Governance → Visibility
```

#### script.js
```diff
- "Take the diagnostic" } # â€� it only takes 2 minutes."
+ "Take the diagnostic — it only takes 2 minutes."
```

### 3. Hero Background CSS (styles-business.css)

```diff
- /* === INDUSTRY-SPECIFIC HERO BACKGROUNDS === */
- .industry-mining .hero-section { ... }
- .industry-oil-gas .hero-section { ... }
- [5 more duplicate rules]
-
/* === FORCE INDUSTRY HERO (must be last in file) === */
body.industry-mining .hero-section {
  background-image: linear-gradient(rgba(10,31,62,.78), rgba(10,31,62,.78)), url('/assets/industry/mining.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}
[6 more industry-specific rules with absolute paths]
```

**Net Change:** Removed 48 lines of duplicate CSS, keeping only the more specific `body.*` prefixed rules.

## Verification Results

### ✅ No Mojibake Detected
```powershell
Get-ChildItem -Include *.html,*.js,*.css -Recurse | Select-String "â€"
# Result: 0 matches
```

### ✅ Hero Backgrounds Configured
```powershell
Select-String -Path styles-business.css -Pattern "body\.industry-" | Measure-Object
# Result: 7 rules (all industries covered)
```

### ✅ No Inline Hero Styles
```powershell
findstr /S /N /I "id=\"hero\" style=" *.html
# Result: No files found
```

## Files Modified
1. `run.ps1` - Server startup script
2. `stop.ps1` - Server shutdown script
3. `industries/mining/index.html` - UTF-8 fixes
4. `script.js` - UTF-8 fixes
5. `styles-business.css` - Hero background cleanup

## Testing Instructions

1. **Start Server:**
   ```powershell
   .\run.ps1
   ```
   Expect: "Server verified: HTTP 200 OK"

2. **Access Mining Page:**
   Navigate to: http://127.0.0.1:8002/industries/mining/

3. **Verify Hero Image:**
   - Open DevTools → Inspect `<section id ="hero">`
   - Check Computed `background-image`
   - Should show: `url("http://127.0.0.1:8002/assets/industry/mining.jpg")`

4. **Check Text Rendering:**
   - Hero subtitle should show proper em dash: "—"
   - Workflow arrows should show: "→"
   - No mojibake characters visible

5. **Stop Server:**
   ```powershell
   .\stop.ps1
   ```
   Expect: "Stopped PID {number} on 127.0.0.1:8002"

## Rollback Instructions
If issues arise, revert these commits:
- Restore original `run.ps1` and `stop.ps1` from git history
- For mojibake: Files were corrected in-place, original corrupt versions in git history
- For CSS: Restore duplicate rules if needed (unlikely)

## Notes
- All changes are deterministic and minimal
- No breaking changes to DOM structure or IDs
- Server binds exclusively to 127.0.0.1:8002
- No external dependencies added
- UTF-8 without BOM used for all text files

---
**Hotfix applied:** 2026-02-11  
**Status:** PRODUCTION READY ✅
