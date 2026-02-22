# Workspace Memory: agent-sh

> Monorepo for the agent-sh ecosystem - agent tooling, plugins, and infrastructure.

## Workspace Structure

```
agentsys/        → Marketplace & installer (npm). Agents, skills, commands, adapters.
agnix/           → Linter for agent configurations (Rust). Validates CLAUDE.md, skills, hooks, MCP.
agent-core/      → Core shared library
agent-knowledge/ → Knowledge base and documentation
agent-sh.dev/    → Website
audit-project/   → Multi-agent code review plugin
consult/         → Consultation plugin
debate/          → Debate orchestration plugin
design-system/   → Shared CSS design tokens and base styles for all ecosystem sites
deslop/          → AI slop cleanup plugin
drift-detect/    → Plan vs implementation comparison plugin
enhance/         → Enhancement analyzers plugin
learn/           → Research & learning guide plugin
next-task/       → Task workflow plugin
perf/            → Performance investigation plugin
repo-map/        → AST-based repo map plugin
ship/            → PR creation, CI monitoring, merge plugin
sync-docs/       → Documentation sync plugin
web-ctl/         → Web control plugin
```

## Work Prioritization

Work is prioritized by the **agent-sh Roadmap** project board (GitHub Projects v2). Always pick tasks by priority order: P0 first, then P1, P2, P3. Check the board before starting work:

```bash
gh project item-list 1 --owner agent-sh --format json | jq '[.items[] | select(.status == "Todo")] | sort_by(.priority)'
```

## Critical Rules

1. **Plain text output** - No emojis, no ASCII art. Use `[OK]`, `[ERROR]`, `[WARN]`, `[CRITICAL]` for status markers.
2. **No unnecessary files** - Don't create summary files, plan files, audit files, or temp docs. Report completion verbally.
3. **Task is not done until tests pass** - Every feature/fix must have quality tests. Fix all test failures before proceeding.
4. **Create PRs for non-trivial changes** - No direct pushes to main. Wait for auto-reviewers and address ALL comments.
5. **Always run git hooks** - Never bypass pre-commit or pre-push hooks. Fix the root cause if a hook blocks.
6. **Use single dash for em-dashes** - In prose, use ` - ` (single dash with spaces), never ` -- ` (double dash). Does not apply to CLI flags.
7. **Report script failures before manual fallback** - Never silently bypass broken tooling. Report, diagnose, and fix.
8. **Token efficiency** - Be concise. Save tokens over decorations.

## Key Projects

### agnix (Rust)

Linter for agent configuration files. Rust workspace with crates: agnix-rules, agnix-core, agnix-cli, agnix-lsp, agnix-mcp, agnix-wasm.

```bash
cargo check                 # Compile check
cargo test                  # Run tests
cargo build --release       # Build binaries
cargo run --bin agnix -- .  # Run CLI
```

- 230 validation rules in `knowledge-base/rules.json` (source of truth)
- `rules.json` and `VALIDATION-RULES.md` must stay in sync (CI enforced)
- `CLAUDE.md` and `AGENTS.md` must be identical (tests enforce this)

### agentsys (Node.js)

Marketplace, installer, and plugin framework. Contains agents, skills, commands, and platform adapters (Claude Code, OpenCode, Codex).

```bash
npm test                    # Run tests
npm run validate            # All validators
npm run preflight           # Change-aware checks
npm run gen-docs            # Auto-generate docs
npx agentsys-dev status     # Project health
```

- Pattern: `Command → Agent → Skill` (orchestration → invocation → implementation)
- Read relevant `checklists/*.md` before multi-file changes
- 3 platforms must work: Claude Code + OpenCode + Codex

## Model Selection

| Model | When to Use |
|-------|-------------|
| **Opus** | Complex reasoning, analysis, planning |
| **Sonnet** | Validation, pattern matching, most agents |
| **Haiku** | Mechanical execution, no judgment needed |

## Core Priorities

1. User DX (plugin users first)
2. Worry-free automation
3. Token efficiency
4. Quality output
5. Simplicity

## References

- agnix: `agnix/CLAUDE.md`, `agnix/SPEC.md`, `agnix/knowledge-base/`
- agentsys: `agentsys/CLAUDE.md`, `agentsys/README.md`, `agentsys/checklists/`
- https://agentskills.io
- https://modelcontextprotocol.io
