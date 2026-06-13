#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
installer="$repo_root/scripts/install-skill.sh"

if [[ -d "$repo_root/.git" ]]; then
  git -C "$repo_root" pull --ff-only
fi

skills=()
if [[ "$#" -eq 0 ]]; then
  while IFS= read -r skill; do
    skills+=("$skill")
  done < <(find "$repo_root/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
else
  skills=("$@")
fi

if [[ "${#skills[@]}" -eq 0 ]]; then
  echo "No skills found under $repo_root/skills" >&2
  exit 1
fi

for skill in "${skills[@]}"; do
  "$installer" "$skill"
done
