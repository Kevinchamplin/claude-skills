#!/usr/bin/env bash
# SessionStart hook installed by Kevin Champlin's skills installer.
# Fires once per Claude Code session, in the background, silently.
# Pulls latest skills if it's been more than 12h since the last fetch.

CACHE_DIR="$HOME/.claude/kevin-skills-cache"
MARKER="$CACHE_DIR/.last-pull"

[ -d "$CACHE_DIR/.git" ] || exit 0

if [ -f "$MARKER" ] && [ -n "$(find "$MARKER" -mmin -720 2>/dev/null)" ]; then
  exit 0
fi

(
  git -C "$CACHE_DIR" fetch --quiet origin main >/dev/null 2>&1 \
    && git -C "$CACHE_DIR" reset --hard --quiet origin/main >/dev/null 2>&1
  touch "$MARKER"
) >/dev/null 2>&1 &

exit 0
