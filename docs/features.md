# Features

## Core

- **Fast Boot**: Limine bootloader (faster than GRUB)
- **Minimal System**: Arch Linux base with essential packages only
- **Immutable**: Read-only root filesystem with optional OverlayFS
- **Secure**: No direct user apps on host, everything in containers

## Interface

- **Openbox WM**: Lightweight window manager
- **thin-launcher**: Custom app launcher
- **tint2**: Panel/taskbar
- **Chromium Kiosk**: Web app mode

## Container Support

- **Docker**: Isolated graphical apps
- **LXC**: Persistent user environments

## Boot

- **Limine**: UEFI/BIOS bootloader
- **Kernel**: Custom Linux
- **Initramfs**: Busybox-based early boot

## Network

- **NetworkManager**: Auto-connect
- **Ethernet/WiFi**: Supported