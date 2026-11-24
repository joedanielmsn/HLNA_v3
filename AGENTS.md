# HLNA — AI Development Instructions

## Read first
- Read `docs/MASTER_PLAN.md` before proposing architectural or product changes.
- Read `docs/PRODUCT_PLAN.md` for the current staged direction.
- Read `UPSTREAMS.md` before adopting, bundling, or modifying an upstream project.

## Project philosophy
1. Reuse mature, maintained open-source applications and services wherever practical.
2. Prefer integrating complete upstream applications over rebuilding their functionality.
3. Research existing projects before writing custom code.
4. Integrate through supported APIs, SDKs, MCP, plugins, and stable interfaces.
5. Write HLNA-specific code for orchestration, integration, permissions, resource management, compatibility, genuine gaps, and the user experience.
6. Keep upstream projects replaceable behind clear interfaces where practical.

## Architecture principles
- One central orchestrator with on-demand specialist capabilities.
- Shared model runtimes where practical; bounded parallelism.
- A central permission broker that no agent, plugin, or automation can bypass.
- A hardware-aware AI resource manager.
- Event-driven execution; avoid unnecessary always-on inference.
- Local-first operation with optional cloud services.
- Modular, maintainable boundaries; prefer the simplest architecture that meets requirements.

## Research and decision rules
- Do not treat historical experiments or previous technology suggestions as final decisions.
- Compare viable existing solutions, maintenance health, capabilities, integration options, resource costs, security, platform support, and licences before selection.
- Record significant decisions and their rationale in `docs/decisions/`.
- Record evaluated upstream projects and pinned revisions in `UPSTREAMS.md`.
- Review third-party and model licences. Project licensing remains intentionally deferred; revisit it before architecture finalisation and public release.

## Safety and privacy
- Route privileged operations through the permission broker.
- Require approval according to policy for consequential, destructive, or external actions.
- Make permissions visible, scoped, revocable, and auditable.
- Never add hidden screen, camera, or microphone monitoring.
- Make observation visible, explicitly enabled, and pausable.
- Require user review before activating learned or suggested workflows.
- Keep local data local unless the user explicitly enables a remote service.

## Engineering workflow
- Current stage: discovery and architecture research; do not begin product implementation until the architecture direction is agreed.
- Work in small, reviewable changes.
- Inspect the existing repository before editing.
- Never overwrite unrelated work or discard user changes.
- Explain important changes and trade-offs.
- Add focused automated tests for implemented behaviour.
- Run relevant formatting, build, and test checks before claiming a change is verified.
- Do not claim tests were run unless they were actually run.
- Keep dependencies and upstream changes documented.

## Initial development environment
- CachyOS / Arch Linux
- NVIDIA RTX 3050 4 GB VRAM
- 16 GB RAM
- Windows is also an initial target

Treat hardware details as a baseline for resource-aware design, not as a reason to hard-code a single machine configuration.
