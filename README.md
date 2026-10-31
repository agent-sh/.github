# .github

Shared CI workflows, workflow templates, and scripts for the agent-sh organization.

## Reusable Workflows

Located in `.github/workflows/`, these are called via `workflow_call` from individual repos.

### ci-node.yml

Reusable Node.js CI workflow. Steps: checkout, setup Node, `npm ci` (`npm install --no-save` when there is no lockfile), run tests. Tests are skipped when `package.json` has no `test` script.

**Inputs:**

| Input | Default | Description |
|-------|---------|-------------|
| `node-version` | `24` | Node.js version |
| `test-command` | `npm test` | Test command to run |

**Caller example:**

```yaml
jobs:
  ci:
    uses: agent-sh/.github/.github/workflows/ci-node.yml@main
```

### ci-rust.yml

Reusable Rust CI workflow. Steps: checkout, install toolchain, `cargo fmt --check`, `cargo clippy`, `cargo test`.

**Inputs:**

| Input | Default | Description |
|-------|---------|-------------|
| `rust-version` | `stable` | Rust toolchain version |

**Caller example:**

```yaml
jobs:
  ci:
    uses: agent-sh/.github/.github/workflows/ci-rust.yml@main
```

### ci-agnix.yml

Reusable agnix workflow. Validates agent configs with the agnix action, reading `.agnix.toml`, and fails on errors. No inputs.

```yaml
jobs:
  agnix:
    uses: agent-sh/.github/.github/workflows/ci-agnix.yml@main
```

### codeql.yml

Reusable CodeQL analysis, one job per language.

| Input | Default | Description |
|-------|---------|-------------|
| `languages` | `javascript-typescript` | Comma-separated CodeQL languages, e.g. `javascript-typescript,python` |

### sync-core.yml

Copies a lib directory from a source repo into each target repo and opens a PR where it changed.

| Input | Default | Description |
|-------|---------|-------------|
| `source-repo` | required | Source repo (`org/name`) |
| `target-repos` | required | JSON array of agent-sh repo names |
| `lib-path` | `lib` | Path to the lib directory in the source |

Needs a `SYNC_TOKEN` secret: a PAT with repo scope for the cross-repo PRs.

## Workflow Templates

Located in `workflow-templates/`, these are available in the GitHub "New workflow" UI for org repos.

| Template | Description |
|----------|-------------|
| `ci-node.yml` | Thin caller for the reusable Node.js CI workflow |
| `ci-rust.yml` | Thin caller for the reusable Rust CI workflow |
| `claude-code-review.yml` | Automated PR review via Claude Code (owner/member/collaborator, max 3 runs per head commit) |
| `claude-mentions.yml` | Respond to @claude mentions in issues and PRs |

## Scripts

### setup-hooks.sh

Detects project type (Node.js or Rust) and installs the appropriate pre-push git hook.

```bash
sh scripts/setup-hooks.sh
```

### rollout.sh

Rolls out CI workflows, Claude Code integrations, and hooks to the repos listed in the script (`NODE_REPOS`, `RUST_REPOS`) by creating PRs.

```bash
sh scripts/rollout.sh            # Create PRs
sh scripts/rollout.sh --dry-run  # Preview changes
```

## Required Org Secrets

| Secret | Used By | Purpose |
|--------|---------|---------|
| `CLAUDE_CODE_OAUTH_TOKEN` | claude-code-review, claude-mentions | Authentication for Claude Code Action |

## Adoption

For new repos, either:

1. Use the workflow templates from the GitHub UI ("Actions" > "New workflow")
2. Add the repo to the lists in `scripts/rollout.sh` and run it
3. Manually copy the caller workflow and scripts

After adding workflows, install the git hook locally:

```bash
sh scripts/setup-hooks.sh
```
