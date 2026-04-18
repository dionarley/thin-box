#!/bin/bash
set -e

ISO="thin-client.iso"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
EXTERNAL_DISK="/run/media/dnly/758f4c8a-315c-4e21-ab17-1fa2d36f3a44"
BUILD_DIR="$EXTERNAL_DISK/Work/thin-box"

echo "[thin-box] Build Directory: $BUILD_DIR"
echo "[thin-box] Checking disk space..."

FREE=$(df -h "$EXTERNAL_DISK" | tail -1 | awk "{print \$4}")
echo "[info] Free space: ${FREE}"

# Check if Docker has space
DOCKER_FREE=$(df -h /var/lib/docker 2>/dev/null | tail -1 | awk "{print \$4}" || echo "0G")
echo "[info] Docker space: $DOCKER_FREE"

# Build on external disk if Docker has no space
if [[ "$DOCKER_FREE" == *"100%"* ]] || [[ "$DOCKER_FREE" == "0G" ]]; then
  echo "[warn] Docker low on space, building on external disk..."
  
  mkdir -p "$BUILD_DIR"
  cp -r "$PROJECT_DIR"/* "$BUILD_DIR/" 2>/dev/null || true
  
  cd "$BUILD_DIR"
  echo "[info] Run build in: $BUILD_DIR"
else
  echo "[info] Using Docker for QEMU..."
  IMAGE="thin-box:qemu"
  
  if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
    echo "[thin-box] Building QEMU image..."
    docker build -t "$IMAGE" -f - "$PROJECT_DIR" <<'EOF'
FROM archlinux:latest
RUN pacman -Sy --noconfirm qemu-full xorriso limine && rm -rf /var/cache/pacman/pkg/*
CMD ["/bin/bash"]
EOF
  fi
  
  docker run --rm -it \
    --device /dev/kvm:/dev/kvm \
    -v "$PROJECT_DIR:/workspace" \
    -w /workspace \
    -e DISPLAY="$DISPLAY" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    "$IMAGE" \
    qemu-system-x86_64 \
      -machine q35 \
      -cpu host \
      -m 2048 \
      -enable-kvm \
      -bios /usr/share/qemu/bios.bin \
      -cdrom "$ISO" \
      -boot d \
      -display gtk
fi