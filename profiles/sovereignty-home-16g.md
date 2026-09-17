# Profile: sovereignty-home-16g

**Kind:** YunoHost appliance *profile* (documentation + optional wrappers)  
**Hardware:** Intel N100/N150, 16GB RAM  
**Base OS:** Stock YunoHost on Debian (amd64) — **not** a custom distro

## Intent

A private household sovereignty box: password vault, DNS filtering, photos, collaborative docs, uptime monitoring, and a dashboard — reachable on LAN and via Tailscale, with SSO in front of apps, and backups you can actually restore.

## Non-negotiable posture

1. **No public exposure by default** — no residential WAN port-forwards to this box.
2. **Tailscale required for remote access** — install Tailscale at host/OS level (not in YunoHost catalog). Headscale may come later as optional control plane (`headscale` *is* in catalog).
3. **SSO / identity first** — YunoHost users + SSOwat before stacking apps.
4. **Email and card aliases OFF this box** — SimpleLogin or addy.io for email aliases; Privacy.com (or equivalent) for payment aliases.
5. **DNS blocking via AdGuard Home** (`adguardhome`).
6. **Refuse residential SMTP/mail servers and port-forwards** — ISP reputation/ToS, blocklists, and attack surface. Mail stays with a real provider; this box is not an MX.

## V1 catalog install order (exact IDs)

| # | Catalog ID | Notes |
|---|------------|--------|
| 1 | `vaultwarden` | Disable public signups immediately after install |
| 2 | `adguardhome` | Household DNS sinkhole / blocker |
| 3 | `immich` | ML/recognition off-peak / scheduled — not 24/7 on 16GB |
| 4 | `cryptpad` | Collaborative docs |
| 5 | `uptime-kuma` | Uptime / status |
| 6 | `homarr` | Dashboard. Do **not** use `homepage` (not in catalog). Homarr install notes ~7G RAM — plan free memory on 16GB |
| 7 | `restic` and/or `borg` | Primary backup apps. `borgmatic` is **not** a YunoHost app |

## Explicit non-goals (v1)

See [docs/what-not-to-install.md](../docs/what-not-to-install.md): Nextcloud, Jitsi, Matrix/Synapse, Ollama → deferred to v2 with rationale.

## Operator entry points

- Day 0: [docs/day0-operator.md](../docs/day0-operator.md)
- Household card: [docs/onboarding-card.md](../docs/onboarding-card.md)
- Domains/SSO: [docs/sso-domains.md](../docs/sso-domains.md)
- Backup/restore: [docs/backup-restore.md](../docs/backup-restore.md)
- Catalog honesty: [docs/catalog-notes.md](../docs/catalog-notes.md)
- Install wrapper: [scripts/install-v1-apps.sh](../scripts/install-v1-apps.sh)
