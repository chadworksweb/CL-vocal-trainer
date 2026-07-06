# CLVT — Scope

**Project:** CL Vocal Trainer (CLVT)
**Repo:** https://github.com/chadworksweb/CL-vocal-trainer (private)
**Local path:** `C:\Users\chad\voice-trainer`
**Owner:** Chad Lewine
**Started:** 2026-07-06

---

## What It Is

A local, browser-based voice training tool modeled on the *Let's Sing* video game. You load one of your own songs, the tool draws the target melody as a scrolling ribbon, and you sing against it while your live pitch is tracked and scored in real time.

The whole point is to **see** what you are singing: a moving dot riding (or missing) a target line, plus a running on-pitch score.

## Thesis

Pitch practice sticks when the feedback loop is immediate and visual. A dot that turns green when you land the note teaches faster than an ear-only "sounded a bit flat." Driving it from your own catalog means you practice the songs you actually perform, not a generic scale exercise.

## What It Is (concretely, today)

- A single self-contained `index.html`. No build step, no dependencies, no server, no network calls.
- Runs by double-clicking the file (opens `file://` in the browser). Mic works because `file://` is a secure context.
- Input: a **vocal stem WAV** exported from Ableton. The tool extracts the target pitch line from it in-browser.
- Optional second input: a **backing track WAV** to sing over. Without it, the vocal stem itself plays as a guide (fadeable).
- Output: live note name, cents off target, and an on-pitch percentage.

## What It Is Not

- Not a hosted web app. It is a local tool by design (full mic access, zero infra, private).
- Not a DAW plugin or an Ableton device. It reads exported audio, it does not talk to Ableton.
- Not a mixing / recording tool. It does not save your performance audio.
- Not a general music game with a song store. The library is your own exported stems.
- Not a polished product yet. This is an MVP built to validate the core loop.

## Boundaries

- Target melody source for the MVP is a **vocal WAV stem**. A cleaner MIDI-target path is planned (see ROADMAP) but out of scope for v0.
- Monophonic pitch only. It tracks one voice, not harmonies or chords.
- Single song per session. No persistent library yet.

## Success Criteria (MVP)

- Load a real exported stem, get a target ribbon that visibly follows the actual melody.
- Sing into the mic and see the dot track your pitch with usable accuracy.
- The on-pitch score moves in the right direction when you sing better or worse.

## Cross-Reference Check

- Personal tooling under `chadworksweb`. No LEIT infra, no shared DB, no agent registry entry.
- Related in spirit to Rising Compass (pitch/audio work) but shares no code or data.
