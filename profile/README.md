# agent-sh

Tools and infrastructure for coding agents. Software keeps the state, gates, permissions, memory and hardware bridges; models write code and make calls. Built for Claude Code, Codex, OpenCode, Cursor, Kiro and MCP hosts.

## Projects

| Project | What it does |
|---|---|
| **[agentsys](https://github.com/agent-sh/agentsys)** | Plugin marketplace and workflow runtime for coding agents. 11 plugins, 5 agents and 14 skills across Claude Code, Codex, OpenCode, Cursor and Kiro. |
| **[foreman](https://github.com/agent-sh/foreman)** | GitHub issues as a task queue for native agents. A session picks and claims the next ready issue, worktree subagents implement it, and foreman lands the PR at the exact head it checked. No daemon: labels, assignees and comments are the state. |
| **[agnix](https://github.com/agent-sh/agnix)** | Linter and language server for agent configs. 757 rules with autofixes across `CLAUDE.md`, `AGENTS.md`, `SKILL.md`, hooks and MCP. Ships as a CLI, LSP, GitHub Action, and VS Code, JetBrains, Neovim and Zed extensions. |
| **[tacit](https://github.com/agent-sh/tacit)** | Fact memory for coding agents in plain Markdown and git, local or shared across machines. Lexical FTS5 retrieval, git-derived facts (hot spots, co-change, module map, measured results, staleness), and a verifier grounded in code, git history and the owner's words. |
| **[tools](https://github.com/agent-sh/tools)** | Agent tools built for how LLMs actually call tools: `read`, `write`/`edit`, `grep`, `glob`, `bash`, `batch`, `webfetch`, `websearch`, `lsp` and `skill`. Typed union results, recovery hints on every error, and fail-closed workspace permissions in TypeScript (`@agent-sh/harness-*`) and Rust (`harness-tools`). Includes **[`@agent-sh/harness-web-mcp`](https://github.com/agent-sh/tools/tree/main/packages/web-mcp)** for keyless `websearch` and SSRF-guarded `webfetch` over MCP. |
| **[computer-use-linux](https://github.com/agent-sh/computer-use-linux)** | Native Linux desktop control over MCP. AT-SPI accessibility selectors, Wayland portals and window targeting across GNOME, KDE, Hyprland, niri, i3 and COSMIC. Rust. |
| **[agent-workspace-linux](https://github.com/agent-sh/agent-workspace-linux)** | Isolated Linux desktops for AI agents over MCP. Gives an agent its own hidden display, window manager and browser so it can run and QA GUI and web work without touching your real desktop. Rust. |
| **[agent-chrome-bridge](https://github.com/agent-sh/agent-chrome-bridge)** | Shared local Chrome bridge for Claude Code and Codex. Lets agents drive the Chrome you already have open (your tabs, logins and profile) through one local broker and native messaging host, with compact element lists, tab locks and URL guards. |
| **[parlar](https://github.com/agent-sh/parlar)** | Voice conversation mode for Claude Code and Codex. Talk to a running session, idle or mid-work, and it answers out loud while diffs and logs stay in the terminal. Pushes speech through hooks without terminal injection; runs locally on the CPU (Phonon-2, Kokoro). Rust. |

## Quick start

```bash
# Workflows and config linting
npm install -g agentsys && agentsys
npx agnix .

# Keyless web search and web fetch MCP (Claude Code / Codex)
claude mcp add -s user harness-web -- npx -y @agent-sh/harness-web-mcp
codex mcp add harness-web -- npx -y @agent-sh/harness-web-mcp

# Shared Chrome bridge, Linux computer use, and local voice mode
npx @agent-sh/chrome-bridge@latest setup
npm install -g @agent-sh/computer-use-linux
cargo install parlar parlard && parlard fetch && parlard service
```

## How it is built

- **Software holds the state and the gates.** Queue state lives in GitHub labels and comments, memory facts in plain files and git, not inside a context window that gets compacted. [`foreman`](https://github.com/agent-sh/foreman) lands a PR only at the head it checked, with every check green and every review finding addressed.
- **Tools are shaped for model callers.** Models guess parameter names, misremember paths and retry on whatever an error says. Every tool in [`tools`](https://github.com/agent-sh/tools) returns a typed union instead of throwing, answers wrong field names with targeted hints, and lists candidate paths or match locations on `NOT_FOUND` and `OLD_STRING_NOT_UNIQUE`.
- **Config and memory are checked against sources.** [`agnix`](https://github.com/agent-sh/agnix) catches broken `SKILL.md`, `AGENTS.md`, hook and MCP files before an agent silently ignores them. [`tacit`](https://github.com/agent-sh/tacit) checks stored facts against code, git history and the owner's own words instead of letting stale notes accumulate.
- **Real desktop and browser surfaces, fenced.** [`computer-use-linux`](https://github.com/agent-sh/computer-use-linux) speaks AT-SPI and Wayland portals; [`agent-workspace-linux`](https://github.com/agent-sh/agent-workspace-linux) gives the agent a separate display and browser; [`agent-chrome-bridge`](https://github.com/agent-sh/agent-chrome-bridge) shares your open Chrome with tab locks and URL guards.

<details>
<summary><strong>Plugins, skills and shared libraries</strong></summary>

**Workflows** · [foreman](https://github.com/agent-sh/foreman) · [deslop](https://github.com/agent-sh/deslop)

**Skills** · [learn](https://github.com/agent-sh/learn) · [skillers](https://github.com/agent-sh/skillers) · [ada-spark](https://github.com/agent-sh/ada-spark) · [mojo](https://github.com/agent-sh/mojo) · [glidemq](https://github.com/agent-sh/glidemq) · [zig-lsp](https://github.com/agent-sh/zig-lsp)

**Curation and research** · [banthis](https://github.com/agent-sh/banthis) · [skill-curator](https://github.com/agent-sh/skill-curator) · [system-prompt-curator](https://github.com/agent-sh/system-prompt-curator) · [agent-knowledge](https://github.com/agent-sh/agent-knowledge)

**Analysis** · [agent-analyzer](https://github.com/agent-sh/agent-analyzer)

</details>

---

Built and maintained by **[Avi Fenesh](https://github.com/avifenesh)** ([avifenesh.ai](https://avifenesh.ai) · [@avi_fenesh](https://x.com/avi_fenesh)), founder of **[Tiyuvta](https://tiyuvta.ai)** and **[Valkey GLIDE](https://github.com/valkey-io/valkey-glide)** maintainer.

If you enjoy these tools and want to help cover the tokens, you can **[sponsor on GitHub](https://github.com/sponsors/avifenesh)**.
