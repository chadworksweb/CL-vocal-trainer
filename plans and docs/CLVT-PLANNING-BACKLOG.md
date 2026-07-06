# CLVT — Planning Backlog

Open questions and unresolved decisions. Move items into [CLVT-ROADMAP](CLVT-ROADMAP.md) once decided, or into [CLVT-BUILD-LOG](CLVT-BUILD-LOG.md) once resolved.

---

## Open questions

- **Latency:** how much offset is there between mic capture and the playback clock on Chad's machine? Needs a real measurement before designing the calibration UI. Fixed offset, or does it drift?
- **Extraction quality:** how noisy is the target line on a real exported stem? Decides how urgent the MIDI path and a better tracker are. Untested as of 2026-07-06.
- **Note segmentation:** what defines a note boundary from a continuous pitch curve (pitch-change threshold, minimum duration, gaps)? Needed for per-note scoring in Phase 1.
- **Stem export recipe:** what exact Ableton export gives the cleanest target (dry vs wet, solo lead, sample rate)? Worth writing a short recipe once validated so every song is prepped the same way.
- **Repo visibility:** currently private. Public later, or stays a personal tool?

## Decided (kept here for context)

- Target source for MVP = vocal WAV stem. (2026-07-06)
- Local single-file tool, not hosted. (2026-07-06)
- Autocorrelation for v0 detection. (2026-07-06)

## Nice-to-have, unprioritized

- End-of-song score screen with per-note breakdown.
- Section looping for drilling one phrase.
- Lyric line display synced to the target.
- Save/compare practice sessions over time.
