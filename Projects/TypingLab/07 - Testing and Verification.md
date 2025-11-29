---
{}
---

# Testing and Verification

> **How to verify TypingLab works correctly**

## 🎯 Testing Philosophy

**Approach:** Manual testing for MVP, automated tests later

**Why manual?**
- Fast iteration (no test writing overhead)
- MVP needs user validation
- Automated tests when features stable

**Future:** Add Vitest + React Testing Library

---

## ✅ Core Feature Testing

### Test 1: Adaptive Lesson Flow

**Objective:** Verify adaptive algorithm works end-to-end

**Steps:**
```bash
1. npm run dev
2. Click "Start Typing"
3. Type the entire lesson (don't skip)
4. Wait for completion modal (2 seconds)
5. Verify new lesson loads automatically
6. Check active keys changed
```

**Expected:**
- ✅ Completion modal shows: WPM, accuracy, "🎉 Lesson Complete!"
- ✅ After 2 seconds, modal disappears
- ✅ New lesson text appears
- ✅ Typing engine resets (cursor at start)
- ✅ Active keys may change (if threshold met)

**Success Criteria:**
- Auto-generates next lesson
- No manual intervention needed
- Stats display correctly

---

### Test 2: Offline Capability

**Objective:** Verify PWA works without network

**Steps:**
```bash
# First visit (online)
1. npm run dev
2. Complete one typing session
3. Open DevTools (F12)
4. Go to Application tab → Service Workers
5. Verify: "activated and running"

# Test offline
6. Go to Network tab
7. Change dropdown from "Online" to "Offline"
8. Reload page (Cmd+R / Ctrl+R)
9. Complete another session
```

**Expected:**
- ✅ Page loads normally when offline
- ✅ All fonts display (no system fallbacks)
- ✅ Typing functionality works
- ✅ No network errors in console

**Success Criteria:**
- App functional without internet
- Service worker caches all assets
- No degraded experience

---

### Test 3: Performance Benchmarks

**Objective:** Verify <16ms input latency and 60fps

#### 3a. Input Latency Test
```bash
1. Open Chrome DevTools → Performance
2. Click Record (red circle)
3. Type quickly for 10 seconds
4. Stop recording
5. Analyze flame graph
```

**Look for:**
- 🔍 "keydown" events in timeline
- 🔍 Time from event to paint
- 🔍 Should be <16ms

**Chrome DevTools Analysis:**
```
Event Timeline:
keydown event → 1ms
handler execution → 2ms
setState → 3ms
React render → 5ms
browser paint → 5ms
---
Total: 16ms ✅
```

#### 3b. Frame Rate Test
```bash
1. DevTools → Performance
2. Enable "Rendering" tab
3. Check "Frame Rendering Stats"
4. Type for 30 seconds
5. Verify FPS counter stays at 60
```

**Expected:**
- ✅ Consistent 60 FPS
- ✅ No frame drops
- ✅ Green line in timeline (no yellow/red)

**Warning Signs:**
- 🔴 Yellow frames (jank)
- 🔴 Frame drops below 50 FPS
- 🔴 Long tasks (>50ms)

---

### Test 4: Cross-Browser Compatibility

**Objective:** Verify works on major browsers

**Test Matrix:**

| Browser | Version | Windows | macOS | Linux |
|---------|---------|---------|-------|-------|
| Chrome | 120+ | ✅ | ✅ | ✅ |
| Firefox | 120+ | ✅ | ✅ | ✅ |
| Safari | 16+ | N/A | ✅ | N/A |
| Edge | 120+ | ✅ | ✅ | N/A |

**Test Each Browser:**
```bash
1. Open app in browser
2. Complete one typing session
3. Check DevTools console (no errors)
4. Verify offline mode works
5. Test PWA install (if supported)
```

**Known Issues:**
- Safari < 16: IndexedDB quirks
- Firefox: Service worker registration slower
- Edge: Same as Chrome (Chromium-based)

---

### Test 5: Mobile/Tablet Testing

**Objective:** Verify responsive design and touch input

**Devices to Test:**
- iPad Pro (landscape)
- iPad Mini (portrait)
- Android tablet 10" (landscape)

**Test Steps:**
```bash
1. Open on tablet
2. Rotate to landscape
3. Start typing session
4. Verify:
   - Keyboard fits on screen
   - Fonts readable
   - HUD displays correctly
   - No horizontal scroll
```

**Expected:**
- ✅ Responsive layout (scales appropriately)
- ✅ Touch keyboard triggers correctly
- ✅ No layout shift during typing
- ✅ Performance acceptable (>30fps)

