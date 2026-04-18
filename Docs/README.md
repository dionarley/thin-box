# Thin Box - Features & Documentation

A modern Linux thin client for real hardware with Limine bootloader, Openbox, and container-based applications.

---

## Features

### Core

- **Fast Boot**: Limine bootloader (faster than GRUB)
- **Minimal System**: Arch Linux base with only essential packages
- **Immutable**: Read-only root filesystem with optional OverlayFS
- **Secure**: No direct user apps on host, everything in containers

### Interface

- **Openbox WM**: Lightweight window manager
- **thin-launcher**: Custom app launcher
- **tint2**: Panel/taskbar
- **Chromium Kiosk**: Web app mode

### Container Support

- **Docker**: Isolated graphical apps
- **LXC**: Persistent user environments

---

## Architecture

```
Hardware → Limine → Kernel → initramfs → Openbox → Docker/LXC → Apps
```

### Layers

| Layer | Components |
|-------|-----------|
| Boot | Limine, kernel, initramfs |
| Host | systemd, NetworkManager, Xorg |
| UI | Openbox, tint2, thin-launcher |
| Runtime | Docker, LXC |
| Apps | RDP, VNC, Chromium |

---

## Build

```bash
./scripts/check-location.sh   # Check disk space
sudo ./scripts/build-rootfs.sh  # rootfs + squashfs (needs root)
./src/initramfs/build.sh      # initramfs
./scripts/run-in-qemu.sh     # test in QEMU
```

### Estimated Size

- rootfs + squashfs: ~500MB-2GB
- initramfs: ~20MB
- limine binaries: ~35MB
- **Total**: ~600MB-2.5GB

---

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/check-location.sh` | Check disk space |
| `scripts/build-rootfs.sh` | Build rootfs and squashfs |
| `scripts/run-in-qemu.sh` | Run in QEMU |
| `scripts/run-in-docker.sh` | Run Docker container |
| `scripts/run-in-lxc.sh` | Launch LXC container |
| `scripts/Kiosk-Chromium.sh` | Chromium kiosk mode |

---

## Disk Space

Current locations:

| Disk | Free | Notes |
|------|------|-------|
| sdb2 (project) | 66G | Recommended |
| / | 817M | Not enough |
| /home | 4.5G | Not enough |

Run `./scripts/check-location.sh` to check current space.

---

## Configuration

- `limine/limine.cfg` - Boot config
- `src/rootfs/etc/xdg/openbox/` - Openbox config
- `.config/openbox/` - User overrides

---

## Requirements

- x86_64 CPU
- 1-2 GB RAM
- UEFI boot
- Network (Ethernet/WiFi)

---

## Security

- Read-only system
- Container isolation
- No credentials in repo
- Firewall recommended

---

## License

MIT