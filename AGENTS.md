# AGENTS.md - Thin Box Development Guide

Guidelines for agentic coding agents working on the Thin Box project (Linux thin client with Limine, Openbox, Docker/LXC).

---

## Build Commands

### Full Build

```bash
./scripts/build-rootfs.sh    # rootfs + squashfs
./src/initramfs/build.sh      # initramfs
./scripts/build-iso.sh        # ISO (if exists)
```

### Testing

```bash
./scripts/run-in-qemu.sh      # full system
./src/initramfs/test-qemu.sh # initramfs only

# Manual QEMU test
qemu-system-x86_64 -machine q35 -cpu host -m 2048 -enable-kvm \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd \
  -cdrom thin-client.iso -boot d -display gtk
```

### Container Testing

```bash
lxc launch images:archlinux/amd64 thin-test
lxc exec thin-test -- /bin/bash

docker build -t thin-box:test docker/ && docker run -it thin-box:test /bin/bash
```

---

## Code Style

### Shell Scripts

- `#!/bin/bash` complex, `#!/bin/sh` simple
- Always `set -e`
- 2-space indentation
- Quote variables: `"$VAR"`
- ALL_CAPS for constants

```bash
#!/bin/bash
set -e

ROOTFS=src/rootfs
OUT=limine/rootfs.squashfs

echo "[thin-box] Building rootfs..."

if [ ! -f "$ROOTFS/.bootstrapped" ]; then
    pacstrap -c $ROOTFS base linux-firmware
    touch "$ROOTFS/.bootstrapped"
fi
```

### File Organization

| Directory | Purpose |
|-----------|---------|
| `scripts/` | build/run scripts |
| `src/rootfs/` | filesystem contents |
| `src/initramfs/` | early boot files |
| `limine/` | bootloader config |
| `docs/` | documentation |
| `docker/` | Dockerfiles |

---

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Scripts | kebab-case | `build-rootfs.sh` |
| Variables | snake_case | `rootfs_dir` |
| Constants | UPPER_SNAKE | `ROOTFS` |
| Paths | relative | `src/rootfs/` |

---

## Error Handling

- `set -e` at script top
- Check returns: `if ! command; then error; fi`
- Validate inputs: `[ -d "$dir" ] || die "not found"`
- Error to stderr: `echo "[error] message" >&2`

---

## Git

- Commit: imperative lowercase, e.g. `add build-rootfs script`
- Branch: `feature/description` or `fix/description`

---

## Dependencies

```bash
pacman -S base-devel limine squashfs-tools cpio xorriso
pacman -S qemu-full docker lxc  # optional
```

---

## Testing

1. Test in QEMU before committing
2. Verify boot succeeds
3. Check squashfs builds without error
4. Validate Limine config syntax

---

## TDD (Test-Driven Development)

For shell scripts, apply TDD as follows:

1. **Write a failing test first**
   ```bash
   # Test script exists and is executable
   [ -x "./scripts/build-rootfs.sh" ] || exit 1
   ```

2. **Run the test** → it should fail

3. **Write just enough code to pass**
   ```bash
   #!/bin/bash
   set -e
   echo "rootfs build placeholder"
   ```

4. **Refactor** to the final implementation

5. **Verify** test passes

### Script Testing Patterns

```bash
# Test: script exits 0
./scripts/build-rootfs.sh && echo "pass"

# Test: output contains expected
./scripts/build-rootfs.sh 2>&1 | grep -q "rootfs ready" || exit 1

# Test: file created
[ -f "limine/rootfs.squashfs" ] || exit 1

# Test: symlink points to correct target
[ -L "/etc/systemd/system/multi-user.target.wants/NetworkManager" ] || exit 1
```

### Running a Single Test

```bash
# Direct execution
./scripts/build-rootfs.sh

# With output capture
./scripts/build-rootfs.sh 2>&1 | tee /tmp/build.log

# Quick smoke test
bash -n scripts/build-rootfs.sh  # syntax check only
```

---

## Key Files

| File | Purpose |
|------|---------|
| `scripts/build-rootfs.sh` | rootfs + squashfs |
| `src/initramfs/build.sh` | initramfs |
| `scripts/run-in-qemu.sh` | QEMU test |
| `limine/limine.cfg` | boot config |
| `docs/README.architecture.md` | architecture |
| `docs/README.build.md` | build process |

---

## Security

- Never commit credentials/keys
- Read-only system where possible
- Use containers for isolation

---

This file updates as project conventions evolve.