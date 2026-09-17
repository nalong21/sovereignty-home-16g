# sovereignty-home-16g

Pinned **YunoHost appliance profile** (docs + optional install wrappers) for N100/N150 **16GB** **home metal** boxes only — this repo does not document a VPS, cloud VM, or hybrid layout.

This is **not** a custom distro. Assume stock [YunoHost](https://yunohost.org/) on Debian. The profile documents posture, catalog IDs, install order, and day-0 operator steps so a 16GB mini-PC stays private, recoverable, and boring to operate.

## Posture (defaults)

| Rule | Meaning |
|------|---------|
| No public exposure by default | Do not port-forward WAN → home box. Apps stay on LAN / Headscale mesh. |
| Headscale required for remote | Remote access is via a **self-hosted Headscale** control server (`yunohost app install headscale`). Official **Tailscale clients** point at that Headscale server. Not residential port-forwards. |
| SSO before apps | YunoHost / SSOwat identity first; then install apps behind it. |
| Email & card aliases off-box | Use SimpleLogin or addy.io + Privacy.com — not mail or payment tooling on the home box. |
| DNS blocking | AdGuard Home for household DNS filtering. |
| No residential SMTP / mail | Refuse hosting mail or opening SMTP on residential ISP. See below. |

**Why refuse residential SMTP and port-forwards:** residential IPs are on blocklists; ISP ToS often forbids mail servers; open WAN ports turn a home box into an attack surface and break the “no public exposure” default. Keep mail and payment aliases with dedicated providers; keep the box reachable only via the Headscale mesh (or LAN).

> **Footnote — Tailscale SaaS:** Using Tailscale’s hosted coordination service (no Headscale) is a simpler day-0 alternative if you accept a third-party control plane. It is **not** the v1 requirement for this profile.

## Hardware target

- Intel N100 / N150 class mini-PC, **16GB RAM**
- Stock YunoHost (amd64)
- Enough headroom for Immich + Homarr install notes (Homarr catalog notes ~**7G** to install; Immich ~**2G**). Install Homarr only with Immich ML off / heavy jobs stopped, or **defer Homarr** until Immich is stable — avoid first-boot OOM on 16GB

## V1 install order (catalog IDs — exact)

**Mesh + identity first** (before treating apps as remotely reachable):

0. `headscale` — self-hosted control server; configure official Tailscale clients to use this Headscale URL (standard Headscale setup — same client app, different login server)
1. YunoHost SSO / users / SSOwat — identity before stacking apps

Then the v1 app set:

1. `vaultwarden` — disable public signups after install  
2. `adguardhome`  
3. `immich` — ML/recognition scheduled / off-peak, not 24/7  
4. `cryptpad`  
5. `uptime-kuma`  
6. `homarr` (**not** `homepage` — homepage is not in the YunoHost catalog) — **RAM caution:** ~7G to install; Immich ML off or defer Homarr  
7. Backup: `restic` and/or `borg` (both in catalog). `borgmatic` is **not** a YunoHost app — host-level optional only.

Remote access is **only** via the mesh (or LAN). Do not expose apps on the residential WAN.

See [docs/catalog-notes.md](docs/catalog-notes.md) and [docs/what-not-to-install.md](docs/what-not-to-install.md).

## Docs map

| Doc | Purpose |
|-----|---------|
| [profiles/sovereignty-home-16g.md](profiles/sovereignty-home-16g.md) | Full profile pin |
| [docs/day0-operator.md](docs/day0-operator.md) | First-boot / first-week checklist |
| [docs/onboarding-card.md](docs/onboarding-card.md) | Operator / full household card |
| [docs/onboarding-household.md](docs/onboarding-household.md) | Printable household bullets |
| [docs/sso-domains.md](docs/sso-domains.md) | Domains + SSO layout |
| [docs/backup-restore.md](docs/backup-restore.md) | Restic/Borg, USB + B2, Vaultwarden drill |
| [docs/catalog-notes.md](docs/catalog-notes.md) | Honest catalog gaps |
| [docs/what-not-to-install.md](docs/what-not-to-install.md) | Explicitly not in v1 |

## Optional install helper

[`scripts/install-v1-apps.sh`](scripts/install-v1-apps.sh) wraps `yunohost app install` for Headscale plus the v1 app set. Run only on a YunoHost host as root; read the comments before use.

## License

MIT — Copyright (c) 2026 Nate Long / nalong21. See [LICENSE](LICENSE).
