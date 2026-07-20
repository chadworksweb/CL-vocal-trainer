# CL Vocal Trainer

A browser-based voice training tool modeled on the *Let's Sing* video game. Load one of your own vocal stems, sing against the target melody, and watch your live pitch tracked and scored in real time. A Libra Engine product, developed by ChadWorks, published under the Chad Lewine name at `chadlewine.com/vocal-trainer`.

Everything runs on the device. The audio you load and your voice are never uploaded; there are no network calls. The app is a single HTML file plus a small set of PWA assets.

## Run it

- **Locally:** double-click `index.html`, or open it in your browser. Mic access works because `file://` is a secure context.
- **Hosted:** served as static files at `chadlewine.com/vocal-trainer`. Mic needs HTTPS, which the hosted path provides. It is a PWA, so it can be installed and added to a phone home screen, and it runs offline once loaded.

## Use it

1. Export a **vocal stem** (WAV) from your session and load it as **Vocal stem**. The tool extracts the target pitch line from it.
2. Optionally load a **backing track** (WAV) to sing over. Without one, the vocal stem plays as a guide; turn the **Guide** slider down to test yourself.
3. Tap **Enable mic**, then **Play**.

The target melody scrolls toward the now-line. Your green dot should ride on top of it. Green means within 50 cents, yellow within 120, red beyond. The **On pitch** readout is your running score.

**View** toggles the target between the flowing pitch ribbon and *Let's Sing* style note blocks. On a phone, use headphones so the guide does not leak into your mic, and turn sideways for a wider view of the melody.

## Files

- `index.html` -- the entire app (markup, CSS, vanilla JS). No framework, no build, no dependencies.
- `manifest.webmanifest`, `sw.js`, `icon-192.png`, `icon-512.png`, `apple-touch-icon.png` -- PWA install and offline support. Paths are relative, so the same files work from `file://` and from a hosted path.

## Status

Early MVP. Best results come from a clean, dry, solo vocal stem. Latency calibration, per-note scoring, and a MIDI-target path are planned.

## Docs

Build binder (prefix `CLVT-`) lives on Dropbox, separate from this repo:
`Dropbox/Chad Lewine/CL Vocal Trainer/plans and docs/`.
