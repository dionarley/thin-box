# Build Guide

## Requirements

- x86_64 CPU
- 1-2 GB RAM
- ~2GB disk space
- Root access (for pacstrap)

## Build Steps

```bash
# 1. Check disk space
./scripts/check-location.sh

# 2. Build rootfs (needs root)
sudo ./scripts/build-rootfs.sh

# 3. Build initramfs
./src/initramfs/build.sh

# 4. Test in QEMU
./scripts/run-in-qemu.sh
```

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/check-location.sh` | Check disk space |
| `scripts/build-rootfs.sh` | Build rootfs + squashfs |
| `scripts/run-in-qemu.sh` | Run in QEMU |
| `src/initramfs/build.sh` | Build initramfs |

## Output

- `limine/rootfs.squashfs` - Compressed rootfs
- `limine/initramfs-linux.img` - Initramfs
- `thin-client.iso` - Bootable ISO