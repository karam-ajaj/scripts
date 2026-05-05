#!/bin/bash
set -euo pipefail

SRC_CONFIG="/swarm/config/atlas"
SRC_DATA="/swarm/data/atlas"
DEST_BASE="/swarm/backups/atlas"
TS="$(date +'%Y%m%d-%H%M%S')"
DEST="$DEST_BASE/$TS"

echo "📦 Snapshotting atlas volumes to: $DEST"
mkdir -p "$DEST/config" "$DEST/data"

# Snapshot copies (no writes into the Git repo)
rsync -aH "$SRC_CONFIG/" "$DEST/config/"
rsync -aH "$SRC_DATA/" "$DEST/data/"

# Optional: keep only the last 10 snapshots
if command -v ls >/dev/null 2>&1; then
  TOTAL=$(ls -1 "$DEST_BASE" | wc -o 2>/dev/null || ls -1 "$DEST_BASE" | wc -l)
  # shellcheck disable=SC2012
  while [ "$(ls -1 "$DEST_BASE" | wc -l)" -gt 10 ]; do
    # shellcheck disable=SC2012
    OLDEST="$(ls -1 "$DEST_BASE" | head -n 1)"
    rm -rf "$DEST_BASE/$OLDEST" || true
  done
fi

# Discord webhook (optional, via env var)
if [[ -n "${DISCORD_WEBHOOK_URL:-}" ]]; then
  payload=$(printf '{"content":"Atlas backup complete: %s"}' "$DEST")
  curl -sS -H "Content-Type: application/json" -X POST -d "$payload" "$DISCORD_WEBHOOK_URL" >/dev/null || true
fi

echo "✅ Backup complete"
