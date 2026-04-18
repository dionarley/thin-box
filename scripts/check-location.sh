#!/bin/bash
set -e

echo "=== Thin Box Build Location ==="
echo

FREE=$(df -h . | tail -1 | awk "{print \$4}")
echo "Current location: ${FREE} free"
echo

echo "Available mounts:"
df -h | grep -E "^/dev"
echo

REQUIRED="~2GB"
echo "Required for build: $REQUIRED"
echo

if [ -f "src/rootfs/.bootstrapped" ]; then
  echo "Status: rootfs bootstrapped"
else
  echo "Status: rootfs not bootstrapped (needs pacstrap as root)"
fi

echo
echo "To build: sudo ./scripts/build-rootfs.sh"
echo "To test:  ./scripts/run-in-qemu.sh"