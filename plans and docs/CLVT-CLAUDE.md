# CLVT — CLAUDE.md

AI assistant context for the CL Vocal Trainer project. Read this first when picking up work here.

---

## What this is

A local, single-file browser tool for voice training, modeled on the *Let's Sing* game. Load a vocal stem, it draws the target melody as a scrolling ribbon, you sing against it and get scored on pitch. See [CLVT-SCOPE](CLVT-SCOPE.md).

## Where things are

- **Code:** `C:\Users\chad\voice-trainer\index.html` — the entire app.
- **Binder:** `C:\Users\chad\voice-trainer\plans and docs\` (prefix `CLVT-`).
- **Session notes:** `plans and docs\session notes\`.
- **Repo:** `chadworksweb/CL-vocal-trainer` (private). `origin` = `master`.

## How to run

Double-click `index.html`, or `start "" index.html`. It runs from `file://`; mic works because that is a secure context. No server, no build, no install.

## Ground rules for this project

- **Keep it dependency-free and single-file** until there is a real reason not to. No framework, no bundler, no package.json. If `index.html` gets unwieldy, split along module lines (detection / extraction / render / UI), not by adding tooling.
- **No network calls.** It is a local, private tool. Do not add analytics, CDNs, or remote fetches.
- **ASCII only in code** per global rules. The `.md` binder docs are prose and may use normal punctuation, but no em-dashes.
- **Don't claim it works until Chad confirms** on a real stem. The MVP is validated by construction, not yet by a real-song run.

## Architecture in one breath

`detectPitch()` (lag-restricted autocorrelation, shared by extraction and live mic) feeds `extractTarget()` (offline, chunked, produces `targetCurve`) and the `draw()` render loop (canvas piano-roll, now-line, scoring). Full detail in [CLVT-MASTER-BUILD-PLAN](CLVT-MASTER-BUILD-PLAN.md).

## What's next

Phase 1 is latency calibration + per-note scoring. Then the MIDI-target path. See [CLVT-ROADMAP](CLVT-ROADMAP.md) and open questions in [CLVT-PLANNING-BACKLOG](CLVT-PLANNING-BACKLOG.md).

## Cross-references

- Personal tool under `chadworksweb`. No LEIT infra, no shared DB, not in the Agent Registry.
