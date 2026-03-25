---
name: anti-api
description: Quickly configure a test-project API bridge that routes and exposes quota-backed models from Codex, GitHub Copilot, Zed, and Antigravity. Use when the user needs a concise setup guide for Anti-API-style local routing, account login, quota handling, and live model sync for these four providers.
---

# Anti-API

Use this skill to set up a local test-project proxy that exposes Codex, GitHub Copilot, Zed, and Antigravity accounts through one API surface, then keeps model lists and quota state in sync.

This skill is based on the local `anti-api-main` project. It summarizes the core setup flow and omits unrelated implementation detail.

## What This Skill Covers

- Initial install and startup
- Provider login and account import
- Quota behavior and account rotation
- Live model fetch for Codex, Copilot, Zed, and Antigravity
- Routing setup for custom model flows and official model IDs
- Minimal verification steps
- Reproducible test checkpoints for another agent
- Risk notes for quota abuse, lockout, and policy violations

## Core Ideas

1. Anti-API is a local proxy, not a hosted SaaS.
2. Accounts are the source of quota and model access.
3. Official model requests are routed by account chains.
4. Custom model IDs use explicit routing flows.
5. When a provider hits 429 or capacity limits, rotate or fall back.

## Risk Notes

This setup can trigger provider-side enforcement if it is used too aggressively or in ways that violate a provider's current terms.

- Excessive request volume can exhaust free quotas and trigger throttling
- Repeated multi-account rotation can look like abuse and may lead to review, suspension, or login disruption
- Provider policy changes can invalidate login flows, model access, quota assumptions, or reverse-proxy behavior at any time
- Check the current privacy policy, terms of service, and acceptable-use policy for each provider before relying on the setup

Do not use this skill to bypass billing, quota, identity, or access controls.

## Quick Setup

### 1. Install and start

Typical local start:

```bash
bun install
bun run src/main.ts start
```

Default service port is `8964`.

If you are validating a clone of this skill, confirm that the dashboard, routing panel, and API all come up before adding accounts.

Recommended local layout for reproducible tests:

- `src/` for the proxy implementation
- `public/` for the dashboard UI
- `test/` for API, routing, and sync tests
- `~/.anti-api/` for local runtime data

If you need a clean test run, point `ANTI_API_DATA_DIR` at a temporary directory so the account store and caches do not reuse old state.

For Claude Code-compatible clients, point the base URL at the local server:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:8964",
    "ANTHROPIC_AUTH_TOKEN": "any-value"
  }
}
```

### 2. Add accounts for the providers

Open the relevant login flow, then import the account into Anti-API.

- Codex: log in with the Codex account and let the local auth state be discovered
- GitHub Copilot: log in with the Copilot account and import it into the account store
- Zed: import the current signed-in `Zed.app` account from macOS Keychain one by one
- Antigravity: log in through the Antigravity flow and store the session tokens locally

For multi-account rotation, repeat the import step for each account. The project keeps the account pool under the local data directory.

When reproducing this for tests, create at least one account per provider before checking live model sync. That cleanly separates login-flow success from routing success.

### 3. Understand quota behavior

The project uses account-level quota as the supply source.

- When one account returns `429`, the system can switch to the next account
- Accounts are rate-limited for a short cooling period after quota errors
- When all accounts are unavailable, the system waits for the earliest recovery
- Zed hosted models are handled as a shared billing-period pool rather than a simple remaining-percentage meter

If a provider is exhausted, add more accounts or wait for the reset window.

For test planning, define a traffic ceiling in advance so you do not accidentally burn through a real account during validation.

## Model Pulling And Sync

The most important operational step is live model sync from authenticated accounts.

### Codex

- The router fetches models from each logged-in Codex account
- If live sync fails, the system falls back to static model data
- A per-account model map is kept so the UI can show which account supports which models

### GitHub Copilot

- The router fetches models from each logged-in Copilot account
- Per-account model lists are merged into a provider-level view
- If live sync fails, the system falls back to static defaults

### Zed

- Zed models are fetched from the currently imported Zed account state
- Accounts are imported one at a time, not bulk-discovered
- Live sync is timed and retried conservatively

### Antigravity

- The router attempts live fetch from the first available Antigravity account
- If the fetch succeeds, the dynamic model list replaces the fallback list
- If it fails or the provider is unavailable, the static fallback remains in place

### Model Sync Verification

When another agent re-implements this skill, verify the model sync path in this order:

1. Start the server from a clean local data directory
2. Log in one provider account
3. Confirm that the provider appears in the routing panel
4. Trigger the provider model fetch path
5. Confirm that the dynamic model list is stored per provider or per account
6. Restart the server and confirm the cached state is still readable
7. Break or disable the provider login and confirm the static fallback still works

## Routing Setup

Use the routing panel to decide how model IDs map to accounts and providers.

### Two routing modes

- Flow routing: custom IDs such as `route:fast` or `route:my-flow`
- Account routing: official model IDs such as `claude-sonnet-4-5`

### Typical flow setup

1. Open `http://localhost:8964/routing`
2. Create a flow for a task family such as `fast`, `opus`, or `test`
3. Add entries in provider order
4. Choose an account and model for each entry
5. Save the flow and send requests with `model: "route:<flow-name>"`

