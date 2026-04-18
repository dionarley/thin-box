# Thin Box

A modern Linux thin client using Limine bootloader, Openbox, and Docker/LXC containers.

## Quick Start

```bash
# Check disk space
./scripts/check-location.sh

# Build (needs root)
sudo ./scripts/build-rootfs.sh
./src/initramfs/build.sh

# Test
./scripts/run-in-qemu.sh
```

## Documentation

- [Docs/README.md](Docs/README.md) - Features overview
- [docs/](docs/) - MkDocs wiki (features, architecture, build, security)
- [AGENTS.md](AGENTS.md) - Development guidelines

## Structure

| Directory | Purpose |
|-----------|---------|
| `scripts/` | Build and run scripts |
| `src/rootfs/` | Root filesystem |
| `src/initramfs/` | Initramfs |
| `limine/` | Bootloader |
| `Docs/` | Feature docs |
| `docs/` | Wiki docs |
| `docker/` | Dockerfiles |

## License

MIT