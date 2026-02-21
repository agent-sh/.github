#!/bin/sh
# Rollout CI workflows, Claude Code integrations, and hooks to all agent-sh repos
#
# Usage:
#   sh scripts/rollout.sh            # Create PRs in all repos
#   sh scripts/rollout.sh --dry-run  # Show what would happen without making changes

set -e

DRY_RUN=false
if [ "$1" = "--dry-run" ]; then
  DRY_RUN=true
  echo "[INFO] Dry run mode - no changes will be made"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ORG_GITHUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BRANCH="add-ci-workflows"

# All org repos to roll out to
NODE_REPOS="web-ctl next-task deslop ship perf audit-project sync-docs repo-map drift-detect debate consult learn enhance agent-core agent-knowledge agent-sh.dev"
RUST_REPOS="agnix"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

rollout_repo() {
  REPO="$1"
  REPO_TYPE="$2"

  echo ""
  echo "--- $REPO ($REPO_TYPE) ---"

  if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY-RUN] Would clone agent-sh/$REPO"
    echo "[DRY-RUN] Would add ci-${REPO_TYPE}.yml as .github/workflows/ci.yml"
    echo "[DRY-RUN] Would add claude-code-review.yml"
    echo "[DRY-RUN] Would add claude-mentions.yml (as claude.yml)"
    echo "[DRY-RUN] Would add scripts/setup-hooks.sh and pre-push hook"
    echo "[DRY-RUN] Would create PR"
    return
  fi

  CLONE_DIR="$TMPDIR/$REPO"

  # Clone
  if ! gh repo clone "agent-sh/$REPO" "$CLONE_DIR" -- --depth 1 2>/dev/null; then
    echo "[ERROR] Failed to clone agent-sh/$REPO - skipping"
    return
  fi

  cd "$CLONE_DIR"

  # Check if branch already exists on remote
  if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
    echo "[WARN] Branch $BRANCH already exists on agent-sh/$REPO - skipping"
    return
  fi

  git checkout -b "$BRANCH"

  # CI workflow
  mkdir -p .github/workflows
  if [ "$REPO_TYPE" = "rust" ]; then
    cp "$ORG_GITHUB_DIR/workflow-templates/ci-rust.yml" .github/workflows/ci.yml
  else
    cp "$ORG_GITHUB_DIR/workflow-templates/ci-node.yml" .github/workflows/ci.yml
  fi

  # Claude Code workflows
  cp "$ORG_GITHUB_DIR/workflow-templates/claude-code-review.yml" .github/workflows/claude-code-review.yml
  cp "$ORG_GITHUB_DIR/workflow-templates/claude-mentions.yml" .github/workflows/claude.yml

  # Hook scripts
  mkdir -p scripts
  cp "$ORG_GITHUB_DIR/scripts/setup-hooks.sh" scripts/setup-hooks.sh
  if [ "$REPO_TYPE" = "rust" ]; then
    cp "$ORG_GITHUB_DIR/scripts/pre-push-rust" scripts/pre-push-rust
  else
    cp "$ORG_GITHUB_DIR/scripts/pre-push-node" scripts/pre-push-node
  fi
  chmod +x scripts/*.sh scripts/pre-push-* 2>/dev/null || true

  # Commit and push
  git add -A
  git commit -m "$(cat <<'EOF'
ci: add shared CI workflows, Claude Code review, and git hooks

- CI workflow calling reusable workflow from agent-sh/.github
- Claude Code automated PR review (owner-only, max 3 runs)
- Claude Code @mentions support
- Pre-push hook running tests before push
EOF
)"

  git push -u origin "$BRANCH"

  # Create PR
  gh pr create \
    --title "ci: add shared CI workflows and hooks" \
    --body "$(cat <<'EOF'
## Summary

- Adds CI workflow (reusable from agent-sh/.github)
- Adds Claude Code automated PR review
- Adds Claude Code @mentions workflow
- Adds pre-push git hook (run `sh scripts/setup-hooks.sh` to install)

## Required Org Secrets

- `CLAUDE_CODE_OAUTH_TOKEN` - for Claude Code Action

## Test Plan

- [ ] CI workflow runs on PR
- [ ] Claude Code review triggers on PR open
- [ ] @claude mentions work in issues/PRs
- [ ] `sh scripts/setup-hooks.sh` installs pre-push hook
EOF
)"

  echo "[OK] PR created for agent-sh/$REPO"
}

# Roll out to Node repos
for repo in $NODE_REPOS; do
  rollout_repo "$repo" "node"
done

# Roll out to Rust repos
for repo in $RUST_REPOS; do
  rollout_repo "$repo" "rust"
done

echo ""
echo "[OK] Rollout complete"
