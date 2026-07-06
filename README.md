# CL Vocal Trainer

A local, browser-based voice training tool modeled on the *Let's Sing* video game. Load one of your own songs, sing against the target melody, and watch your live pitch tracked and scored in real time.

No install, no build, no server, no network. It is a single HTML file.

## Run it

Double-click `index.html` (or open it in your browser). Mic access works because `file://` is a secure context.

## Use it

1. Export a **vocal stem** (WAV) from Ableton and load it as **Vocal stem**. The tool extracts the target pitch line from it.
2. Optionally load a **backing track** (WAV) to sing over. Without one, the vocal stem plays as a guide, turn the **Guide** slider down to test yourself.
3. Click **Enable mic**, then **Play**.

The blue ribbon is the target melody scrolling toward the now-line. Your green dot should ride on top of it. Green means within 50 cents, yellow within 120, red beyond. The **On pitch** readout is your running score.

## Status

Early MVP. Best results come from a clean, dry, solo vocal stem. Latency calibration, per-note scoring, and a MIDI-target path are planned.

## Docs

Build binder lives in [`plans and docs/`](plans%20and%20docs/) (prefix `CLVT-`).
