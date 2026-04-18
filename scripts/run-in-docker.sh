#!/bin/bash
set -e

CONTAINER="thin-box:latest"

echo "[thin-box] Building container..."

docker build -t "$CONTAINER" -f - . <<'EOF'
FROM archlinux:latest
RUN pacman -Sy --noconfirm qemu-full xorriso limine sudo && \
    rm -rf /var/cache/pacman/pkg/*
RUN useradd -m -s /bin/bash thin && echo "thin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/thin
WORKDIR /workspace
CMD ["/bin/bash"]
EOF

echo "[thin-box] Container ready: $CONTAINER"
echo
echo "Usage:"
echo "  docker run --rm -it -v \$(pwd):/workspace $CONTAINER"
echo "  docker run --rm -it --device /dev/kvm:/dev/kvm -v \$(pwd):/workspace $CONTAINER qemu-system-x86_64 ..."