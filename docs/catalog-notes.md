# Catalog notes (honest gaps)

Verified against the YunoHost application catalog for this profile’s pins. **Do not invent IDs.**

## V1 apps present in catalog

`headscale`, `vaultwarden`, `adguardhome`, `immich`, `cryptpad`, `uptime-kuma`, `homarr`, `restic`, `borg`.

Immich: packaging notes include ~**2G** to install; architectures **amd64** and **arm64** (this profile targets amd64 N100/N150).

Homarr: catalog notes ~**7G RAM** to install — material on a **16GB** box. **Day-0 guidance:** install Homarr only with Immich ML/recognition **off** (or heavy Immich jobs stopped), **or defer Homarr** until Immich is stable — avoid first-boot OOM.

## Gaps and substitutions

| Wanted | Catalog reality | What we do |
|--------|-----------------|------------|
| Homepage-style dashboard | **`homepage` not in catalog** | Use **`homarr`** |
| Borgmatic-style Borg wrapper | **`borgmatic` not in catalog** | Use **`restic` and/or `borg`**; borgmatic only as optional **host-level** tooling |
| Self-hosted mesh control plane | **`headscale` is in catalog** | **Required for v1** remote access — `yunohost app install headscale` |
| Mesh client on phones/laptops | **`tailscale` not in catalog** (and not needed as a YunoHost app) | Install official **Tailscale clients** on devices; point them at the Headscale control server (standard Headscale setup) |

## Install-order reminder

See the profile README / `profiles/sovereignty-home-16g.md`. **Headscale + SSO first**, then Vaultwarden (lock signups), AdGuard, Immich with off-peak ML, CryptPad, Uptime Kuma, Homarr, then backup apps. Remote access only via the mesh.

## If the catalog changes

If `homepage` or `borgmatic` appear later, revisit this file and the profile before switching IDs. Until then, the substitutions above remain authoritative for this repo. `headscale` remains the pinned control plane for v1.
