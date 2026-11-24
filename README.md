# HLNA v3

**A free, open-source, local-first AI computing platform.**

HLNA aims to combine a local assistant platform, a universal AI desktop experience, and—long term—an AI-integrated Arch-based operating system. The project is being restarted from a clean planning baseline.

## Start here

1. [Master plan](docs/MASTER_PLAN.md) — the complete product vision and established requirements.
2. [Product plan](docs/PRODUCT_PLAN.md) — staged direction and discovery priorities.
3. [Phase 0 discovery plan](docs/PHASE_0_DISCOVERY_PLAN.md) — detailed research sequence and architecture exit gate.
4. [Upstream strategy](UPSTREAMS.md) — reuse-first policy and the status of upstream evaluations.
5. [AI development instructions](AGENTS.md) — guidance for AI coding assistants working in this repository.

## Current stage

**Discovery and architecture research.** No implementation stack or upstream application is currently locked in by this planning baseline.

The next work is to consolidate requirements, research mature open-source projects, compare integration and architecture options, and record decisions before implementation begins.

## Core principles

- Reuse mature, maintained upstream software instead of rebuilding solved capabilities.
- Prefer complete applications and services connected through APIs, SDKs, MCP, plugins, and stable interfaces.
- Keep HLNA-specific code focused on integration, orchestration, permissions, resource management, compatibility, and genuine gaps.
- Local-first by default; cloud services are optional and explicit.
- Central permission broker and hardware-aware resource management.
- Visible, pausable desktop awareness; no hidden screen, camera, or microphone monitoring.
- Keep the experience configurable, practical, and resource-conscious.

## Platforms and hardware

Initial platform priorities are CachyOS / Arch Linux and Windows. Development begins on CachyOS / Arch Linux. The initial hardware baseline is an NVIDIA RTX 3050 with 4 GB VRAM and 16 GB RAM; the design must remain configurable and support other hardware.

## Repository contents

- `AGENTS.md` — instructions for AI development tools.
- `docs/MASTER_PLAN.md` — complete source-of-truth requirements and long-term vision.
- `docs/PRODUCT_PLAN.md` — staged product direction and immediate discovery work.
- `docs/PHASE_0_DISCOVERY_PLAN.md` — working discovery plan, upstream research sequence, and exit gate.
- `UPSTREAMS.md` — reuse-first integration policy and evaluated upstream candidates.

## Licensing

The project licence is intentionally undecided. Review first-party, third-party, and model licences during architecture finalisation and before public release.
