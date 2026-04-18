# Security

## Principles

- Read-only system base
- Container isolation
- Minimal attack surface
- No credentials in repo

## Best Practices

1. **System**: Keep root filesystem read-only
2. **Containers**: Use non-privileged containers
3. **Network**: Firewall on host
4. **Credentials**: Never commit secrets

## Threats Mitigated

- Host compromise via app vulnerabilities
- Persistence attacks (read-only prevents)
- Credential theft (none stored)

## Related

- [Security Documentation](README.security.md)