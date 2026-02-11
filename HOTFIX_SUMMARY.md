# TSI GLOBAL HUB HOTFIX SUMMARY
**Date:** 2026-02-11  
**Status:** ✅ COMPLETE

## PROBLEMS FIXED

### A) PowerShell Server Stability
**Issue:** Local server intermittently refused connections despite netstat showing LISTENING  
**Root Cause:** Race conditions and inadequate error handling in stop/start scripts

**Files Modified:**
- `run.ps1` - Enhanced with HTTP verification and better process management
- `stop.ps1` - Improved PID detection and clearer output messaging

**Changes:**
1. **stop.ps1:**
   - Uses `$portPid` (not read-only `$pid`)
   - Added `-ErrorAction SilentlyContinue` to prevent false failures
   - Added 500ms sleep after kill for TIME_WAIT cleanup
   - Output format: "Stopped PID {id} on 127.0.0.1:8002" or "No listener found"

2. **run.ps1:**
   - Now calls `stop.ps1` first to ensure port is free
   - Uses `Start-Process` with `-NoNewWindow` for better control
   - Added 1.5s startup delay
   - Performs HTTP 200 verification via `Invoke-WebRequest`
   - Prints clear success/fail status
   - Uses `Wait-Process` to keep server alive

### B) UTF-8 Mojibake Characters
**Issue:** Broken characters (â€™, â€", etc.) appearing across pages  
**Root Cause:** UTF-8 encoding issues in HTML and JS files

**Files Modified:**
1. `industries/mining/index.html`
   - Fixed hero subtitle: "â€"" → "—" (em dash)
   - Fixed workflow arrows: "†'" → "→"
   - Fixed system flow arrows: "→"
   
2. `script.js`
   - Fixed SAI message: "â€"" → "—" in "Take the diagnostic — it only takes 2 minutes."

**Verification:** 
- All HTML files searched - ZERO mojibake patterns remain
- `<meta charset="UTF-8">` confirmed present in all HTML files

### C) Hero Background Images
**Issue:** Industry hero backgrounds needed CSS-only control (no inline styles)  
**Requirement:** Ensure proper rendering with no rotation/distortion

**Files Modified:**
- `styles-business.css`

**Changes:**
1. Removed duplicate less-specific CSS rules (lines 1872-1920)
2. Kept only `body.industry-*` prefixed rules with absolute paths
3. All hero backgrounds now use:
   ```css
   body.industry-{name} .hero-section {
     background-image: linear-gradient(rgba(10,31,62,.78), rgba(10,31,62,.78)), url('/assets/industry/{name}.jpg');
     background-size: cover;
     background-position: center;
     background-repeat: no-repeat;
   }
   ```

**Industry Mappings:**
- `body.industry-mining` → `/assets/industry/mining.jpg`
- `body.industry-oil-gas` → `/assets/industry/oil-gas.jpg`
- `body.industry-construction` → `/assets/industry/construction.jpg`
- `body.industry-energy-renewables` → `/assets/industry/energy-renewables.jpg`
- `body.industry-manufacturing` → `/assets/industry/manufacturing.jpg`
- `body.industry-transport-logistics` → `/assets/industry/transport-logistics.jpg`
- `body.industry-aviation` → `/assets/industry/aviation.jpg`

**Properties Enforced:**
- ✅ `background-size: cover` - scales properly, no distortion
- ✅ `background-position: center` - centered framing
- ✅ `background-repeat: no-repeat` - single instance
- ✅ No transform or rotation applied
- ✅ Absolute paths from root for reliability

## VERIFICATION COMMANDS

### Start Server
```powershell
.\run.ps1
```
**Expected output:**
```
Ensuring port is free...
No listener found on 127.0.0.1:8002
Starting TSI local server on http://127.0.0.1:8002/
Server verified: HTTP 200 OK
Press Ctrl+C to stop the server
```

### Stop Server
```powershell
.\stop.ps1
```
**Expected output:**
```
Stopped PID {number} on 127.0.0.1:8002
```
Or if nothing running:
```
No listener found on 127.0.0.1:8002
```

### Verify No Mojibake
```powershell
# Should return NO results
Get-ChildItem -Path . -Include *.html,*.js -Recurse | Select-String "â€"
```

### Check Hero Background (DevTools)
1. Open http://127.0.0.1:8002/industries/mining/
2.  Open DevTools → Inspect `<section id="hero">`
3. Check Computed styles → `background-image` should show:
   ```
   linear-gradient(...), url("http://127.0.0.1:8002/assets/industry/mining.jpg")
   ```

## FILES CHANGED

| File | Lines Changed | Purpose |
|------|---------------|---------|
| `run.ps1` | ~15 | Enhanced reliability + HTTP verification |
| `stop.ps1` | ~5 | Improved PID handling + clearer output |
| `industries/mining/index.html` | ~5 | Fixed mojibake (em dash + arrows) |
| `script.js` | ~2 | Fixed mojibake in SAI messages |
| `styles-business.css` | ~50 (net -48) | Removed duplicates, clean hero CSS |

## NON-NEGOTIABLES PRESERVED

✅ Server binds ONLY to `127.0.0.1:8002`  
✅ NO inline styles on hero sections  
✅ DOM structure and IDs unchanged  
✅ Minimal, surgical diffs applied  
✅ All edits deterministic and repeatable

## STATUS: PRODUCTION READY

All issues resolved. Server is stable, encoding is clean, hero images render correctly.
