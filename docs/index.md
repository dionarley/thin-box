# Thin Box - Linux Thin Client

A modern Linux thin client for real hardware using Limine bootloader, Openbox, and container-based applications.

## Quick Start

```bash
# Check disk space
./scripts/check-location.sh

# Build rootfs (needs root)
sudo ./scripts/build-rootfs.sh

# Build initramfs
./src/initramfs/build.sh

# Test in QEMU
./scripts/run-in-qemu.sh
```

## Project Structure

- `scripts/` - Build and run scripts
- `src/rootfs/` - Root filesystem
- `src/initramfs/` - Initramfs
- `limine/` - Bootloader config
- `Docs/` - Feature documentation

## Links

- [Features](features.md)
- [Architecture](architecture.md)
- [Build Guide](build.md)
- [Security](security.md)