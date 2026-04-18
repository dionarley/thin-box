#!/bin/bash
set -e

ROOTFS="src/rootfs"
OUT="limine/rootfs.squashfs"

[ "$(id -u)" -ne 0 ] && echo "[error] Run as root: sudo $0" && exit 1

FREE=$(df -h . | tail -1 | awk "{print \$4}")
echo "[thin-box] Building rootfs..."
echo "[info] Location: $(pwd) | Free: ${FREE}"

mkdir -p "$ROOTFS"/{proc,sys,dev,var}

# Bootstrap base (run once or when rebuild needed)
if [ ! -f "$ROOTFS/.bootstrapped" ]; then
  pacstrap -c "$ROOTFS" \
    base \
    linux \
    linux-firmware \
    busybox \
    openbox \
    xorg-server \
    xorg-xinit \
    tint2 \
    chromium \
    networkmanager \
    sudo

  touch "$ROOTFS/.bootstrapped"
fi

# Copy kernel to limine/
if [ -f "$ROOTFS/boot/vmlinuz-linux" ]; then
  cp "$ROOTFS/boot/vmlinuz-linux" "limine/vmlinuz-linux"
fi

# Basic config
echo "thin-box" > "$ROOTFS/etc/hostname"

cat > "$ROOTFS/etc/hosts" <<EOF
127.0.0.1 localhost
127.0.1.1 thin-box
EOF

cat > "$ROOTFS/etc/os-release" <<EOF
NAME="Thin Box"
ID=thinbox
VERSION=0.1
EOF

# Enable NetworkManager
ln -sf /usr/lib/systemd/system/NetworkManager.service \
  "$ROOTFS/etc/systemd/system/multi-user.target.wants/NetworkManager.service"

# Remove cache
rm -rf "$ROOTFS/var/cache/pacman/pkg/"*
rm -rf "$ROOTFS/usr/share/man/"*
rm -rf "$ROOTFS/usr/share/doc/"*

echo "[thin-box] Creating squashfs..."

mksquashfs "$ROOTFS" "$OUT" -comp zstd -Xcompression-level 15

# Copy kernel to limine/ for ISO boot
if [ -f "$ROOTFS/boot/vmlinuz-linux" ]; then
  cp "$ROOTFS/boot/vmlinuz-linux" "limine/vmlinuz-linux"
  echo "[thin-box] Kernel copied to limine/vmlinuz-linux"
fi

# Copy initramfs to limine/ if not exists
if [ ! -f "limine/initramfs-linux.img" ]; then
  cp "$ROOTFS/boot/initramfs-linux.img" "limine/initramfs-linux.img" 2>/dev/null || true
fi

echo "[thin-box] rootfs ready: $OUT"
