#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_name="${1:-}"

if [[ -z "$skill_name" ]]; then
  echo "Usage: $0 <skill-name>" >&2
  echo "Available skills:" >&2
  find "$repo_root/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort >&2
  exit 2
fi

src="$repo_root/skills/$skill_name"
dest_root="${CODEX_HOME:-$HOME/.codex}/skills"
dest="$dest_root/$skill_name"

if [[ ! -f "$src/SKILL.md" ]]; then
  echo "Skill not found or missing SKILL.md: $src" >&2
  exit 1
fi

mkdir -p "$dest_root" "$dest"
rsync -a --delete "$src/" "$dest/"

echo "Installed $skill_name to $dest"
echo "Restart Codex to pick up new or changed skills."
