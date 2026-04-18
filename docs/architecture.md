# Architecture

```
Hardware → Limine → Kernel → initramfs → Openbox → Docker/LXC → Apps
```

## Layers

| Layer | Components |
|-------|-----------|
| Boot | Limine, kernel, initramfs |
| Host | systemd, NetworkManager, Xorg |
| UI | Openbox, tint2, thin-launcher |
| Runtime | Docker, LXC |
| Apps | RDP, VNC, Chromium |

## Design Principles

- **Minimalism**: Only essential components on host
- **Immutability**: Read-only base system
- **Isolation**: Apps in containers
- **Reproducibility**: Build via Docker → QEMU → Hardware