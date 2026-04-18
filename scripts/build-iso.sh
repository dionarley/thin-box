#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
LIMINE_DIR="$PROJECT_DIR/limine"
OUT_ISO="$PROJECT_DIR/thin-client.iso"

echo "[thin-box] Building ISO..."

[ ! -d "$LIMINE_DIR" ] && echo "[error] limine/ not found" && exit 1

for f in rootfs.squashfs initramfs-linux.img limine.cfg; do
  [ ! -f "$LIMINE_DIR/$f" ] && echo "[error] Missing: $f" && exit 1
done

command -v xorriso >/dev/null 2>&1 || { echo "[error] xorriso not installed"; exit 1; }

rm -f "$OUT_ISO"

xorriso -as mkisofs \
  -iso-level 3 \
  -rock \
  -joliet \
  -output "$OUT_ISO" \
  "$LIMINE_DIR"

[ -x "$(command -v limine)" ] && limine bios-install "$OUT_ISO" 2>/dev/null || true

echo "[thin-box] ISO ready: $OUT_ISO"
ls -lh "$OUT_ISO"