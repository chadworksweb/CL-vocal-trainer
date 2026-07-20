#!/usr/bin/env bash
# Push the current app files to the droplet. Run from anywhere:  bash deploy/deploy.sh
# The html dir is bind-mounted read-only into the vt-static nginx container, so
# replacing the files updates what is served immediately -- no restart needed.
set -euo pipefail
HOST=root@138.197.111.66
DEST=/home/deploy/vocal-trainer/html
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
scp "$ROOT"/index.html "$ROOT"/manifest.webmanifest "$ROOT"/sw.js \
    "$ROOT"/icon-192.png "$ROOT"/icon-512.png "$ROOT"/apple-touch-icon.png \
    "$HOST:$DEST/"
echo "Deployed to vt.chadlewine.com (files served immediately)."
