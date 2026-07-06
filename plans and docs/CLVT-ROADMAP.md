# CLVT — Roadmap

Phased plan. Phase 0 is done; everything below it is proposed, not committed.

---

## Phase 0 — MVP (done, 2026-07-06)

- Single-file app, vocal-stem target extraction, live pitch tracking, scrolling ribbon, per-frame scoring.
- Repo created and pushed.

## Phase 1 — Make the core loop honest

The MVP proves the concept; this phase makes the feedback trustworthy.

- **Latency calibration.** A slider (and ideally a one-tap auto-calibration) to align mic capture against the playback clock, so your dot sits where you actually sang.
- **Per-note scoring.** Segment the target into notes and score note-by-note (percent of the note held on pitch), not just raw frames. Show a per-note pass/miss and an end-of-song summary.
- **Smoothing of the live dot.** Light median/hysteresis so the dot reads as a line, not a jitter cloud.

## Phase 2 — MIDI target path

- Load a **MIDI melody export** from Ableton as the target instead of extracting from audio. Clean note blocks, no extraction noise, exact timing.
- Per-song choice of source: MIDI when available, audio-stem extraction otherwise.
- This is the natural accuracy ceiling for the target line.

## Phase 3 — Song library

- Persist loaded songs (name, stem, backing, cached target curve) via IndexedDB so you do not re-import and re-extract every session.
- A song picker. Optionally cache extraction results to skip the analysis pass on reload.
- Save session scores to track progress over time.

## Phase 4 — Better detection and richer feedback

- Swap autocorrelation for a stronger monophonic tracker (MPM / YIN-style) for cleaner extraction and live tracking.
- Optional vocal isolation so a full-mix input can work when no clean stem exists.
- Feedback beyond pitch: vibrato view, onset/timing accuracy, breath/loudness cues.
- Countdown, lyric line display, section looping (practice one phrase on repeat).

## Parked ideas (not scheduled)

- Packaging as a standalone desktop app (Tauri/Electron) for a nicer launch than `file://`.
- Difficulty modes (tolerance bands), scoring streaks, a practice-history graph.
- Harmony training (two target lines).
