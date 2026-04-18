#!/bin/bash
set -e

chromium \
  --kiosk \
  --no-first-run \
  --disable-infobars \
  https://app.remoto.local