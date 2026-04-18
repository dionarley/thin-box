#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
LIMINE_DIR="$PROJECT_DIR/limine"
OUT_ISO="$PROJECT_DIR/thin-client.iso"

echo "[thin-box] Building ISO..."
echo "[info] Output: $OUT_ISO"

[ ! -d "$LIMINE_DIR" ] && echo "[error] limine/ not found" && exit 1

for f in rootfs.squashfs initramfs-linux.img limine.cfg; do
  [ ! -f "$LIMINE_DIR/$f" ] && echo "[error] Missing: $f" && exit 1
done

command -v xorriso >/dev/null 2>&1 || { echo "[error] xorriso not installed: pacman -S xorriso"; exit 1; }

rm -f "$OUT_ISO"

echo "[thin-box] Creating ISO image..."
xorriso -as mkisofs \
  -iso-level 3 \
  -rock \
  -joliet \
  -output "$OUT_ISO" \
  "$LIMINE_DIR"

if [ -x "$(command -v limine)" ]; then
  echo "[thin-box] Installing limine bootloader..."
  limine bios-install "$OUT_ISO" 2>/dev/null || echo "[warn] limine bios-install skipped"
fi

SIZE=$(du -h "$OUT_ISO" | cut -f1)
echo "[thin-box] ISO ready: $OUT_ISO ($SIZE)"
ls -lh "$OUT_ISO"