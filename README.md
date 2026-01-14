# Vibe Flow Agent Orchestrator

Plan-Driven Development (PDD) agent suite for managing complex software projects through structured research, implementation, testing, and documentation phases.

**Tags:** github-copilot, agents, orchestration, pdd, project-management, testing, documentation

_Heavily Inspired by AlignFirst V1 (https://github.com/paleo/alignfirst/blob/v1/README.md)_

## 🎯 What is Vibe Flow?

Vibe Flow is a complete agent-based development framework that transforms how you build software. Instead of ad-hoc coding, Vibe Flow enforces a structured workflow:

1. **Research** → Investigate and specify
2. **Plan** → Break down into tasks
3. **Implement** → Execute with verification
4. **Test** → Validate with comprehensive QA
5. **Document** → Update architecture & guides

All work is tracked in `.github/plans/` directories, creating a permanent memory of your project's evolution.

## 🚀 Quick Start

| Action                  | Description                                                        | Install                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Install Vibe Flow**   | Bootstrap the complete Vibe Flow agent suite into your repository  | [![Install in VS Code](https://img.shields.io/badge/VS_Code-Install-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](vscode:chat-prompt/install?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsammykumar%2Fvibe-flow-agent-orchestrator%2Fmain%2Finstall-vibeflow.md)<br />[![Install in VS Code Insiders](https://img.shields.io/badge/VS_Code_Insiders-Install-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](vscode-insiders:chat-prompt/install?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsammykumar%2Fvibe-flow-agent-orchestrator%2Fmain%2Finstall-vibeflow.md)     |
| **Uninstall Vibe Flow** | Safely remove Vibe Flow from your repository (with backup options) | [![Install in VS Code](https://img.shields.io/badge/VS_Code-Install-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](vscode:chat-prompt/install?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsammykumar%2Fvibe-flow-agent-orchestrator%2Fmain%2Funinstall-vibeflow.md)<br />[![Install in VS Code Insiders](https://img.shields.io/badge/VS_Code_Insiders-Install-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](vscode-insiders:chat-prompt/install?url=https%3A%2F%2Fraw.githubusercontent.com%2Fsammykumar%2Fvibe-flow-agent-orchestrator%2Fmain%2Funinstall-vibeflow.md) |

## 🤖 Agents Included

Once installed, Vibe Flow provides:

### Main Orchestrator

- **@vibe-flow** - The master orchestrator that manages the entire PDD lifecycle, delegates to subagents, and maintains project state

### Specialized Subagents

| Agent               | Role                          | Responsibilities                                                                                  |
| ------------------- | ----------------------------- | ------------------------------------------------------------------------------------------------- |
| **research-agent**  | Investigation & Specification | Analyzes codebases, authors technical specs, evaluates alternatives, creates implementation plans |
| **implement-agent** | Code Execution                | Implements plans autonomously, performs micro-verification, maintains high-signal progress logs   |
| **test-agent**      | Quality Assurance             | Writes unit/integration/E2E tests, validates coverage, reports failures with evidence             |
| **document-agent**  | Knowledge Archivist           | Creates architecture diagrams, maintains API docs, updates guides and README files                |

## 📂 Project Structure Created

After installation, your repository will have:

```
.github/
├── agents/                    # All Vibe Flow agents
│   ├── vibe-flow.agent.md    # Main orchestrator
│   ├── research.agent.md     # Research specialist
│   ├── implement.agent.md    # Implementation specialist
│   ├── test.agent.md         # QA specialist
│   └── document.agent.md     # Documentation specialist
└── plans/                     # Project memory (PDD)
    ├── todo/                  # Planned work
    ├── in-progress/           # Active tasks
    └── finished/              # Completed work

docs/
├── vibeflow/
│   ├── pdd-protocol.md       # PDD rules & standards
│   └── orchestrator-manual.md # Usage guide
├── guides/                    # Development guides
└── architecture/              # Diagrams & ADRs

AGENTS.md                      # Quick reference
```

## 💡 Usage

Once installed, start any complex task with:

```
@vibe-flow Implement user authentication with JWT tokens
```

The orchestrator will:

1. ✅ Create a plan structure in `.github/plans/in-progress/`
2. ✅ Delegate to **research-agent** for investigation
3. ✅ Delegate to **implement-agent** for code changes
4. ✅ Delegate to **test-agent** for validation
5. ✅ Delegate to **document-agent** for updates
6. ✅ Report completion and guide you to archive the plan

## 🔄 Version Management

Current Version: **1.3.1** (Single source of truth in `vibe-flow.agent.md`)

All agents are versioned as a suite. When you update Vibe Flow, all agents update together to maintain compatibility.

### Check for Updates

Simply run the install prompt again - it will check GitHub for the latest version and update if needed.

## 📖 Documentation

- **[PDD Protocol](docs/vibeflow/pdd-protocol.md)** - The rules for Plan-Driven Development
- **[Orchestrator Manual](docs/vibeflow/orchestrator-manual.md)** - Detailed usage guide
- **[Development Guide](.github/copilot-instructions.md)** - For contributors to this repository

## 🛠️ Development

This repository is the **source code** for Vibe Flow agents.

- **"Code"**: Markdown files (`*.agent.md`)
- **"Compiler"**: The LLM that interprets them
- **"Installer"**: `install-vibeflow.md` prompt
- **"Package Manager"**: VS Code Chat Prompt Install system

### Contributing

To modify agents or add features:

1. Edit agent files in `agents/` or `agents/subagents/`
2. Update `install-vibeflow.md` if structure changes
3. Run `./version-bump.sh [major|minor|patch]`
4. Test in a target repository

See [.github/copilot-instructions.md](.github/copilot-instructions.md) for detailed development guidelines.

## 📜 License

MIT License - See LICENSE file for details

## 🙏 Acknowledgments

Built with ❤️ for the GitHub Copilot community.

Special thanks to the teams behind VS Code, GitHub Copilot, and the Model Context Protocol (MCP).

---

**Questions or Issues?** Open an issue in this repository or contact [@sammykumar](https://github.com/sammykumar).
