# 2026-07-06 — MVP Build and Binder Setup

## What happened

- Built the CL Vocal Trainer MVP from scratch: a single-file, local, browser-based voice trainer modeled on *Let's Sing*.
- Created the private GitHub repo `chadworksweb/CL-vocal-trainer` and pushed the first commit.
- Set up the build binder (prefix `CLVT`) inside the repo at `plans and docs/`.

## Decisions

- **Local single-file tool, not a hosted app.** Full mic access, zero infra, private. Runs from `file://`.
- **Vocal WAV stem is the MVP target source.** Chad has vocal stems for all songs; MIDI conversion is easy but deferred to a later phase for cleaner note blocks.
- **Autocorrelation for v0 pitch detection.** Simple and fast enough to validate the loop.
- **Binder prefix = `CLVT`**, lives in the repo (versioned with the code), session notes under `plans and docs/session notes/`.

## Built

- `index.html`: decode audio, offline target extraction (16 kHz downsample, 100 ms / 25 ms window-hop, median smoothing), mic capture, live autocorrelation pitch detection, canvas piano-roll with scrolling target ribbon, live green pitch dot/trail colored by cents error, per-frame on-pitch scoring, optional backing track with fadeable guide.
- Binder docs: SCOPE, MASTER-BUILD-PLAN, BUILD-LOG, ROADMAP, PLANNING-BACKLOG, CLAUDE.md.

## Pending / next

- **Not yet tested on a real exported stem.** First real-song run is the immediate next step.
- Phase 1: latency calibration (mic vs playback) + per-note scoring.
- Phase 2: MIDI-target import path.
- Open questions logged in CLVT-PLANNING-BACKLOG (latency amount, extraction quality on real stems, note segmentation, stem export recipe).

## Note

- Project not yet in global MEMORY.md (session notes location table). Offered to add it; awaiting Chad's go-ahead.
