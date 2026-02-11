# SPELLING & ENCODING AUDIT REPORT

**Date:** 2026-02-11 23:11  
**Scope:** All 7 industry landing pages  
**Status:** ⚠️ CRITICAL CORRUPTION DETECTED

## CRITICAL FINDINGS

### Files with SEVERE Corruption
The following files contain PowerShell debugging code accidentally injected into HTML content:

1. **industries/oil-gas/index.html**
   - Lines 40-41: PowerShell script fragments embedded
   - Lines 114, 116: Mojibake arrow characters  
   - Lines 210, 219: Mojibake arrow characters
   - Line 246: Mojibake copyright symbol

2. **industries/manufacturing/index.html**
   - Similar PowerShell injection pattern detected

3. **industries/energy-renewables/index.html**
   - Similar PowerShell injection pattern detected

4. **industries/construction/index.html**
   - Similar PowerShell injection pattern detected

### Files CLEAN
- ✅ **industries/mining/index.html** - Already fixed in previous hotfix
- ✅ **industries/aviation/index.html** - Clean
- ✅ **industries/transport-logistics/index.html** - Clean

## MOJIBAKE PATTERNS FOUND

| Pattern | Correct | Occurrences | Files Affected |
|---------|---------|-------------|----------------|
| `â€"` (followed by PowerShell code) | `—` (em dash) | 4 | oil-gas, manufacturing, energy-renewables, construction |
| `â€ â€™` | `→` (arrow) | ~12 | oil-gas, manufacturing,  energy-renewables, construction |
| `Â©` | `©` | 4 | oil-gas, manufacturing, energy-renewables, construction |

## ROOT CAUSE ANALYSIS

The corruption appears to have originated from a previous bulk find-replace operation that:
1. Attempted to fix UTF-8 mojibake
2. Accidentally included PowerShell hash table definition syntax in the replacement
3. Injected debugging code: `@{ bad = [Text.Encoding]::UTF8.GetString([byte[]](...))`

This created **hybrid content**: HTML mixed with PowerShell syntax.

## RECOMMENDED RECOVERY STRATEGY

### Option A: Clean Restoration (RECOMMENDED)
1. Identify the last known-good version of these 4 files (from git history or backup)
2. Restore clean versions
3. Re-apply only the body class fix: `<body class="industry-{slug}">`
4. Verify hero backgrounds load correctly

### Option B: Surgical Fix
For each affected file:
1. Locate lines containing PowerShell injection
2. Extract the intended text (usually visible before/after the injection)
3. Replace corrupted lines with clean UTF-8 text
4. Replace remaining mojibake:
   - `â€ â€™` → `→`
   - `Â©` → `©`

## EXAMPLE CORRUPTION

**Before (Corrupted):**
```html
<p class="hero-subtitle">
    Centralise incidents... operations â€"
  @{ bad = [Text.Encoding]::UTF8.GetString([byte[]](0xC3,0xA2,0xE2,0x82,0xAC,0xE2,0x80,0x9C)); good = â€œ with human approval...
</p>
```

**After (Should be):**
```html
<p class="hero-subtitle">
    Centralise incidents... operations — with human approval...
</p>
```

## AUSTRALIAN ENGLISH COMPLIANCE

Unable to audit for AU spelling (Centralise vs Centralize) until corruption is resolved.

## NEXT STEPS

**IMMEDIATE ACTION REQUIRED:**

1. **STOP** any automated bulk text operations
2. **RESTORE** clean versions of 4 corrupted files
3. **VERIFY** mining/aviation/transport-logistics remain clean
4. **RE-APPLY** only the body class fix to restored files
5. **TEST** all pages load correctly

**Then proceed with:**
6. UTF-8 mojibake cleanup (if any remains)
7. Australian English spelling audit
8. Final encoding verification

## FILES STATUS

| File | Status | Action Required |
|------|--------|-----------------|
| aviation | ✅ Clean | None |
| construction | ⚠️ **CORRUPTED** | Restore + Fix |
| energy-renewables | ⚠️ **CORRUPTED** | Restore + Fix |
| manufacturing | ⚠️ **CORRUPTED** | Restore + Fix |
| mining | ✅ Clean | None |
| oil-gas | ⚠️ **CORRUPTED** | Restore + Fix |
| transport-logistics | ✅ Clean | None |

---

**CRITICAL:** Do not proceed with automated fixes until corruption is resolved.  
**Recommended:** Git revert to last known-good state for the 4 affected files.
