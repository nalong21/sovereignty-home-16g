# SSO and domains

## Principle

**Identity before apps.** Create YunoHost users and understand SSOwat portals before installing the v1 app set. Apps should sit behind YunoHost SSO where the app packaging supports it.

**Mesh before remote apps.** Install and enroll **Headscale** (`yunohost app install headscale`) so remote access is only via the mesh — not residential WAN ports.

## Suggested layout

Pick a domain you control (or a subdomain of one). Examples only — replace with yours:

| Purpose | Example FQDN | Notes |
|---------|--------------|--------|
| Main portal / SSO | `home.example.com` | YunoHost main domain |
| Headscale | `hs.home.example.com` | Control server; clients use this as login server |
| Vaultwarden | `vault.home.example.com` | Or path-based if you prefer |
| AdGuard Home | `dns.home.example.com` | Admin UI; DNS listeners are separate |
| Immich | `photos.home.example.com` | Heavy; keep off public WAN |
| CryptPad | `pad.home.example.com` | |
| Uptime Kuma | `up.home.example.com` | |
| Homarr | `dash.home.example.com` | |

YunoHost can use the main domain plus additional domains/`yunohost domain add`. Prefer subdomains for clarity on a multi-app box.

## Access paths

1. **LAN** — HTTPS to the box on the local network (YunoHost certificates as configured).
2. **Remote** — Headscale mesh only by default (official Tailscale clients → this Headscale). Do **not** open 80/443 (or app ports) on the residential router to the internet for this profile.
3. **DNS for AdGuard** — Point household devices at AdGuard’s DNS listeners on LAN (and optionally via mesh IPs). Do not expose AdGuard’s DNS ports to the open internet.

## SSO checklist

- [ ] Admin account secured; spare recovery admin documented offline
- [ ] Household users created in YunoHost (or a clear “shared admin + personal vaults” model)
- [ ] SSOwat portal groups reviewed after each app install
- [ ] Apps that support SSO left behind the portal; document any app that must be public-path exceptions (prefer none)
- [ ] Vaultwarden: after install, **disable public signups** and restrict invitations

## Off-box identity adjacent services

These are **not** hosted on the home box:

- **Email aliases:** SimpleLogin or addy.io  
- **Card aliases:** Privacy.com (or equivalent)

Document your chosen providers in the household onboarding card so operators do not invent “just run mail here” later.

## Headscale (required for v1 remote access)

`headscale` is in the YunoHost catalog. Prefer:

```bash
yunohost app install headscale
```

Then point official **Tailscale clients** at the Headscale control-server URL (standard Headscale setup — you do **not** need a different client app). Install Headscale (and SSO) before relying on remote app access; keep remote reachability mesh-only.

> **Footnote:** Tailscale SaaS (no self-hosted Headscale) is a simpler day-0 alternative if you accept a hosted control plane — **not** the v1 requirement for this profile.
