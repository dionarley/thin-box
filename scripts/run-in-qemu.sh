#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "[thin-box] Testing ISO in QEMU..."

ISO="$PROJECT_DIR/thin-client.iso"
OVMF_CODE="/usr/share/OVMF/OVMF_CODE.fd"
OVMF_VARS="/usr/share/OVMF/OVMF_VARS.fd"
BIOS="/usr/share/qemu/bios.bin"

if [ ! -f "$ISO" ]; then
  echo "[error] ISO not found: $ISO"
  echo "Build with:"
  echo "  sudo ./scripts/build-rootfs.sh"
  echo "  bash ./src/initramfs/build.sh"
  echo "  ./scripts/build-iso.sh"
  exit 1
fi

echo "[info] ISO: $ISO ($(du -h "$ISO" | cut -f1))"

if [ -f "$OVMF_CODE" ] && [ -f "$OVMF_VARS" ]; then
  FIRMWARE="-drive if=pflash,format=raw,readonly=on,file=$OVMF_CODE -drive if=pflash,format=raw,file=$OVMF_VARS"
  echo "[info] Using UEFI (OVMF)"
elif [ -f "$BIOS" ]; then
  FIRMWARE="-bios $BIOS"
  echo "[info] Using BIOS"
else
  echo "[error] No firmware found. Install: pacman -S edk2-ovmf"
  exit 1
fi

echo "[info] Starting QEMU..."
echo "[info] Press Ctrl+C to stop"

qemu-system-x86_64 \
  -machine q35 \
  -cpu host \
  -m 2048 \
  -enable-kvm \
  $FIRMWARE \
  -cdrom "$ISO" \
  -boot d \
  -display gtk