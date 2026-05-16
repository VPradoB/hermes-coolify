# Hermes Coolify

Plug-and-play Hermes Agent deployment for Coolify.

This repo starts Hermes Gateway on a VPS with persistent state at `/opt/data`.
It is designed for WhatsApp, Spotify, cron jobs, and Firefly III.

## Coolify Setup

1. Create **New Resource**.
2. Choose **Docker Compose**.
3. Point Coolify at this repository.
4. Use `docker-compose.yml`.
5. Deploy.

The first boot creates a persistent Docker volume named `hermes-data` and seeds:

- `/opt/data/config.yaml`
- `/opt/data/.env`
- `/opt/data/logs/`
- `/opt/data/whatsapp/`

## Required After First Deploy

Open Coolify terminal for the `hermes` container and verify:

```bash
hermes auth status
hermes tools list
```

If you are migrating from your local machine, copy these into `/opt/data`:

```text
config.yaml
.env
auth.json
whatsapp/
```

After copying, restart the `hermes` service in Coolify.

## Spotify

Spotify toolset is enabled for CLI and WhatsApp in `seed/config.yaml`.

If you migrate `auth.json` and `.env` from local Hermes, Spotify should keep working.
If you authenticate on the VPS instead, run:

```bash
hermes auth spotify
```

Use this redirect URI in the Spotify app:

```text
http://127.0.0.1:43827/spotify/callback
```

For playback controls, Spotify must be open on at least one active device. Playback mutation requires Spotify Premium.

## WhatsApp

Hermes Gateway starts the WhatsApp bridge when configured. If session migration fails, pair again from container terminal/logs.

State lives in:

```text
/opt/data/whatsapp/
```

## Firefly III

Firefly is integrated as a Hermes skill plus a local helper command at:

```text
/opt/data/bin/firefly
```

Set these Coolify environment variables and redeploy:

```env
FIREFLY_BASE_URL=https://firefly.example.com
FIREFLY_TOKEN=your_personal_access_token
```

Hermes can then use Firefly for account lookup, transaction summaries, and expense creation. Examples:

```text
lista mis cuentas de Firefly
resumí mis gastos de este mes por categoría
registrá gasto 45000 supermercado desde mi cuenta principal en categoría comida
```

The token is never committed. Keep it only in Coolify environment variables or `/opt/data/.env`.

## Dashboard

Dashboard service is commented out by default.

If you enable it, put it behind Coolify auth/proxy. It can expose secrets and active sessions.

## Updating Hermes

Redeploy in Coolify. The Compose build context points at upstream Hermes:

```text
https://github.com/NousResearch/hermes-agent.git
```

Pin a branch/tag/commit later if you want reproducible builds.

## Security

- Do not commit real `.env` or `auth.json`.
- Protect Coolify project access.
- Keep `/opt/data` persistent and private.
- Do not expose dashboard or API server without auth.
