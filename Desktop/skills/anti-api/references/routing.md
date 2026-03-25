# Routing

## Two Routing Paths

### Flow routing

Use custom model IDs like `route:fast`.

Good for:

- test projects
- manual provider mixing
- fixed fallback chains

### Account routing

Use official model IDs like `claude-sonnet-4-5`.

Good for:

- provider-level account chains
- automatic rotation
- UI-driven model selection

## Sync Strategy

- Fetch live provider models from authenticated accounts
- Merge results into provider-level lists
- Keep per-account model maps for the UI
- Fall back to static model data when live fetch fails

## Testing Notes

- Verify both the flow-routing and account-routing branches
- Verify model lists after provider sync and after a restart
- Verify that a missing flow returns a visible error instead of picking a random provider
- Verify that `429` handling produces rotation or fallback

## Practical Rule

Do not treat a dynamic model list as permanent.

If the upstream login changes, refresh the account and re-sync the models before relying on the list for testing.
