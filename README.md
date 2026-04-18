# Thin Box

Enterprise-grade Linux thin client for real hardware deployments.

## Overview

Thin Box is a modern, secure Linux thin client designed for corporate and industrial environments. Built with minimal attack surface, immutable infrastructure, and container-based applications.

## Key Features

| Feature | Description |
|---------|-------------|
| **Fast Boot** | Limine bootloader - 2-3x faster than GRUB |
| **Immutable** | Read-only root filesystem, optional OverlayFS |
| **Secure** | No direct apps on host, everything containerized |
| **Lightweight** | Openbox WM, ~500MB base system |
| **Enterprise** | NetworkManager, centralized management ready |

## Architecture

```
Hardware → Limine → Kernel → initramfs → Openbox → Docker/LXC → Apps
```

### Tech Stack

- **Boot**: Limine (UEFI/BIOS)
- **Base**: Arch Linux minimal
- **UI**: Openbox + tint2
- **Runtime**: Docker + LXC
- **Apps**: RDP, VNC, Chromium Kiosk

## Quick Start

```bash
# Check disk space
./scripts/check-location.sh

# Build (requires root)
sudo ./scripts/build-rootfs.sh
./src/initramfs/build.sh

# Test in QEMU
./scripts/run-in-qemu.sh
```

## Enterprise Features

### Security

- Read-only system base
- Container isolation (non-privileged)
- No credentials stored in repo
- Firewall-ready

### Management

- NetworkManager auto-connect
- Git-based configuration
- Container orchestration (Docker/LXC)
- Immutability for predictable updates

### Deployment

- PXE boot ready
- ISO generation
- Disk image for cloning
- QEMU validation before production

## Documentation

| Resource | Description |
|----------|-------------|
| [Wiki](https://dionarley.github.io/thin-box/) | Full documentation |
| [Docs/README.md](Docs/README.md) | Features overview |
| [AGENTS.md](AGENTS.md) | Development guide |

## Project Structure

```
.
├── scripts/          # Build & run automation
├── src/rootfs/       # Root filesystem
├── src/initramfs/    # Early boot
├── limine/           # Bootloader config
├── docker/           # Dockerfiles
├── Docs/             # Feature docs
├── docs/             # MkDocs wiki
└── mkdocs.yml        # Wiki config
```

## Requirements

- x86_64 CPU
- 1-2 GB RAM
- UEFI/BIOS
- ~2GB disk space

## License

MIT