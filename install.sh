#!/usr/bin/env bash
# Kevin Champlin's Claude Skills — installer
# https://kevinchamplin.com/skills
#
# Installs every skill in this repo into your local Claude install
# (Claude Code and, on macOS, Claude Desktop) and registers a SessionStart
# hook so the skills self-update once every 12h while you work.
#
# Re-run any time: it's idempotent. Uninstall with the snippet in the README.

set -euo pipefail

REPO_URL="${KCS_REPO_URL:-https://github.com/Kevinchamplin/claude-skills.git}"
REPO_BRANCH="${KCS_BRANCH:-main}"
CACHE_DIR="$HOME/.claude/kevin-skills-cache"
CODE_SKILLS_DIR="$HOME/.claude/skills"
HOOK_DIR="$HOME/.claude/hooks"
HOOK_SCRIPT="$HOOK_DIR/kevin-skills-update.sh"
SETTINGS_FILE="$HOME/.claude/settings.json"

DESKTOP_SKILLS_DIR=""
case "$(uname -s)" in
  Darwin)
    if [ -d "$HOME/Library/Application Support/Claude" ]; then
      DESKTOP_SKILLS_DIR="$HOME/Library/Application Support/Claude/skills"
    fi
    ;;
  Linux) : ;;
  *)
    echo "Unsupported platform: $(uname -s). macOS or Linux required." >&2
    exit 1
    ;;
esac

bold()   { printf '\033[1m%s\033[0m\n' "$*"; }
green()  { printf '\033[32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[33m%s\033[0m\n' "$*"; }
red()    { printf '\033[31m%s\033[0m\n' "$*" >&2; }

command -v git >/dev/null 2>&1 || { red "git is required but not installed."; exit 1; }

bold "Installing Kevin Champlin's Claude skills..."

mkdir -p "$HOME/.claude" "$HOOK_DIR" "$CODE_SKILLS_DIR"

if [ -d "$CACHE_DIR/.git" ]; then
  echo "Updating skill cache..."
  git -C "$CACHE_DIR" fetch --quiet origin "$REPO_BRANCH"
  git -C "$CACHE_DIR" reset --hard --quiet "origin/$REPO_BRANCH"
else
  echo "Cloning skill repo..."
  git clone --quiet --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$CACHE_DIR"
fi

touch "$CACHE_DIR/.last-pull"

link_skills_into() {
  local target="$1"
  mkdir -p "$target"
  local installed=0
  for skill_path in "$CACHE_DIR"/*/; do
    local skill_name
    skill_name="$(basename "$skill_path")"
    case "$skill_name" in
      .*|hooks|public|.github|node_modules) continue ;;
    esac
    if [ -f "$skill_path/SKILL.md" ]; then
      ln -sfn "$skill_path" "$target/$skill_name"
      installed=$((installed + 1))
    fi
  done
  green "  Linked $installed skills into $target"
}

link_skills_into "$CODE_SKILLS_DIR"
if [ -n "$DESKTOP_SKILLS_DIR" ]; then
  link_skills_into "$DESKTOP_SKILLS_DIR"
fi

cp "$CACHE_DIR/hooks/kevin-skills-update.sh" "$HOOK_SCRIPT"
chmod +x "$HOOK_SCRIPT"

register_hook_with_python() {
  python3 - "$SETTINGS_FILE" "$HOOK_SCRIPT" <<'PYEOF'
import json, os, sys
settings_path, hook_cmd = sys.argv[1], sys.argv[2]

data = {}
if os.path.exists(settings_path):
    try:
        with open(settings_path) as f:
            content = f.read().strip()
        data = json.loads(content) if content else {}
    except json.JSONDecodeError:
        print(f"  ! {settings_path} is not valid JSON — skipping hook registration.")
        sys.exit(0)

hooks_root = data.setdefault("hooks", {})
session_start = hooks_root.setdefault("SessionStart", [])

already_registered = False
for entry in session_start:
    for h in entry.get("hooks", []) or []:
        if h.get("command") == hook_cmd:
            already_registered = True
            break
    if already_registered:
        break

if already_registered:
    print("  Auto-update hook already registered.")
    sys.exit(0)

session_start.append({"hooks": [{"type": "command", "command": hook_cmd}]})

os.makedirs(os.path.dirname(settings_path) or ".", exist_ok=True)
tmp = settings_path + ".tmp"
with open(tmp, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
os.replace(tmp, settings_path)
print("  Registered auto-update hook in Claude Code settings.")
PYEOF
}

if command -v python3 >/dev/null 2>&1; then
  register_hook_with_python || yellow "  ! Hook registration failed — skills still install fine."
else
  yellow "  ! python3 not found — skipping auto-update hook registration."
  yellow "    (skills still install fine; re-run this installer any time to update)"
fi

echo
green "Done."
echo "Skills available now:"
for skill_path in "$CACHE_DIR"/*/; do
  skill_name="$(basename "$skill_path")"
  case "$skill_name" in .*|hooks|public|.github|node_modules) continue ;; esac
  if [ -f "$skill_path/SKILL.md" ]; then
    echo "  /$skill_name"
  fi
done
echo
echo "Restart your Claude Code session to load them."
echo "Skills will self-update once every 12h. Re-run this installer to force a refresh."
