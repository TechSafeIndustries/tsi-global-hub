# MANUAL FIX INSTRUCTIONS

## Quick Start (2 commands)

```powershell
# 1. Fix the corrupted files
.\fix-corrupted-industries.ps1

# 2. Verify all files are clean
.\verify-industry-encoding.ps1
```

## What These Scripts Do

### fix-corrupted-industries.ps1
Fixes 3 remaining corrupted industry files:
- `industries/manufacturing/index.html`
- `industries/energy-renewables/index.html`
- `industries/construction/index.html`

**Fixes Applied:**
1. Removes PowerShell injection code from hero subtitles
2. Replaces `â€ â€™` with `→` (arrow)
3. Replaces `Â©` with `©` (copyright)
4. Saves as UTF-8 without BOM

**Duration:** ~2 seconds

### verify-industry-encoding.ps1
Scans ALL 7 industry pages for mojibake patterns:
- aviation
- construction
- energy-renewables
- manufacturing
- mining
- oil-gas
- transport-logistics

**Checks For:**
- `â€™` `â€"` `â€"` `â€œ` `â€�` `â€¢` - Mojibake characters
- `Â©` `Ã` - Bad encoding prefixes
- `@{ bad` - PowerShell injection remnants

**Output:** Pass/Fail report per file + summary table

**Duration:** ~1 second

## Expected Results

### After fix-corrupted-industries.ps1
```
========================================
SUMMARY
========================================
Files processed: 3
Files modified: 3

✅ Complete! Run verification script next.
========================================
```

### After verify-industry-encoding.ps1
```
✅ aviation - CLEAN
✅ construction - CLEAN
✅ energy-renewables - CLEAN
✅ manufacturing - CLEAN
✅ mining - CLEAN
✅ oil-gas - CLEAN
✅ transport-logistics - CLEAN

========================================
VERIFICATION SUMMARY
========================================
Total files scanned: 7
Clean files: 7
Files with issues: 0
Total issues found: 0

🎉 ALL INDUSTRY PAGES CLEAN!
========================================
```

## If Verification Fails

If any files still show issues:
1. Note which industry/pattern failed
2. Check the file manually in a text editor
3. Report back which specific pattern remains

## Files Already Fixed

- ✅ `industries/oil-gas/index.html` - Fixed earlier (hero section manually reconstructed)
- ✅ `industries/mining/index.html` - Fixed in previous hotfix
- ✅ `industries/aviation/index.html` - Never corrupted
- ✅ `industries/transport-logistics/index.html` - Never corrupted

## Safety Features

Both scripts:
- ✅ Read files as UTF-8
- ✅ Write files as UTF-8 without BOM
- ✅ Use string.Replace() (exact match, no regex risks)
- ✅ Check file exists before processing
- ✅ Report all changes made

## Next Steps After Verification Passes

1. Test all pages in browser:
   ```
   http://127.0.0.1:8002/industries/aviation/
   http://127.0.0.1:8002/industries/construction/
   http://127.0.0.1:8002/industries/energy-renewables/
   http://127.0.0.1:8002/industries/manufacturing/
   http://127.0.0.1:8002/industries/mining/
   http://127.0.0.1:8002/industries/oil-gas/
   http://127.0.0.1:8002/industries/transport-logistics/
   ```

2. Visual checks:
   - Hero subtitles display proper em dash `—`
   - Workflow arrows display `→`
   - No strange characters visible
   - All text readable

3. Commit the fixes:
   ```powershell
   git add industries/
   git commit -m "Fix: Removed PowerShell injection and mojibake from industry pages"
   ```

---

**Ready to run!** Execute the 2 commands above from the repo root.
