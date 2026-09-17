# Day-0 operator checklist

Target: stock YunoHost on an N100/N150 **16GB** box. Profile: `sovereignty-home-16g`.

## Before apps

- [ ] YunoHost installed and updated; admin credentials stored in an offline backup
- [ ] Hostname / main domain decided ([sso-domains.md](sso-domains.md))
- [ ] TLS working for the main domain (YunoHost Let’s Encrypt or your chosen path)
- [ ] **Tailscale installed at host/OS level** and device authorized; confirm you can reach the box over Tailscale with LAN Wi‑Fi off (remote test)
- [ ] Confirm **no** residential WAN port-forwards to this host (router check)
- [ ] Document SimpleLogin **or** addy.io + Privacy.com (or equivalent) as off-box alias providers
- [ ] Create household YunoHost users / groups as needed
- [ ] Note free RAM: Homarr catalog notes ~**7G** to install; Immich ~**2G**. Free memory before those steps

## Install order (exact catalog IDs)

Prefer the portal or `yunohost app install <id>`. Optional wrapper: [`scripts/install-v1-apps.sh`](../scripts/install-v1-apps.sh).

1. [ ] `vaultwarden` → **disable public signups**; invite-only / admin-provisioned users  
2. [ ] `adguardhome` → point a test client at it; confirm blocking works on LAN  
3. [ ] `immich` → configure ML/recognition for **scheduled / off-peak**, not always-on  
4. [ ] `cryptpad`  
5. [ ] `uptime-kuma` → monitor the box itself + critical URLs over Tailscale/LAN  
6. [ ] `homarr` → wire links to the apps above (not `homepage`)  
7. [ ] `restic` and/or `borg` → configure USB local + offsite B2 per [backup-restore.md](backup-restore.md)

## Immediately after Vaultwarden

- [ ] Admin account created
- [ ] Public registration **off**
- [ ] At least one emergency recovery path documented offline (not only in the vault)

## Network posture verification

- [ ] From outside the house: only Tailscale reaches admin UIs
- [ ] AdGuard DNS ports not exposed to WAN
- [ ] No SMTP listener intended for internet delivery on this host
- [ ] SSOwat / permissions reviewed for each app

## First backup

- [ ] Successful backup job to **USB**
- [ ] Successful backup job to **offsite B2** (or equivalent S3-compatible)
- [ ] Vaultwarden **restore drill** completed once (see backup-restore doc)

## Hand-off

- [ ] Fill [onboarding-card.md](onboarding-card.md) and share with household
- [ ] Point operators at [what-not-to-install.md](what-not-to-install.md) so v2 apps don’t sneak in early
