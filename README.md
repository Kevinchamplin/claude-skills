# Claude Skills

A growing, community-curated collection of Claude Code skills you can drop into your local Claude install.

Skills are markdown-based capabilities that load on demand when Claude Code detects a matching task. Each folder in this repo is one self-contained skill — copy the folder into `~/.claude/skills/` and restart your session.

Maintained by [Kevin Champlin](https://kevinchamplin.com) — senior software engineer building production AI systems, web apps, and mobile platforms. Founder of [Champlin Enterprises](https://champlinenterprises.com). Contributions welcome (see [CONTRIBUTING.md](CONTRIBUTING.md)).

## Available Skills

| Skill | What it does |
|-------|--------------|
| [`frontend-design`](frontend-design/) | Builds distinctive, production-grade frontends. Detects stack (Next.js, Laravel/Blade, plain HTML), respects existing design tokens, avoids generic AI aesthetics. |
| [`ux-designer`](ux-designer/) | Modern UX best practices for SaaS — conversion, accessibility, interaction patterns, anti-patterns. Ships with 22 deep-reference docs covering forms, mobile, a11y, dashboards, AI UX, ethical design, and more. |
| [`token-discipline`](token-discipline/) | Stretch Claude Code context. Seven habits (offset/limit reads, subagent delegation, piped output, TodoWrite, checkpointing, no echoing, on-demand skill bodies) to stop burning tokens on noise. Use when sessions run long or you keep hitting context/usage limits. |
| [`lean-context`](lean-context/) | Activate strict context-saving mode mid-conversation. Drops a checkpoint summary, audits stale tool output, and locks down behavior for the rest of the session. Pairs with `token-discipline` — the latter is daily habits, this is emergency mode. |
| [`review`](review/) | Pre-deploy security & quality review of pending changes. Scans diffs for credential leaks, SQL/XSS/command injection, IDOR, prompt-injection, debug leftovers, and `.env` commits. Reports findings with CRITICAL/WARNING/INFO severity. |
| [`superteam`](superteam/) | Launches 7 parallel specialist agents (security, performance, UI/UX, mobile, accessibility, code quality, testing) for a full project audit. Each agent fixes what it can autonomously and reports findings. Best for "level up this project" sessions. |

More skills will be added over time. PRs welcome.

## Install

### One-line install (Claude Code + Claude Desktop on macOS)

Paste this into a Claude Code or Claude Desktop session and let Claude run it:

> **Install Kevin Champlin's Claude skills** — run `curl -fsSL https://kevinchamplin.com/skills/install.sh | bash`

Or run it directly in your terminal:

```bash
curl -fsSL https://kevinchamplin.com/skills/install.sh | bash
```

That clones the repo into `~/.claude/kevin-skills-cache/`, symlinks every skill into your Claude skills directory (Code, and Desktop on macOS), and registers a SessionStart hook so the skills self-update silently every 12 hours.

- **Self-updating.** A SessionStart hook in `~/.claude/settings.json` runs `git pull` in the background each new session (max once per 12h). Push to the repo → users get it on their next session.
- **Idempotent.** Re-run the installer any time. It re-symlinks, refreshes the hook, and pulls latest.
- **Honest about scope.** Claude Code: one-prompt, fully automatic. Claude Desktop on macOS: same one-prompt install + manual re-run for updates (no hook system). Claude.ai web: use the manual install below.

### Manual install (Claude.ai web, or if you don't want shell scripts running)

Download an individual skill folder and upload it to your Claude Project as files:

```bash
curl -L https://github.com/Kevinchamplin/claude-skills/archive/refs/heads/main.tar.gz \
  | tar -xz --strip-components=1 -C /tmp claude-skills-main/frontend-design
```

(Swap `frontend-design` for any skill name in this repo.) Then attach the folder to your Claude.ai Project.

### Project-scoped (per-repo, team-shared)

Drop the folders into `<your-project>/.claude/skills/` and commit them. Anyone who clones the repo gets the same skills automatically — useful for team standards.

### Uninstall

```bash
rm -rf ~/.claude/kevin-skills-cache ~/.claude/hooks/kevin-skills-update.sh
# Then remove the corresponding SessionStart entry from ~/.claude/settings.json,
# and delete the symlinks under ~/.claude/skills/ (and on macOS,
# ~/Library/Application Support/Claude/skills/).
```

## How skills work

Each skill is a folder under `~/.claude/skills/<skill-name>/` containing:

```
<skill-name>/
├── SKILL.md          # required — frontmatter + instructions
└── references/       # optional — on-demand deep-reference docs
    └── *.md
```

`SKILL.md` starts with YAML frontmatter:

```yaml
---
name: skill-name
description: One-line trigger description Claude reads to decide when to invoke this skill.
---
```

The `description` is the only thing Claude sees by default. The body of `SKILL.md` is loaded only when the skill is invoked. This keeps your context lean.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the skill structure, PR checklist, and style guide.

Short version: add a new top-level folder with a `SKILL.md`, keep it stack-agnostic (no personal/project names), open a PR.

## License

MIT — see [LICENSE](LICENSE). Use these freely in commercial and personal projects.

---

**About the author**

[Kevin Champlin](https://kevinchamplin.com) is a senior software engineer with 20+ years shipping production systems — Fortune 100/500 work through [Champlin Enterprises](https://champlinenterprises.com), plus local businesses and open-source tools. He runs Claude Code 8+ hours a day across dozens of projects and writes about the craft at [kevinchamplin.com/blog](https://kevinchamplin.com/blog).

Connect: [kevinchamplin.com](https://kevinchamplin.com) · [GitHub](https://github.com/Kevinchamplin) · [Books on Amazon](https://kevinchamplin.com/books.php)
