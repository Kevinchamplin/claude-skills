# Claude Skills

A growing, community-curated collection of Claude Code skills you can drop into your local Claude install.

Skills are markdown-based capabilities that load on demand when Claude Code detects a matching task. Each folder in this repo is one self-contained skill — copy the folder into `~/.claude/skills/` and restart your session.

Maintained by [Kevin Champlin](https://github.com/kevinchamplin) — contributions welcome (see [CONTRIBUTING.md](CONTRIBUTING.md)).

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

### Option 1 — install everything

```bash
git clone https://github.com/kevinchamplin/claude-skills.git ~/claude-skills && mkdir -p ~/.claude/skills && find ~/claude-skills -mindepth 1 -maxdepth 1 -type d -not -name '.git' -exec cp -r {} ~/.claude/skills/ \;
```

Restart your Claude Code session. The new skills will appear in the available-skills list.

### Option 2 — install one skill

```bash
mkdir -p ~/.claude/skills
curl -L https://github.com/kevinchamplin/claude-skills/archive/refs/heads/main.tar.gz \
  | tar -xz --strip-components=1 -C ~/.claude/skills claude-skills-main/frontend-design
```

(Swap `frontend-design` for any skill name in this repo.)

### Option 3 — symlink (stay in sync with `git pull`)

```bash
git clone https://github.com/kevinchamplin/claude-skills.git ~/claude-skills && mkdir -p ~/.claude/skills
for dir in ~/claude-skills/*/; do ln -sfn "$dir" ~/.claude/skills/$(basename "$dir"); done
```

`cd ~/claude-skills && git pull` to update.

### Option 4 — project-scoped (per-repo, team-shared)

Drop the folders into `<your-project>/.claude/skills/` and commit them. Anyone who clones the repo gets the same skills automatically — useful for team standards.

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
