# Overview

## Goal
Fix the version bump script so it correctly locates the version tag in the agent definition file and runs successfully.

## Context
The current error is:
- `sed: agents/vibe-flow.agent.md: No such file or directory`
- `Error: Could not find version in agents/vibe-flow.agent.md`

This indicates the script is referencing an incorrect path and/or version lookup logic.

## Non-Goals
- Changing unrelated release processes
- Modifying agent behavior beyond versioning
