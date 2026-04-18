#!/bin/bash
set -e

echo "[thin-box] Build check"
echo

FREE=$(df -h . | tail -1 | awk "{print \$4}")
echo "Location: $(pwd) | Free: ${FREE}"
echo

df -h | grep -E "^/dev"
echo

REQUIRED="~2GB"
echo "Required: $REQUIRED"
echo

if [ -f "src/rootfs/.bootstrapped" ]; then
  echo "Status: rootfs bootstrapped"
else
  echo "Status: rootfs not bootstrapped (needs root)"
fi

if [ -f "limine/rootfs.squashfs" ]; then
  echo "Status: squashfs ready"
else
  echo "Status: squashfs not ready"
fi

echo
echo "Build steps:"
echo "  1. sudo ./scripts/build-rootfs.sh"
echo "  2. bash ./src/initramfs/build.sh"
echo "  3. ./scripts/build-iso.sh"
echo "  4. ./scripts/run-in-qemu.sh"