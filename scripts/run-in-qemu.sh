#!/bin/bash
set -e

ISO="thin-client.iso"
IMAGE="thin-box:qemu"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Build Docker image if not exists
if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
  echo "[thin-box] Building QEMU image..."
  docker build -t "$IMAGE" -f - "$PROJECT_DIR" <<'EOF'
FROM archlinux:latest
RUN pacman -Sy --noconfirm qemu-full xorriso limine && rm -rf /var/cache/pacman/pkg/*
CMD ["/bin/bash"]
EOF
fi

echo "[thin-box] Running QEMU in Docker..."
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