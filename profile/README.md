<p align="center">
  <strong>Code does code work. AI does AI work.</strong>
</p>

<p align="center">
  Open-source tools for autonomous AI agent workflows.<br>
  Task selection → implementation → review → shipping — fully automated after plan approval.
</p>

---

### Projects

| Repo | What it does |
|------|-------------|
| [**agentsys**](https://github.com/agent-sh/agentsys) | Agent orchestration runtime — 13 plugins, 42 agents, 28 skills. Works with Claude Code, OpenCode, Codex. |
| [**agnix**](https://github.com/agent-sh/agnix) | Lint agent configs before they break. 155 rules for CLAUDE.md, AGENTS.md, skills, hooks, MCP. |
| [**web-ctl**](https://github.com/agent-sh/web-ctl) | Browser interaction skill for AI agents — Playwright-based, no MCP overhead. |
| [**agent-core**](https://github.com/agent-sh/agent-core) | Shared libraries synced to all plugins. |
| [**agent-knowledge**](https://github.com/agent-sh/agent-knowledge) | Research guides and RAG indexes for AI agent development. |

### Quick Start

```bash
# Claude Code
/plugin marketplace add agent-sh/agentsys

# All platforms
npm install -g agentsys && agentsys
```

### Philosophy

- **If it can be specified, it can be delegated.**
- One agent, one job, done extremely well.
- Pipeline with gates, not a monolith.
- Approve the plan. See the results. The middle is automated.
