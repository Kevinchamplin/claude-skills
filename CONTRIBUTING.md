# Contributing

Thanks for wanting to contribute. This repo is a curated library of Claude Code skills — both new skills and improvements to existing ones are welcome.

## Adding a new skill

1. Fork the repo and create a branch: `feature/<skill-name>`.
2. Add a top-level folder named after the skill (lowercase, hyphenated): `your-skill-name/`.
3. Inside the folder, create `SKILL.md` with this structure:

   ```markdown
   ---
   name: your-skill-name
   description: One sentence describing when Claude should use this skill. Be specific — this is the only thing Claude reads to decide whether to invoke it.
   ---

   # Skill Title

   ## When to use this skill
   <Concrete triggers — what kind of task, what kind of file, what kind of question.>

   ## Instructions
   <The actual guidance Claude follows once invoked.>
   ```

4. (Optional) If the skill has deep reference docs, put them under `your-skill-name/references/` and link to them from `SKILL.md`. Claude loads references on demand, not by default.
5. Update the **Available Skills** table in [README.md](README.md) with a one-line description.
6. Open a PR.

## Improving an existing skill

Edit the relevant `SKILL.md` (or files under `references/`) and open a PR. Please explain in the PR description:
- What problem the change solves (a real example you hit is ideal)
- Anything that might regress for existing users

## Style guide

**Keep it stack-agnostic.** Skills get used across many projects. If a skill mentions a specific framework, it should also explain how to detect that framework so it doesn't fire incorrectly elsewhere.

**No personal names, project names, or domain-specific jargon.** "Kevin", "ACME Corp", "the auth migration we did last quarter" — none of these belong in a shared skill. Refer to "the user" or "this project."

**No secrets, API keys, internal URLs, or PII.** Skills are public.

**Descriptions are triggers, not summaries.** A skill's `description` field is what Claude scans to decide whether to use the skill. Lead with the verbs and concrete signals (file types, keywords, task shapes) that should trigger it.

   - ❌ "A skill for design work."
   - ✅ "Apply modern UX best practices when designing or reviewing interfaces. Use for accessibility audits, form design, dashboard layout, and SaaS conversion review."

**Prefer concrete over abstract.** Checklists, decision tables, and anti-pattern lists outperform paragraphs of theory. Claude is good at applying explicit rules; vague vibes get diluted.

**Test it.** Before opening a PR, install the skill locally (`cp -r your-skill ~/.claude/skills/`) and try it on a real task. If Claude doesn't invoke it when expected, the description is probably the problem.

## PR checklist

- [ ] Folder name matches `name:` in frontmatter
- [ ] `description:` is specific enough that Claude will trigger on the right tasks (and only those)
- [ ] No personal names, project names, secrets, or internal URLs
- [ ] References (if any) are linked from `SKILL.md`
- [ ] README.md table updated for new skills
- [ ] Skill tested locally on at least one real task

## Code of conduct

Be kind. Assume good intent. If you disagree with feedback in a PR, explain your reasoning — most disagreements are resolvable with context.

## License

By submitting a contribution you agree to license it under the same MIT license as the rest of the repo.
