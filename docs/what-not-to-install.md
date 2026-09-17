# What not to install (v1)

These are **explicitly out of v1** for `sovereignty-home-16g`. Revisit in **v2** with sizing and posture review.

| App / stack | Why not in v1 |
|-------------|----------------|
| **Nextcloud** | Heavy (disk, RAM, maintenance). Duplicates pieces of CryptPad + Immich for many households; easy to sprawl into “everything server.” Defer until backup/restore and Immich are proven. |
| **Jitsi** | Real-time A/V wants sustained CPU/RAM and often tempts public exposure. Conflicts with “no public exposure by default” unless carefully Tailscale-only — still a support burden on 16GB next to Immich. |
| **Matrix / Synapse** | Synapse is RAM- and ops-hungry; federation increases abuse and exposure surface. Better as a deliberate v2 project, not day-0. |
| **Ollama** (local LLMs) | Contends for the same 16GB as Immich ML and Homarr’s large install footprint. Keep ML budget for Immich off-peak jobs first. |

## Also refuse on posture grounds (any version unless redesign)

- Residential **SMTP / full mail stack** on this box — reputation, ISP ToS, blocklists; use hosted mail + SimpleLogin/addy.io aliases instead.
- **WAN port-forwards** to the home box — breaks default private posture; use Tailscale (Headscale optional later).
- Catalog lookalikes that are **not** in the YunoHost catalog for this profile’s pins: e.g. do not substitute `homepage` for `homarr`; do not assume `borgmatic` is a YunoHost app.

## When promoting something to v2

Document: expected RAM/CPU, whether it stays Tailscale-only, backup impact, and what you will remove or resize (e.g. Immich ML schedule) to make room.
