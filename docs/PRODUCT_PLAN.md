# HLNA v3 product plan

## Product goal

Deliver one cohesive desktop assistant for Windows and CachyOS, with local-first inference and optional cloud providers. Build on mature projects rather than rewriting chat, model serving, document indexing, browser automation, or workflow engines from scratch.

## Stage 0 — reproducible desktop baseline

- Build the pinned Jan desktop source on GitHub-hosted Windows and Linux runners.
- Produce a Windows x64 installer and a CachyOS/Arch x86_64 pacman package.
- Keep upstream attribution and license material intact.
- Publish checksums and build artifacts.
- No model weights are bundled.

## Stage 1 — HLNA model/runtime integration

- Make the user's existing Ollama runtime a first-class provider.
- Add a guided local endpoint preset for Ollama's OpenAI-compatible API.
- Preserve the tested Qwen 3.5 2B Q4_K_M / 16,384-token context profile as an optional preset, not a hard-coded assumption.
- Detect runtime availability and model presence; never download a multi-gigabyte model silently.
- Provide CPU fallback and avoid competing inference servers loading the same model simultaneously.
- Keep cloud providers opt-in and clearly label remote requests.

## Stage 2 — HLNA identity and desktop experience

- Introduce HLNA branding without removing upstream notices or violating upstream trademark/branding requirements.
- Create a single command-centre home, configurable assistant profiles, and a lightweight floating companion.
- Preserve chat streaming, cancellation, conversation history, Markdown/code rendering, copy, regenerate, rename, and delete behaviors already validated in the earlier HLNA prototype.
- Keep the interface clean and configurable rather than using a sci-fi/JARVIS visual style.

## Stage 3 — shared assistant services

- Central orchestrator with on-demand specialist capabilities: research, coding, files/documents, project work, learning, and desktop interaction.
- Shared model/runtime manager with bounded parallelism and resource awareness.
- Project-scoped memory, conversation memory, document retrieval, and inspect/edit/export controls.
- Use mature upstream services through local APIs, MCP, SDKs, or plugins where possible.

## Stage 4 — permissioned computer interaction and automation

- Central permission broker; tools and plugins cannot bypass it.
- Preview sensitive actions; require approval for destructive or external actions.
- Audit log records the actor, action, target, and outcome.
- Cancellation, checkpoints, undo/recovery, and safe path boundaries.
- Visible, pausable desktop observation; no hidden screen, camera, or microphone recording.
- Workflow templates, schedules, event triggers, and user-reviewed automation.

## Stage 5 — reliability and distribution

- Backup/restore, portable data export, revocable integrations, and independent module disable switches.
- Gaming/resource-aware mode that pauses nonessential background AI workloads.
- Windows x64 and CachyOS/Arch x86_64 first; ARM64 and macOS later.
- Fresh-install testing on clean Windows and CachyOS virtual machines before calling a release stable.

## Release gates

A release is not considered stable merely because it compiles. It must at minimum:

1. Install on a clean supported OS without developer prerequisites.
2. Launch and shut down reliably.
3. Complete local-only chat without requiring a cloud account.
4. Show clear status when the local model runtime or selected model is unavailable.
5. Stop generation promptly and preserve conversation history across restart.
6. Keep sensitive tool actions behind visible permission prompts.
7. Keep app data and project memory local unless the user explicitly enables a remote service.
8. Include upstream notices and a reviewable dependency/license inventory.