**Not Supported:**
- ❌ Phones (<7" screen)
- ❌ Reason: Too small for comfortable typing practice

---

## 🔍 Database Verification

### Test 6: IndexedDB Storage

**Objective:** Verify data persists correctly

**Steps:**
```bash
1. Complete 3 typing sessions
2. Open DevTools → Application → IndexedDB
3. Expand "typinglab-db"
4. Check each store:
```

**Expected Structure:**

#### users table
```json
{
  "id": "uuid",
  "targetWPM": 35,
  "currentLevel": 0,
  "activeLetters": ["a", "s", "d", ...],
  "masteredLetters": [],
  "createdAt": "2025-11-18T...",
  "lastSession": "2025-11-18T..."
}
```

#### sessions table
```json
{
  "id": "uuid",
  "userId": "uuid",
  "timestamp": "2025-11-18T...",
  "duration": 120000,
  "grossWPM": 45,
  "netWPM": 42,
  "accuracy": 0.951,
  "errorCount": 3,
  "completionRate": 1.0
}
```

#### keyStats table
```json
{
  "id": "userId-a",
  "letter": "a",
  "attempts": 247,
  "errors": 12,
  "totalTime": 48320,
  "meanTime": 195.5,
  "confidence": 0.92,
  "wpm": 42,
  "accuracy": 0.951
}
```

**Verification:**
- ✅ All records present
- ✅ Timestamps valid
- ✅ Data types correct
- ✅ Relationships intact (userId references)

---

### Test 7: Export/Import

**Objective:** Verify data portability

**Steps:**
```bash
# Export
1. Complete 5 sessions
2. Click "Export Data" button
3. Save JSON file

# Verify export
4. Open JSON in text editor
5. Check structure matches schema
6. Verify all sessions included

# Clear data
7. DevTools → Application → Clear storage
8. Reload page (should be empty state)

# Import
9. Click "Import Data"
10. Select exported JSON file
11. Wait for page reload
12. Verify all sessions restored
```

**Expected JSON Structure:**
```json
{
  "version": "1.0",
  "exportDate": "2025-11-18T...",
  "user": { /* UserProfile */ },
  "sessions": [ /* Session[] */ ],
  "keyStats": [ /* KeyStats[] */ ],
  "settings": { /* AppSettings */ }
}
```

---

## 🎨 UI/UX Testing

### Test 8: Typing Experience

**Objective:** Verify smooth, responsive typing

**Test Scenarios:**

#### Scenario A: Slow Typing (20 WPM)
```bash
1. Type deliberately slowly
2. Verify cursor moves smoothly
3. Check no visual lag
4. Confirm metrics update in real-time
```

#### Scenario B: Fast Typing (100+ WPM)
```bash
1. Type as fast as possible
2. Verify no dropped keystrokes
3. Check cursor keeps up
4. Confirm no jank or stutter
```

#### Scenario C: Error Correction
```bash
1. Type wrong character
2. Press Backspace
3. Type correct character
4. Verify:
   - Cursor moves back
   - Character removed
   - Error counted
   - Can continue
```

**Success Criteria:**
- ✅ Smooth cursor movement
- ✅ No dropped inputs
- ✅ Real-time feedback
- ✅ Backspace works correctly

---

### Test 9: Visual Feedback

**Objective:** Verify UI provides clear feedback

**Elements to Test:**

#### Performance HUD
```
Check displays:
- Current WPM (updates every 100ms)
- Accuracy percentage (1 decimal place)
- Time elapsed (MM:SS format)
- Error count (red color)
```

#### Typing Area
```
Verify:
- Typed characters turn grey
- Current character in lavender
- Errors show in red background
- Spaces show as middle dots (·)
```

#### Completion Modal
```
Appears on finish:
- 🎉 emoji
- "Lesson Complete!" heading
- Final WPM (large, bold)
- Accuracy percentage
- "Loading next lesson..." text
```

**Success Criteria:**
- ✅ All metrics visible and accurate
- ✅ Colors correct (lavender theme)
- ✅ Font rendering crisp (no blur)
- ✅ Layout doesn't shift

---

## 🐛 Error Scenarios

### Test 10: Edge Cases

#### Edge Case A: Empty State
```bash
1. Clear all browser data
2. Open app (first-time user)
3. Verify:
   - Start screen displays
   - No errors in console
   - Default settings applied
   - Home row keys selected
```

#### Edge Case B: Rapid Page Reload
```bash
1. Start typing session
2. Immediately reload page (Cmd+R)
3. Verify:
   - No data corruption
   - Clean slate (new lesson)
   - Service worker handles gracefully
```

#### Edge Case C: Browser Crash Recovery
```bash
1. Start typing session
2. Close browser (force quit)
3. Reopen browser
4. Navigate to app
5. Verify:
   - Last session saved (if completed)
   - No lost data
   - Normal operation
```

#### Edge Case D: Slow Network
```bash
1. DevTools → Network → Slow 3G
2. Reload page
3. Verify:
   - Service worker serves from cache
   - No prolonged loading
   - All assets load correctly
```

---

## 📊 Performance Monitoring

### Test 11: Memory Leaks

**Objective:** Verify no memory accumulation

**Steps:**
```bash
1. Open DevTools → Memory
2. Take heap snapshot (Snapshot 1)
3. Complete 10 typing sessions
4. Take heap snapshot (Snapshot 2)
5. Compare snapshots
```

**Expected:**
- ✅ Memory increase <5MB
- ✅ No detached DOM nodes
- ✅ Event listeners cleaned up
- ✅ Stable baseline after sessions

**Warning Signs:**
- 🔴 Memory increases >20MB
- 🔴 Growing number of objects
- 🔴 Detached DOM nodes accumulating

---

### Test 12: Bundle Size

**Objective:** Verify production build size acceptable

**Steps:**
```bash
1. npm run build
2. Check dist/ folder sizes
3. Verify gzipped sizes
```

**Target Sizes:**
```
JavaScript:
  vendor.js: ~42KB gzipped
  main.js: ~85KB gzipped
  Total: <150KB gzipped ✅

CSS:
  styles.css: ~15KB gzipped ✅

Fonts:
  Ubuntu-Regular.woff2: ~25KB
  JetBrainsMono-Regular.woff2: ~35KB
  Total: ~60KB ✅

Overall Total: ~225KB ✅
```

**Tools:**
```bash
# Analyze bundle
npx vite-bundle-visualizer

# Check gzipped sizes
du -sh dist/*.js | awk '{print $1}'
```

---

## ✅ Pre-Release Checklist

### Critical Tests
- [ ] Adaptive lesson flow works
- [ ] Offline mode functional
- [ ] Performance targets met (<16ms, 60fps)
- [ ] Cross-browser compatibility
- [ ] Mobile/tablet responsive

### Data Integrity
- [ ] Sessions persist across reloads
- [ ] Export/import works correctly
- [ ] No data corruption
- [ ] IndexedDB schema valid

### UI/UX
- [ ] Typing experience smooth
- [ ] Visual feedback clear
- [ ] No layout shift
- [ ] Fonts render correctly

### Edge Cases
- [ ] Empty state handles correctly
- [ ] Rapid reload safe
- [ ] Crash recovery works
- [ ] Slow network handled

### Performance
- [ ] No memory leaks
- [ ] Bundle size acceptable
- [ ] Service worker caches properly
- [ ] No console errors

---

## 🔧 Debugging Tips

### Common Issues

#### Issue: Input feels laggy
**Debug:**
```bash
1. DevTools → Performance
2. Record typing session
3. Look for long tasks (>50ms)
4. Check event handler execution time
```

**Fix:**
- Reduce state updates
- Use requestAnimationFrame
- Check for unnecessary re-renders

#### Issue: Offline mode doesn't work
**Debug:**
```bash
1. DevTools → Application → Service Workers
2. Check registration status
3. Verify "activated and running"
4. Check cache contents
```

**Fix:**
- Verify vite-plugin-pwa configured
- Check registerSW() called in main.tsx
- Rebuild app (npm run build)

#### Issue: Data not persisting
**Debug:**
```bash
1. DevTools → Application → IndexedDB
2. Check if database exists
3. Verify tables populated
4. Check for errors in console
```

**Fix:**
- Verify IndexedDB not blocked (incognito mode)
- Check storage quota not exceeded
- Verify async operations use await

---

## 📋 Testing Logs

### Template
```markdown
## Test Session: [Date]

**Tester:** [Name]
**Browser:** [Chrome 120 / macOS]
**Device:** [MacBook Pro M3]

### Tests Completed
- [ ] Test 1: Adaptive Lesson Flow
- [ ] Test 2: Offline Capability
- [ ] Test 3: Performance
- [ ] Test 4: Cross-Browser
- [ ] Test 5: Mobile/Tablet
- [ ] Test 6: IndexedDB
- [ ] Test 7: Export/Import
- [ ] Test 8: Typing Experience
- [ ] Test 9: Visual Feedback
- [ ] Test 10: Edge Cases
- [ ] Test 11: Memory Leaks
- [ ] Test 12: Bundle Size

### Issues Found
1. [Issue description]
   - Severity: Critical/Major/Minor
   - Steps to reproduce
   - Expected vs actual behavior

### Performance Metrics
- Input Latency: [X]ms
- Frame Rate: [X] FPS
- Bundle Size: [X]KB gzipped
- Memory Usage: [X]MB

### Notes
[Any additional observations]
```

---

**Related:**
- [[00 - TypingLab Project Overview]]
- [[04 - Performance Optimization]]
- [[06 - Subagent Implementation Guide]]

*Last Updated: November 18, 2025*