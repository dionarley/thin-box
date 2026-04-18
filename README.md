# Thin Box

Enterprise Linux thin client for real hardware deployments.

## Overview

Thin Box is a modern, secure thin client for corporate and industrial environments. Built with minimal attack surface, immutable infrastructure, and container-based applications.

## Quick Start

```bash
./scripts/check-location.sh              # Check disk space
sudo ./scripts/build-rootrootfs.sh        # Build rootfs (requires root)
./src/initramfs/build.sh                  # Build initramfs
./scripts/run-in-qemu.sh                  # Test in QEMU
```

## Architecture

Hardware -> Limine -> Kernel -> initramfs -> Openbox -> Docker/LXC -> Apps

## Tech Stack

| Layer | Component |
|-------|-----------|
| Boot | Limine (UEFI/BIOS) |
| Base | Arch Linux minimal |
| UI | Openbox + tint2 |
| Runtime | Docker + LXC |
| Apps | RDP, VNC, Chromium |

## Documentation

Full documentation available at: https://dionarley.github.io/thin-box/

- **Features**: See Docs/README.md or wiki
- **Build Guide**: See docs/build.md or wiki  
- **Security**: See docs/security.md or wiki
- **Development**: See AGENTS.md

## Requirements

- x86_64 CPU
- 1-2 GB RAM
- UEFI or BIOS
- 2GB disk space

## License

MIT