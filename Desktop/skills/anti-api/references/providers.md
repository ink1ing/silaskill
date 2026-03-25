# Providers

## Codex

- The router can fetch models live from each authenticated Codex account
- Per-account lists are merged into the provider model view
- If sync fails, the static fallback remains available

## GitHub Copilot

- The router can fetch models live from each authenticated Copilot account
- Each account can contribute its own model set to the provider pool
- If sync fails, the fallback model set is used

## Zed

- Zed accounts are imported one at a time from the current desktop login state
- The app does not bulk-discover multiple Zed logins the way it can for Codex/Copilot
- Hosted-model quota is better treated as a billing-period pool than a simple percent meter

## Antigravity

- Antigravity accounts can be imported and used as the upstream source for model proxying
- The router attempts live fetch from the first available account
- The project warns that upstream policy changes may affect long-term compatibility

## Quota Behavior

- `429` means rotate or wait
- Capacity exhaustion and quota exhaustion are treated differently in the code
- A short cool-down is used after rate-limit events

## Risk And Policy

These providers can change their terms, quotas, or login flows without notice.

- Check the current privacy policy and terms of service before using or sharing any automation built on top of them
- Do not use bulk account rotation to avoid provider limits
- Do not assume that reverse proxying, scraping, or session replay is always permitted
- Treat account lockout or review as a realistic outcome if traffic looks abusive
