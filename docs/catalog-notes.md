# Catalog notes (honest gaps)

Verified against the YunoHost application catalog for this profile’s pins. **Do not invent IDs.**

## V1 apps present in catalog

`vaultwarden`, `adguardhome`, `immich`, `cryptpad`, `uptime-kuma`, `homarr`, `restic`, `borg`.

Immich: packaging notes include ~**2G** to install; architectures **amd64** and **arm64** (this profile targets amd64 N100/N150).

Homarr: catalog notes ~**7G RAM** to install — material on a **16GB** box; free memory before installing.

## Gaps and substitutions

| Wanted | Catalog reality | What we do |
|--------|-----------------|------------|
| Homepage-style dashboard | **`homepage` not in catalog** | Use **`homarr`** |
| Borgmatic-style Borg wrapper | **`borgmatic` not in catalog** | Use **`restic` and/or `borg`**; borgmatic only as optional **host-level** tooling |
| Tailscale VPN client / mesh | **`tailscale` not in catalog** | Install Tailscale at **host/OS** level; required for remote access in this profile |
| Self-hosted Tailscale control plane | **`headscale` is in catalog** | Optional **later**; not required for day 0 |

## Install-order reminder

See the profile README / `profiles/sovereignty-home-16g.md`. Vaultwarden first (then lock signups), AdGuard next, Immich with off-peak ML, then CryptPad, Uptime Kuma, Homarr, then backup apps.

## If the catalog changes

If `homepage`, `tailscale`, or `borgmatic` appear later, revisit this file and the profile before switching IDs. Until then, the substitutions above remain authoritative for this repo.
