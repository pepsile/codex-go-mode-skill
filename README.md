# skill-vault

`skill-vault` is a personal AI-agent skill repository for keeping reusable Codex skills, workflows, templates, and references in sync across machines.

The repository is organized as a vault of individual skills. Each skill lives under `skills/<skill-name>/` and keeps the normal Codex skill shape:

```text
skills/<skill-name>/
  SKILL.md
  agents/
    openai.yaml
  scripts/
  references/
  assets/
```

## Skills

| Skill | Path | Purpose |
| --- | --- | --- |
| `go-mode` | `skills/go-mode` | Goal locking, phased execution, phase documentation, worktree checks, and Superpowers routing. |

## Install A Skill

Use the Codex skill installer for a one-time install from GitHub:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo pepsile/skill-vault \
  --path skills/go-mode
```

Restart Codex after installing a new skill so the skill metadata is loaded.

## Keep Skills Synced

For repeatable updates on each computer, keep a local clone of this vault and copy skills into Codex from there:

```bash
git clone https://github.com/pepsile/skill-vault.git ~/Developer/skill-vault
cd ~/Developer/skill-vault
./scripts/install-skill.sh go-mode
```

Later, update the local clone and reinstall the skill in one step:

```bash
cd ~/Developer/skill-vault
./scripts/update-skill.sh go-mode
```

To update every skill in the vault:

```bash
./scripts/update-skill.sh
```

## Add A New Skill

Create a new directory under `skills/`:

```text
skills/new-skill-name/
  SKILL.md
  agents/openai.yaml
```

Keep skill folders lean. Put runtime instructions in `SKILL.md`; put optional helper scripts in `scripts/`, load-on-demand references in `references/`, and reusable output assets in `assets/`.

## Notes

- Keep secrets, tokens, private credentials, and sensitive customer data out of this repository.
- Prefer private visibility if skills start to include company-specific procedures or project details.
- Existing installs that cloned the old single-skill repository directly should be replaced with the `skills/go-mode` install path.
