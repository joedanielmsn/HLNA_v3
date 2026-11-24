# HLNA v3 — Product and Discovery Plan

This document translates the complete vision in [MASTER_PLAN.md](MASTER_PLAN.md) into a practical sequence of work. The master plan remains the authoritative source for detailed requirements.

## Current status

**Phase 0 — discovery and architecture.** The repository is a clean planning baseline. No implementation stack, desktop foundation, or upstream dependency is currently selected by this plan.

See [PHASE_0_DISCOVERY_PLAN.md](PHASE_0_DISCOVERY_PLAN.md) for the detailed research sequence and Phase 0 exit gate. See [ARCHITECTURE_OPTIONS.md](ARCHITECTURE_OPTIONS.md) for the preliminary architecture comparison; it is a recommendation, not an approved design.

## Guiding product strategy

HLNA is not intended to reimplement every assistant capability. First identify mature, maintained open-source applications and services that already solve substantial parts of the product. Prefer integrating those components through supported APIs, SDKs, MCP, plugins, or service interfaces.

Custom HLNA development should concentrate on the parts that create a coherent product: integration, central orchestration, permissions, resource management, compatibility, project intelligence, and the HLNA user experience.

## Phase 0 — requirements, research, and architecture

- Consolidate and prioritise the requirements in MASTER_PLAN.md.
- Separate foundational requirements from later-stage ambitions.
- Research mature upstream applications and services for each major capability.
- Check maintenance activity, community health, APIs, extension points, platform support, resource requirements, security posture, and licences.
- Compare integration options against rebuilding only where necessary.
- Verify the development hardware and practical model/runtime constraints.
- Design boundaries for the central orchestrator, permission broker, resource manager, memory, integrations, and desktop experience.
- Record decisions, alternatives, trade-offs, and unresolved questions.
- Revisit licensing before architecture finalisation and public release.

**Exit gate:** an agreed architecture and integration strategy, with documented upstream selections and rejected alternatives. Do not begin broad implementation before this gate.

## Phase 1 — platform foundation

Subject to architecture decisions:
- Application/service lifecycle and configuration.
- Diagnostics, structured logging, and event system.
- Permission broker foundations.
- Resource manager foundations.
- Model/runtime abstraction.
- Minimal usable assistant experience.

## Phase 2 — intelligence and knowledge

- Central orchestrator and on-demand specialist capabilities.
- Model routing and runtime coordination.
- Conversation and structured memory.
- Document retrieval and project-scoped knowledge.
- User inspection, editing, export, and deletion controls.

## Phase 3 — tools and computer interaction

- Integration/plugin framework.
- File, terminal, browser, and desktop capabilities.
- Permission prompts and action previews.
- Verification, cancellation, audit history, undo, and checkpoints.

## Phase 4 — desktop experience

- Chat and project workspaces.
- Dashboard and floating companion.
- Configurable voice.
- Visible, pausable desktop awareness.
- Notifications and proactive assistance controls.

## Phase 5 — automation and ecosystem

- Workflow recording and suggestions.
- User-reviewed scheduled and event-triggered automation.
- Plugin SDK, compatibility, sandboxing, and trust model.

## Phase 6 — portability and distribution

- Backup, restore, and portable data export.
- Optional encrypted sync and self-hosted mode.
- Windows and Linux packaging and clean-install validation.

## Phase 7 — AI-integrated Arch distribution

- Base-system and desktop strategy.
- Modular installation profiles.
- Hardware detection and configuration.
- Developer and gaming profiles.
- Installer, update, and recovery strategy.

## Release quality

A successful build is not automatically a release-ready product. Each milestone needs measurable acceptance criteria covering reliability, security, privacy, resource use, reversibility, and supported-platform installation. The detailed requirements are in MASTER_PLAN.md.
