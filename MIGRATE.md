# Migration From Local Hermes

Local paths:

```text
~/.hermes/config.yaml
~/.hermes/.env
~/.hermes/auth.json
~/.hermes/whatsapp/
```

VPS container path:

```text
/opt/data/
```

## Safe Copy Plan

1. Deploy once so Coolify creates the volume.
2. Stop or pause Hermes in Coolify.
3. Copy files into `/opt/data`.
4. Start Hermes again.
5. Check logs.

## Archive Local State

Run locally:

```bash
tar -C ~/.hermes -czf hermes-migrate.tar.gz config.yaml .env auth.json whatsapp
```

Upload `hermes-migrate.tar.gz` to VPS/Coolify, then inside the container or mounted volume:

```bash
tar -C /opt/data -xzf hermes-migrate.tar.gz
chmod 600 /opt/data/.env /opt/data/auth.json
```

## Notes

- OAuth tokens in `auth.json` are sensitive.
- Spotify Client ID in `.env` is not a secret, but keep it server-side anyway.
- WhatsApp may still ask for QR re-pairing if the session does not survive host/container change.
