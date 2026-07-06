# CLVT — Build Log

Chronological record of what was built and decided. Newest at top.

---

## 2026-07-06 — MVP built, repo created

**Built the whole MVP in one session as a single `index.html`.**

- Web Audio pipeline end to end: file decode, offline target extraction, mic capture, live pitch detection, canvas visualization, scoring.
- `detectPitch()`: lag-restricted autocorrelation with RMS gate, correlation-floor confidence, and parabolic interpolation. Shared by extraction and live mic.
- `extractTarget()`: downsample to 16 kHz, 100 ms / 25 ms window-hop, chunked with rAF and a progress bar, median-of-5 smoothing, auto display range.
- Visualization: piano-roll canvas, note lanes, now-line at 30%, blue target ribbon scrolling left, green live-pitch trail and dot colored by cents error (green <=50, yellow <=120, red beyond).
- Playback: optional backing track; falls back to playing the vocal stem as a fadeable guide. Guide volume slider.
- Scoring: per-frame, within 100 cents counts as a hit; on-pitch % readout alongside live note and cents.

**Decisions**

- **Local single-file tool, not a hosted app.** Full mic access, zero infra, private. `file://` is a secure context so `getUserMedia` works by double-clicking.
- **Vocal WAV stem is the MVP target source.** Chad confirmed all songs have vocal stems as audio; MIDI conversion is easy but deferred. MIDI-target path is the planned upgrade for clean note blocks.
- **Autocorrelation over FFT/YIN for v0.** Simple, fast enough, good enough to validate the loop. Better algorithms are a later phase.

**Repo**

- Created private repo `chadworksweb/CL-vocal-trainer`, initialized git locally, first commit pushed to `master`.

**Known gaps carried forward** (see [CLVT-PLANNING-BACKLOG](CLVT-PLANNING-BACKLOG.md))

- No latency calibration between mic and playback.
- Per-frame scoring, not per-note.
- Extraction gets noisy on breathy / harmonized / reverby stems.

**Not yet tested with a real exported stem.** MVP validated by construction; awaiting a first real-song run.
