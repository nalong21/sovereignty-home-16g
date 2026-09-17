# Onboarding card — sovereignty-home-16g

One page for household members. Keep a printed or shared copy.

## What this box is

A **private home server** running stock YunoHost. Password vault, ad/tracker DNS blocking, photos, shared pads, uptime checks, and a simple dashboard.

It is **not** a public website host and **not** your email server.

## How you reach it

| Where you are | How |
|---------------|-----|
| At home (LAN) | Use the URLs your operator shared (HTTPS). |
| Away | **Headscale mesh** only — install the official **Tailscale** client and ask the operator for an invite / auth to the household Headscale server. |

There are **no** intentional open ports from the internet to this box.

## Apps (v1)

| App | What it’s for |
|-----|----------------|
| Vaultwarden | Passwords / secrets (Bitwarden-compatible) |
| AdGuard Home | Blocks ads/trackers at DNS |
| Immich | Family photos/videos |
| CryptPad | Collaborative docs |
| Uptime Kuma | “Is the thing up?” |
| Homarr | Links / dashboard |

## What lives somewhere else

| Need | Where |
|------|--------|
| Email aliases | SimpleLogin **or** addy.io (operator’s choice) |
| Virtual cards | Privacy.com (or equivalent) |

Do not ask to “just host email on the box” — residential SMTP is out of scope on purpose.

## Ground rules

1. Do not port-forward the home router to this machine.
2. Do not create public signups on Vaultwarden.
3. Treat mesh (Tailscale client → Headscale) access like house keys — revoke when someone leaves the household.
4. Photo ML features may run only off-peak; don’t expect 24/7 recognition jobs.
5. Backups are the operator’s job; if something feels wrong, tell them — don’t “fix it” by exposing the box.

## Who to ping

**Operator:** _______________________  
**Emergency / lockout:** _______________________ (offline recovery path)

## Portal URL

**Main SSO portal:** _______________________
