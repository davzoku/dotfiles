#!/usr/bin/env bash

set -euo pipefail

# Usage:
#   ./replace_local_claude_settings.sh [branch]
# Example:
#   ./replace_local_claude_settings.sh main

REMOTE_REPO="https://github.com/davzoku/dotfiles"
BRANCH="${1:-main}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR"

SETTINGS_FILE="$TARGET_DIR/settings.json"
STATUSLINE_FILE="$TARGET_DIR/statusline-command.sh"

if ! command -v curl >/dev/null 2>&1; then
	echo "Error: curl is required but not installed."
	exit 1
fi

if ! command -v mktemp >/dev/null 2>&1; then
	echo "Error: mktemp is required but not installed."
	exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

RAW_BASE="https://raw.githubusercontent.com/davzoku/dotfiles/${BRANCH}/.claude"

download_file() {
	local remote_path="$1"
	local output_path="$2"

	curl -fsSL "$RAW_BASE/$remote_path" -o "$output_path"
}

echo "Downloading files from ${REMOTE_REPO} (branch: ${BRANCH})..."
download_file "settings.json" "$TMP_DIR/settings.json"
download_file "statusline-command.sh" "$TMP_DIR/statusline-command.sh"

backup_suffix=".bak.$(date +%Y%m%d%H%M%S)"

if [[ -f "$SETTINGS_FILE" ]]; then
	cp "$SETTINGS_FILE" "$SETTINGS_FILE$backup_suffix"
	echo "Backup created: $SETTINGS_FILE$backup_suffix"
fi

if [[ -f "$STATUSLINE_FILE" ]]; then
	cp "$STATUSLINE_FILE" "$STATUSLINE_FILE$backup_suffix"
	echo "Backup created: $STATUSLINE_FILE$backup_suffix"
fi

mv "$TMP_DIR/settings.json" "$SETTINGS_FILE"
mv "$TMP_DIR/statusline-command.sh" "$STATUSLINE_FILE"
chmod +x "$STATUSLINE_FILE"

echo "Updated: $SETTINGS_FILE"
echo "Updated: $STATUSLINE_FILE"
echo "Done."
