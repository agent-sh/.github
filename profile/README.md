<h1 align="center">agent-sh</h1>

<p align="center">
  <strong>Code does code work. AI does AI work.</strong>
</p>

<p align="center">
  Open-source tooling for coding agents — Claude Code, Codex, OpenCode, Cursor, Kiro, and MCP hosts.
</p>

<p align="center">
  <b>24 plugins · 50 agents · 45 skills · 423 lint rules · 15 desktop MCP tools</b>
</p>

<p align="center"><em>New plugins, validators, and MCPs ship constantly. Follow for updates:</em></p>
<p align="center">
  <a href="https://x.com/avi_fenesh"><img src="https://img.shields.io/badge/Follow-@avi__fenesh-1DA1F2?style=for-the-badge&logo=x&logoColor=white" alt="Follow on X"></a>
</p>

---

## Start here

| Project | What it is |
|---|---|
| **[agentsys](https://github.com/agent-sh/agentsys)** | Plugin marketplace and orchestration runtime for coding agents. 24 plugins, 50 agents, 45 skills across Claude Code, Codex, OpenCode, Cursor, and Kiro. |
| **[agnix](https://github.com/agent-sh/agnix)** | Linter and LSP for agent configuration. 423 rules across `CLAUDE.md`, `AGENTS.md`, `SKILL.md`, hooks, MCP — the validation skills don't get anywhere else. CLI, LSP, editor extensions, GitHub Action. |
| **[computer-use-linux](https://github.com/agent-sh/computer-use-linux)** | MCP server for native Linux desktop control. AT-SPI accessibility trees, real Wayland support, multi-compositor window targeting (GNOME, KDE, Hyprland, i3, COSMIC). 15 tools, Rust. |

```bash
npm install -g agentsys && agentsys
npx agnix .
npm install -g @agent-sh/computer-use-linux
```

## Why this exists

AI writes code. That's the easy part now. The work around it was the bottleneck:

- **Skills don't trigger** when their config has the wrong field. Vercel's research found skills [invoke at 0%](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals) without correct syntax — and you find out after the fact.
- **"Computer use" MCPs only work on macOS.** The Linux options drive `xdotool` against X11 and pretend Wayland doesn't exist.
- **Context doesn't survive a session.** You restate the same project decisions every time, or you bloat `AGENTS.md` until it stops being read.
- **Reviews happen by vibes.** CI breaks at the worst time.

I built these tools for myself first. Posting them here in case they're useful to you too.

Three principles shape everything in this org:

- Deterministic tools do detection. Models do judgment.
- A workflow is a pipeline with gates, not a monolith.
- Configuration should fail loudly before production work depends on it.

<details>
<summary><strong>Also in the ecosystem</strong> — plugins, memory, infra</summary>

**Workflows** · [next-task](https://github.com/agent-sh/next-task) · [prepare-delivery](https://github.com/agent-sh/prepare-delivery) · [audit-project](https://github.com/agent-sh/audit-project) · [ship](https://github.com/agent-sh/ship) · [gate-and-ship](https://github.com/agent-sh/gate-and-ship) · [deslop](https://github.com/agent-sh/deslop) · [enhance](https://github.com/agent-sh/enhance) · [sync-docs](https://github.com/agent-sh/sync-docs) · [drift-detect](https://github.com/agent-sh/drift-detect) · [perf](https://github.com/agent-sh/perf)

**Memory & curation** · [axiom](https://github.com/agent-sh/axiom) · [banthis](https://github.com/agent-sh/banthis) · [skill-curator](https://github.com/agent-sh/skill-curator) · [system-prompt-curator](https://github.com/agent-sh/system-prompt-curator)

**Skills** · [onboard](https://github.com/agent-sh/onboard) · [can-i-help](https://github.com/agent-sh/can-i-help) · [learn](https://github.com/agent-sh/learn) · [consult](https://github.com/agent-sh/consult) · [debate](https://github.com/agent-sh/debate) · [skillers](https://github.com/agent-sh/skillers)

**Infra** · [agent-analyzer](https://github.com/agent-sh/agent-analyzer) · [agent-core](https://github.com/agent-sh/agent-core) · [repo-intel](https://github.com/agent-sh/repo-intel)

**Bridges** · [glidemq](https://github.com/agent-sh/glidemq)

</details>

---

<sub>Built and maintained by <strong><a href="https://github.com/avifenesh">Avi Fenesh</a></strong> — Valkey contributor and Valkey GLIDE maintainer. Solo-maintained. Contributions welcome if they fit — please follow <a href="../CONTRIBUTING.md">CONTRIBUTING.md</a>.</sub>
