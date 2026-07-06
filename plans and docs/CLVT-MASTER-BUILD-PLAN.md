# CLVT — Master Build Plan

Architecture, file map, and how the pieces fit. See [CLVT-SCOPE](CLVT-SCOPE.md) for what and why, [CLVT-ROADMAP](CLVT-ROADMAP.md) for what is next.

---

## Stack

- Plain HTML + CSS + vanilla JavaScript. No framework, no bundler, no package manager.
- Web Audio API for everything audio: `AudioContext`, `AnalyserNode`, `MediaStreamSource`, `AudioBufferSourceNode`, `GainNode`.
- Canvas 2D for the visualization.
- Runs entirely client-side from `file://`. No server, no network.

## File Map

```
voice-trainer/
  index.html                  <- the entire app (markup + styles + logic)
  plans and docs/             <- this build binder
    CLVT-SCOPE.md
    CLVT-MASTER-BUILD-PLAN.md
    CLVT-BUILD-LOG.md
    CLVT-ROADMAP.md
    CLVT-PLANNING-BACKLOG.md
    CLVT-CLAUDE.md
    session notes/
```

Everything lives in `index.html`. When the file grows unwieldy, the split point is: pitch-detection module, extraction module, render module, app/UI glue. Not yet.

## Data Flow

```
Vocal stem WAV ----decode----> AudioBuffer
                                    |
                        offline extraction (downsample 16k,
                        100ms window / 25ms hop, autocorrelation)
                                    |
                              targetCurve [{t, midi}]  ---> median smooth ---> display range
                                    |
Backing WAV (opt) --decode--> playBuffer --> GainNode --> destination (audible)
                                    |
                              songTime() = ctx.currentTime - playStartCtxTime
                                    |
Mic --getUserMedia--> AnalyserNode --getFloatTimeDomainData--> detectPitch()
                                    |
                    render loop: draw target ribbon + your trail/dot,
                    compare live pitch to targetAt(songTime()), score
```

## Core Components (all in index.html)

### 1. Pitch detection — `detectPitch(buf, sampleRate, minFreq, maxFreq)`
- Time-domain autocorrelation restricted to the lag range implied by min/max frequency (fast, avoids most octave errors).
- RMS gate rejects silence/breath. Normalizes by zero-lag energy for a confidence threshold.
- Parabolic interpolation around the best lag for sub-sample (sub-cent) accuracy.
- Returns Hz, or `-1` when no confident pitch. Used for BOTH offline extraction and live mic.

### 2. Target extraction — `extractTarget(buffer)`
- Downsamples channel 0 to 16 kHz by block averaging (speed).
- Slides a 1600-sample (100 ms) window with a 400-sample (25 ms) hop, running `detectPitch` per frame.
- Chunked with `requestAnimationFrame` (works ~24 ms then yields) so the UI stays responsive; progress bar reflects frame count.
- `medianSmooth()` runs a median-of-5 and drops lone voiced frames to kill octave jumps and noise.
- `computeRange()` sets the vertical display window (`noteLo`/`noteHi`) from the target's pitch span, padded.

### 3. Playback — `startPlay()` / `stopPlay()`
- Plays `backingBuffer` if loaded, else falls back to `vocalBuffer` as a guide.
- Single `AudioBufferSourceNode` through a `GainNode` (Guide slider). `playStartCtxTime` anchors song time to the audio clock.

### 4. Render loop — `draw()`
- `requestAnimationFrame` loop, DPR-aware canvas.
- Draws: note lanes (C lines emphasized), the now-line at 30% width, the target ribbon (blue), your live pitch trail + dot (green/yellow/red by cents error).
- Time-to-x: `x = nowX + (t - songTime()) * PX_PER_SEC`. Future notes to the right, scrolling left.
- Scoring: each frame with both a target and a detected voice counts; within 100 cents = hit. `hitFrames / totalFrames` = on-pitch %.

## Key Constants (tuning knobs)

| Constant | Value | Meaning |
|----------|-------|---------|
| extraction rate | 16000 Hz | downsample target for speed |
| window / hop | 1600 / 400 | 100 ms window, 25 ms hop |
| detect min/max freq | 70 / 1000 Hz | vocal range gate |
| RMS gate | 0.008 | silence rejection |
| correlation floor | 0.35 | confidence threshold |
| `PX_PER_SEC` | 130 | horizontal scroll speed |
| `NOW_X_FRAC` | 0.30 | now-line position |
| hit window | 100 cents | scoring tolerance |

## Known Structural Limits

- No latency compensation between mic capture and playback clock. A calibration offset is the first planned fix.
- Scoring is per-frame, not per-note. It rewards time-on-pitch, not note-level accuracy.
- Autocorrelation is decent but not state of the art. Breathy, reverby, or harmonized stems degrade extraction.
