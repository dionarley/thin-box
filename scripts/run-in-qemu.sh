#!/bin/bash
set -e

ISO="thin-client.iso"
OVMF_CODE="/usr/share/OVMF/OVMF_CODE.fd"
OVMF_VARS="/usr/share/OVMF/OVMF_VARS.fd"
BIOS="/usr/share/qemu/bios.bin"

if [ ! -f "$ISO" ]; then
  echo "[error] ISO not found: $ISO"
  echo "Build with: ./scripts/build-rootfs.sh && ./src/initramfs/build.sh"
  exit 1
fi

if [ -f "$OVMF_CODE" ] && [ -f "$OVMF_VARS" ]; then
  FIRMWARE="\
    -drive if=pflash,format=raw,readonly=on,file=$OVMF_CODE \
    -drive if=pflash,format=raw,file=$OVMF_VARS"
  echo "[info] Using UEFI (OVMF)"
elif [ -f "$BIOS" ]; then
  FIRMWARE="-bios $BIOS"
  echo "[info] Using BIOS"
else
  echo "[error] No firmware found. Install edk2-ovmf or check qemu"
  exit 1
fi

qemu-system-x86_64 \
  -machine q35 \
  -cpu host \
  -m 2048 \
  -enable-kvm \
  $FIRMWARE \
  -cdrom "$ISO" \
  -boot d \
  -display gtk