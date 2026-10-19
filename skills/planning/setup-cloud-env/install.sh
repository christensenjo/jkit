#!/usr/bin/env bash
# Cloud machine install. Idempotent and non-interactive.
# /setup-cloud-env refreshes the marked block from ~/.agents/JKIT.md
# ($HOME/.agents/JKIT.md, this machine's home directory).
# Checkout paths are discovered at runtime.
# Shape of the file this writes: setup-jkit personal-docs.md.
set -euo pipefail

find_repo() { # $1 = directory name, $2 = marker file
  local roots=("$PWD" "$(dirname "$PWD")" "$HOME")
  local root d
  if [ -n "${REPO_ROOTS:-}" ]; then
    # shellcheck disable=SC2206
    roots+=($REPO_ROOTS)
  fi
  for root in "${roots[@]}"; do
    for d in "$root/$1" "$root"/*/"$1"; do
      if [ -e "$d/$2" ]; then
        (cd "$d" && pwd)
        return 0
      fi
    done
  done
  return 1
}

echo "==> Toolchain"
# Install this workspace's languages and package managers.
# Skip a tool already on PATH. Example:
#   command -v git >/dev/null || echo "install git"

echo "==> Services"
# Start databases and queues on this machine.
# Before migrating or seeding, confirm the host is local and stop when it is not.

echo "==> Tracker link"
# When the tracker checkout is separate, link it at the workspace tracker path.
# WORK_DIR="$(find_repo <repo-dir> <marker>)"
# TRACKER_DIR="$(find_repo <tracker-dir> <marker> || true)"
# if [ -n "${TRACKER_DIR:-}" ] && [ -n "${WORK_DIR:-}" ]; then
#   ln -sfn "$TRACKER_DIR" "$WORK_DIR/.scratch"
# fi

echo "==> Skills"
JKIT_DIR="$(find_repo jkit README.md || true)"
if [ -n "${JKIT_DIR:-}" ] && [ -d "$JKIT_DIR/skills" ]; then
  mkdir -p "$HOME/.agents/skills"
  find "$JKIT_DIR/skills" -name SKILL.md -printf '%h\n' | while read -r d; do
    ln -sfn "$d" "$HOME/.agents/skills/$(basename "$d")"
  done
fi

# --- jkit config: start ---
# Shared values inlined by /setup-cloud-env. Local paths are not stored here.
PLANNER_GIT=""
CLOUD_USE=""
STACK_ASSISTANT=""
STACK_HARNESS=""
STACK_IDE=""
STACK_COMMS=""
WORKSPACE_NAME="app"
WORKSPACE_REPO_GIT=""
WORKSPACE_TRACKER_GIT=""

norm_url() {
  local u="$1" rest
  u="${u%/}"
  u="${u%.git}"
  case "$u" in
    git@*:*)
      rest="${u#git@}"
      u="https://${rest%%:*}/${rest#*:}"
      ;;
    https://*@*)
      u="https://${u#*@}"
      ;;
  esac
  printf '%s\n' "$u"
}

find_checkout() { # $1 = git url
  local url="${1%/}"
  url="${url%.git}"
  local name want root d remote
  name="$(basename "$url")"
  want="$(norm_url "$1")"
  local roots=("$PWD" "$(dirname "$PWD")" "$HOME")
  if [ -n "${REPO_ROOTS:-}" ]; then
    # shellcheck disable=SC2206
    roots+=($REPO_ROOTS)
  fi
  for root in "${roots[@]}"; do
    for d in "$root/$name" "$root"/*/"$name"; do
      [ -e "$d/.git" ] || continue
      remote="$(git -C "$d" remote get-url origin 2>/dev/null || true)"
      if [ "$(norm_url "$remote")" = "$want" ]; then
        (cd "$d" && pwd)
        return 0
      fi
    done
  done
  return 1
}

if [ -z "$PLANNER_GIT" ]; then
  echo "jkit config block has no planner URL" >&2
  exit 1
fi

PLANNER_LOCAL="$(find_checkout "$PLANNER_GIT" || true)"
WORKSPACE_LOCAL=""
TRACKER_LOCAL=""
if [ -n "$WORKSPACE_REPO_GIT" ]; then
  WORKSPACE_LOCAL="$(find_checkout "$WORKSPACE_REPO_GIT" || true)"
fi
if [ -n "$WORKSPACE_TRACKER_GIT" ]; then
  TRACKER_LOCAL="$(find_checkout "$WORKSPACE_TRACKER_GIT" || true)"
fi
mkdir -p "$HOME/.agents"
# Repeat the workspace heading for each workspace in ~/.agents/JKIT.md.
# $HOME/.agents/JKIT.md is that home path, not a file in the workspace repo.
cat > "$HOME/.agents/JKIT.md" <<EOF
# JKIT

## Planner

- **Git:** ${PLANNER_GIT}
- **Local:** ${PLANNER_LOCAL}

## Stack

- **Personal assistant:** ${STACK_ASSISTANT}
- **1:1 harness:** ${STACK_HARNESS}
- **IDE:** ${STACK_IDE}
- **Comms sources:** ${STACK_COMMS}

## Workspaces

### ${WORKSPACE_NAME}

- **Repo:** ${WORKSPACE_REPO_GIT}
- **Tracker:** ${WORKSPACE_TRACKER_GIT}
- **Local repo:** ${WORKSPACE_LOCAL}
- **Local tracker:** ${TRACKER_LOCAL}

## Cloud

- **Use:** ${CLOUD_USE}
EOF
# --- jkit config: end ---

echo "==> Verify"
test -f "$HOME/.agents/JKIT.md"
grep -F -q "$PLANNER_GIT" "$HOME/.agents/JKIT.md"
# Confirm the toolchain and the local service answer, then exit non-zero on failure.

echo "==> Install complete"
