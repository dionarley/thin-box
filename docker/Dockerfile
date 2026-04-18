# ==========================================
# Thin Box - Docker Build Environment
# ==========================================

FROM archlinux:base

RUN pacman-key --init && pacman -Sy --noconfirm \
    base-devel \
    limine \
    squashfs-tools \
    cpio \
    xorriso \
    qemu-full \
    docker \
    lxc \
    && rm -rf /var/cache/pacman/pkg/*

# Thin user
RUN useradd -m -m thin && echo "thin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/thin

WORKDIR /workspace

# Copy scripts
COPY scripts/ /workspace/scripts/
COPY src/ /workspace/src/
COPY limine/ /workspace/limine/

RUN chmod +x /workspace/scripts/*.sh

CMD ["/bin/bash"]