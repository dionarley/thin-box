# Build Guide

## Requirements

- x86_64 CPU
- 1-2 GB RAM
- ~2GB disk space
- Docker (for QEMU testing)

## Build Steps

```bash
# 1. Check disk space
./scripts/check-location.sh

# 2. Build rootfs (needs root on host)
sudo ./scripts/build-rootfs.sh

# 3. Build initramfs
bash ./src/initramfs/build.sh

# 4. Build ISO
./scripts/build-iso.sh

# 5. Test in QEMU (runs in Docker)
./scripts/run-in-qemu.sh
```

## Testing

QEMU runs in Docker container with KVM support.

```bash
./scripts/run-in-qemu.sh   # QEMU in Docker
```

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/check-location.sh` | Check disk space |
| `scripts/build-rootfs.sh` | Build rootfs + squashfs |
| `scripts/build-iso.sh` | Create bootable ISO |
| `scripts/run-in-qemu.sh` | Run in QEMU (Docker) |
| `src/initramfs/build.sh` | Build initramfs |

## Output

- `limine/rootfs.squashfs` - Compressed rootfs
- `limine/initramfs-linux.img` - Initramfs
- `thin-client.iso` - Bootable ISO