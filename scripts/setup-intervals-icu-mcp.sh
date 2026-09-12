#!/usr/bin/env bash
# Clones and prepares the eddmann/intervals-icu-mcp server as a sibling
# directory of this repo, so the project-level .mcp.json can find it.
set -euo pipefail

REPO_URL="https://github.com/eddmann/intervals-icu-mcp.git"
TARGET_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/intervals-icu-mcp"

if ! command -v uv >/dev/null 2>&1; then
  echo "error: 'uv' is not installed. Install it first: https://docs.astral.sh/uv/getting-started/installation/" >&2
  exit 1
fi

if [ -d "$TARGET_DIR/.git" ]; then
  echo "Repo already present at $TARGET_DIR, pulling latest..."
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "Cloning $REPO_URL into $TARGET_DIR..."
  git clone "$REPO_URL" "$TARGET_DIR"
fi

echo "Installing dependencies with uv sync..."
uv --directory "$TARGET_DIR" sync

cat <<'EOF'

Setup done. Next steps:

1. Get your Intervals.icu API key: https://intervals.icu -> Settings -> Developer Settings.
   Your athlete ID is the "iNNNNNN" part of your profile URL.

2. Export both as environment variables in your shell profile (~/.zshrc, ~/.bashrc, ...)
   so Claude Code can pick them up via .mcp.json — never commit them to any repo:

     export INTERVALS_ICU_API_KEY="your_api_key_here"
     export INTERVALS_ICU_ATHLETE_ID="i123456"

3. Restart your shell (or `source` the profile file), then reopen Claude Code
   in this repo. The "intervals-icu" MCP server defined in .mcp.json will start
   automatically and expose ~48 read/write tools for Intervals.icu.

4. Make sure Garmin Connect is already linked to your Intervals.icu account
   (Intervals.icu -> Settings -> Connections). This MCP server talks to the
   Intervals.icu API only — it does not talk to Garmin directly.
EOF
