# Quick Start

This is the shortest practical setup path for the local proxy.

## Start The Service

```bash
bun install
bun run src/main.ts start
```

Default port: `8964`.

For isolated tests:

```bash
ANTI_API_DATA_DIR=/tmp/anti-api-test bun run src/main.ts start
```

## Connect A Client

For Anthropic-compatible clients:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:8964",
    "ANTHROPIC_AUTH_TOKEN": "any-value"
  }
}
```

## Open The Panels

- Quota dashboard: `http://localhost:8964/quota`
- Routing panel: `http://localhost:8964/routing`
- Settings panel: `http://localhost:8964/settings`
- Remote access panel: `http://localhost:8964/remote-panel`

## Add Accounts

- Use the provider-specific login flow
- Import each account into the local account store
- Repeat for every Codex, Copilot, Zed, or Antigravity account you want available

## Sanity Check

Use these quick checks before deeper testing:

```bash
curl -s http://localhost:8964/quota
curl -s http://localhost:8964/routing
curl -s http://localhost:8964/settings
```

If any page fails, check whether the service is listening on `8964` and whether the data directory is writable.

## Add More Capacity

- Add more accounts when one provider hits `429`
- Prefer rotation over manual per-request rescue
- Keep at least one fallback account per provider when possible
