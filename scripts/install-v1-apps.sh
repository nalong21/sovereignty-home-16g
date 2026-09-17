#!/usr/bin/env bash
# install-v1-apps.sh — optional wrapper for sovereignty-home-16g v1 apps
#
# Wraps `yunohost app install` for the pinned catalog IDs, in order.
# Safe defaults: checks root + YunoHost; does not force-reinstall; leaves
# domain/path prompts to yunohost unless you set env overrides carefully.
#
# Usage (on the YunoHost host):
#   sudo ./scripts/install-v1-apps.sh           # interactive confirm
#   sudo ./scripts/install-v1-apps.sh --yes     # skip confirm (still per-app yunohost prompts)
#   sudo ./scripts/install-v1-apps.sh --dry-run # print actions only
#
# Environment (optional):
#   SKIP_APPS="immich,homarr"   # comma-separated catalog IDs to skip
#
# After Vaultwarden: disable public signups in the app admin UI / config.
# Homarr may need ~7G free RAM to install; Immich ~2G.
# Headscale is installed first (catalog ID `headscale`). Point official
# Tailscale clients at that Headscale control server — do not expect a
# different client app. Tailscale SaaS is not the v1 requirement.
# borgmatic is NOT a YunoHost app — not installed here.

set -euo pipefail

DRY_RUN=0
ASSUME_YES=0

for arg in "${@:-}"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --yes|-y) ASSUME_YES=1 ;;
    -h|--help)
      sed -n '2,22p' "$0"
      exit 0
      ;;
    "")
      ;;
    *)
      echo "Unknown option: $arg" >&2
      exit 2
      ;;
  esac
done

# --- safety: root ---
if [[ "${EUID}" -ne 0 ]]; then
  echo "error: run as root on the YunoHost host (e.g. sudo $0)" >&2
  exit 1
fi

# --- safety: YunoHost present ---
if ! command -v yunohost >/dev/null 2>&1; then
  echo "error: yunohost not found in PATH — this script is for stock YunoHost hosts only" >&2
  exit 1
fi

if [[ ! -d /etc/yunohost ]]; then
  echo "error: /etc/yunohost missing — refusing to continue" >&2
  exit 1
fi

# Exact catalog IDs — do not invent
# headscale first: mesh control plane before relying on remote app access
APPS=(
  headscale
  vaultwarden
  adguardhome
  immich
  cryptpad
  uptime-kuma
  homarr
  restic
  # borg is optional alternate/additional backup; uncomment to include:
  # borg
)

should_skip() {
  local id="$1"
  local skip_csv="${SKIP_APPS:-}"
  [[ -z "$skip_csv" ]] && return 1
  IFS=',' read -ra _skips <<< "$skip_csv"
  for s in "${_skips[@]}"; do
    [[ "$s" == "$id" ]] && return 0
  done
  return 1
}

app_installed() {
  local id="$1"
  yunohost app list --output-as json 2>/dev/null | grep -q "\"id\": \"$id\"" \
    || yunohost app list 2>/dev/null | grep -qw "$id"
}

echo "sovereignty-home-16g — v1 app install helper"
echo "Host checks: root=ok, yunohost=ok"
echo "Order: ${APPS[*]}"
echo "Notes:"
echo "  - headscale first: then enroll official Tailscale clients against it"
echo "  - SSO / users before treating apps as remotely reachable"
echo "  - Disable Vaultwarden public signups after it installs"
echo "  - Schedule Immich ML/recognition off-peak (not 24/7)"
echo "  - Homarr ~7G RAM to install; Immich ~2G — check free memory"
echo "  - Remote access: Headscale mesh only (Tailscale SaaS is not the v1 pin)"
echo

if [[ "$ASSUME_YES" -ne 1 && "$DRY_RUN" -ne 1 ]]; then
  read -r -p "Proceed with installs? [y/N] " ans
  case "$ans" in
    y|Y|yes|YES) ;;
    *) echo "aborted"; exit 0 ;;
  esac
fi

for id in "${APPS[@]}"; do
  if should_skip "$id"; then
    echo "==> skip $id (SKIP_APPS)"
    continue
  fi
  if app_installed "$id"; then
    echo "==> skip $id (already installed)"
    continue
  fi
  echo "==> install $id"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "    dry-run: yunohost app install \"$id\""
    continue
  fi
  # Let YunoHost ask for domain/path/args interactively — safer than guessing.
  yunohost app install "$id"
  if [[ "$id" == "headscale" ]]; then
    echo "    ACTION REQUIRED: document Headscale URL; enroll Tailscale clients (login-server = Headscale)"
  fi
  if [[ "$id" == "vaultwarden" ]]; then
    echo "    ACTION REQUIRED: disable public signups in Vaultwarden now"
  fi
  if [[ "$id" == "immich" ]]; then
    echo "    ACTION REQUIRED: set ML/recognition to scheduled/off-peak (not 24/7)"
  fi
done

echo
echo "Done. Next: configure AdGuard DNS clients, Homarr links, restic/borg to USB + B2,"
echo "and run the Vaultwarden restore drill (docs/backup-restore.md)."