### Typical account routing setup

1. Pick an official model ID in the routing panel
2. Attach one or more accounts in priority order
3. Optionally enable smart switching
4. Send requests directly with the official model ID

### Routing Validation Checklist

- A custom `route:` model uses flow routing
- An official model ID uses account routing
- A missing flow returns a clear error rather than a silent fallback
- A `429` or quota exhaustion event triggers rotation or fallback
- Per-account model lists still render after a provider sync refresh

## API Endpoints

The server supports:

- `/v1/messages`
- `/v1beta/messages`
- `/messages`
- OpenAI-style `/v1/chat/completions`

Example:

```bash
curl -X POST http://localhost:8964/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: any-value" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-5",
    "max_tokens": 1024,
    "messages": [
      {"role": "user", "content": "Hello!"}
    ]
  }'
```

## Provider-Specific Notes

- Codex and Copilot are the most natural fit for multi-account rotation and live model sync.
- Zed is imported from the local signed-in desktop state, so treat each account as a manual import.
- Antigravity provides the widest model proxy story, but the project explicitly notes that compatibility depends on the upstream service and reverse-engineering assumptions.

## Minimal Validation

After setup, verify all of these:

1. The server responds on `8964`
2. The provider login state is saved locally
3. The routing panel shows account summaries
4. Model lists appear after live sync
5. A request with a known model ID succeeds
6. A `429` or quota exhaustion event triggers fallback or rotation
7. Restart the app and confirm the account list and routing state still load
8. Check that the quota dashboard still reflects the current provider state

## Reproducible Test Plan

Use this plan when another agent needs to reproduce the skill and confirm it behaves correctly.

### Phase 1: Environment smoke test

1. Start from a clean local data directory or a clearly documented existing one
2. Install dependencies
3. Start the server
4. Open `/quota`, `/routing`, and `/settings`
5. Confirm the base URL and auth token format expected by clients
6. Confirm the data directory is the one you intended to use

Expected result:

- server listens on `8964`
- dashboard pages render
- no startup crash
- data is written to the expected directory

### Phase 2: Provider bootstrap test

1. Add one provider account
2. Verify it appears in the account list
3. Add a second account for the same provider when the provider supports multi-account rotation
4. Verify the account list preserves both entries
5. Restart the server and re-open the provider list

Expected result:

- each imported account is visible
- account labels or identifiers are stable enough for routing
- account state survives restart

### Phase 3: Live model sync test

1. Trigger model synchronization
2. Observe that models appear for the provider
3. Confirm that the provider-level list is populated
4. If the provider exposes per-account models, confirm those are visible too
5. Break the upstream login or disable the account and re-run sync

Expected result:

- dynamic models appear without manual hardcoding
- sync failures fall back to static defaults
- broken upstream state does not erase the last known usable fallback

### Phase 4: Routing test

1. Create one flow routing entry such as `route:test-fast`
2. Create one account-routing entry for an official model ID
3. Send a request using the custom flow
4. Send a request using the official model ID
5. Send a request for a missing flow name to confirm the error path

Expected result:

- custom flow and official model take different routing paths
- both paths return a valid response or a clear error
- missing flows fail visibly instead of silently choosing another provider

### Phase 5: Quota and fallback test

1. Simulate a `429` or use an exhausted account in a safe test environment
2. Confirm the system rotates or falls back
3. Confirm the failure is visible in logs or dashboard state
4. Repeat with a second provider to confirm behavior is provider-specific

Expected result:

- the request does not silently die
- the operator can see why fallback happened
- a second provider follows the same policy instead of breaking the routing stack

### Phase 6: Regression guard

1. Restart the server
2. Re-open the routing panel
3. Re-check provider account lists
4. Re-check cached model state
5. Verify the latest sync timestamp or last-known-state indicator if present

Expected result:

- state survives restart when expected
- stale or invalid provider state is handled gracefully
- stale state does not overwrite a valid fallback cache

## Guardrails

- Use this only for projects and accounts you are authorized to test
- Do not assume the live sync contract is stable across upstream changes
- Do not hardcode one provider's model list as permanent truth
- Keep the static fallback path available when live fetch fails
- Do not use this skill to encourage quota abuse, credential sharing, or policy evasion

## References

- Quick start and routing overview: [references/quick-start.md](references/quick-start.md)
- Provider behavior and quota notes: [references/providers.md](references/providers.md)
- Routing and model sync summary: [references/routing.md](references/routing.md)
