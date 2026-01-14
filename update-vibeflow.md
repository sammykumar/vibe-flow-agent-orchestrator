# Update Vibe Flow

These instructions update the Vibe Flow (Plan-Driven Development) agents and documentation to the latest version.

<!-- version: 1.0.0 -->

Process overview:

1. Check for existing installation
2. Check for Latest Version
3. Fetch Agent Profiles
4. Report to the user

## 1. Check for existing installation

- Verify that `.github/agents/vibe-flow.agent.md` exists.
- If it does not exist, STOP and advise the user to run `install-vibeflow.md` instead.

## 2. Check for Latest Version

Before fetching, check the latest version tag from GitHub:

```bash
# Fetch tags, filter for those starting with "v" (to ignore "latest"), pick the top one
LATEST_TAG=$(curl -s https://api.github.com/repos/sammykumar/vibe-flow-agent-orchestrator/tags | grep '"name": "v' | head -n 1 | cut -d '"' -f 4)
echo "Latest Vibe Flow version: $LATEST_TAG"
```

## 3. Fetch Agent Profiles

Download all agents to `.github/agents`. Existing agents will be overwritten with the latest versions:

- Fetch [vibe-flow.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/agents/vibe-flow.agent.md) to `.github/agents/vibe-flow.agent.md`
- Fetch [research.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/agents/subagents/research.agent.md) to `.github/agents/research.agent.md`
- Fetch [implement.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/agents/subagents/implement.agent.md) to `.github/agents/implement.agent.md`
- Fetch [test.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/agents/subagents/test.agent.md) to `.github/agents/test.agent.md`
- Fetch [document.agent.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/agents/subagents/document.agent.md) to `.github/agents/document.agent.md`
- Fetch [pdd-protocol.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/pdd-protocol.md) to `docs/vibeflow/pdd-protocol.md`
- Fetch [orchestrator-manual.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/docs/vibeflow/orchestrator-manual.md) to `docs/vibeflow/orchestrator-manual.md`
- Fetch [new-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/prompts/new-feature.prompt.md) to `.github/prompts/new-feature.prompt.md`
- Fetch [update-feature.prompt.md](https://raw.githubusercontent.com/sammykumar/vibe-flow-agent-orchestrator/${LATEST_TAG:-master}/prompts/update-feature.prompt.md) to `.github/prompts/update-feature.prompt.md`

### 3.1 Verify Update

After fetching, verify `.github/agents/vibe-flow.agent.md` contains the `version:` comment (e.g., `<!-- version: 1.0.1 -->`).

## 4. Report to the User

Report which agents were upgraded:

```markdown
# Vibe Flow Updated

The following agents have been updated to the latest version (${LATEST_TAG}):

- vibe-flow.agent.md
- research.agent.md
- implement.agent.md
- test.agent.md
- document.agent.md
- docs/vibeflow/pdd-protocol.md
- docs/vibeflow/orchestrator-manual.md
- .github/prompts/new-feature.prompt.md
- .github/prompts/update-feature.prompt.md

All agent profiles and prompts are now in sync with the official repository.
```
