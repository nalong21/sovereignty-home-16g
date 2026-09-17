# Backup and restore

Goal: you can lose the disk and still get **Vaultwarden** and the rest of the household stack back without heroics.

## Tools (YunoHost catalog)

| Tool | Catalog ID | Role |
|------|------------|------|
| Restic | `restic` | Primary-friendly; snapshots to local + remote |
| Borg | `borg` | Alternate / additional; deduplicating archives |

**`borgmatic` is not a YunoHost app.** If you want borgmatic, install it at **host level** only (optional). Prefer `restic` and/or `borg` from the catalog for v1.

Also use YunoHost’s own app backup helpers where useful (`yunohost backup`), but do **not** treat a single local-only archive as sufficient.

## Destinations (required pair)

1. **USB (local)** — encrypted drive plugged into the box (or rotated drives). Survives ISP / cloud outages; practice unplug/plug discipline.
2. **Offsite B2** — Backblaze B2 (or S3-compatible equivalent). Survives house fire / theft of the USB.

Keep repository passwords / keys **offline** as well as in Vaultwarden (bootstrap problem: vault restore needs keys that must exist outside the vault).

## What to include

Minimum v1 set:

- YunoHost system backup / app backups for: Vaultwarden, AdGuard Home config, Immich library metadata + data path, CryptPad, Uptime Kuma, Homarr
- App data directories Immich uses for originals (size will dominate)
- Headscale (catalog app) + Tailscale clients — note mesh node/identity recovery separately (re-auth to Headscale may be required)

Exclude junk: caches, Immich thumbnails if you accept rebuild cost (document your choice), temporary ML artifacts.

## Schedule suggestions (16GB box)

- Nightly: metadata-heavy / config backups
- Immich data: nightly or continuous restic forget/prune policy with care for disk I/O
- Run heavy verify / prune **off-peak** (same spirit as Immich ML)

## Vaultwarden restore drill (do this once on day 0/1)

Treat this as a fire drill, not a theory:

1. Take a fresh backup that includes Vaultwarden’s data (YunoHost app backup and/or restic/borg snapshot covering its datadir).
2. On a maintenance window (or spare VM with the same app ID), restore Vaultwarden from that backup.
3. Unlock with a known test account; confirm vault items present.
4. Confirm **public signups remain disabled** after restore.
5. Record time-to-restore and any missing paths in this file’s “Drill log” section below.
6. Destroy the drill instance or re-sync production as appropriate so you don’t leave a second live vault around.

If restore fails, fix the backup selection **before** trusting the box with more secrets.

## USB procedure (sketch)

1. LUKS (or equivalent) volume; unlock on boot or via documented manual unlock.
2. Mount at a stable path used by restic/borg.
3. First `restic init` / `borg init` to that path.
4. Scripted or app-scheduled backup; check logs weekly.
5. Quarterly: restore a small file set to a scratch directory.

## Offsite B2 procedure (sketch)

1. Create a private B2 bucket; least-privilege keys.
2. Configure restic/borg remote URL with env vars or a root-readable secrets file (mode `600`).
3. Initial full backup; then incremental schedule.
4. `restic check` / `borg check` on a cadence; prune with retention you can afford (e.g. daily/weekly/monthly policy).
5. Store bucket name + key ID offline; store secret key offline separately from the box when possible.

## Drill log

| Date | What restored | Destination used | Result | Notes |
|------|---------------|------------------|--------|-------|
| _YYYY-MM-DD_ | Vaultwarden | USB / B2 | pass/fail | |

## Anti-patterns

- Only backing up to the same SSD as live data
- Only cloud, no local USB (or the reverse)
- Storing the only copy of restic/borg passwords inside Vaultwarden with no offline escape hatch
- Skipping the Vaultwarden restore drill
