# HLNA_v3 — Phase 0 Discovery Plan

**Status:** Working discovery plan; architecture and technology decisions remain open  
**Date:** 24 November 2026  
**Scope:** HLNA_v3 only

> HLNA_v3 is starting from a clean planning baseline. HLNA_v2 is historical reference only. Its code and technology decisions are not being carried into v3 automatically.

## Purpose

Turn the requirements in [MASTER_PLAN.md](MASTER_PLAN.md) into a practical first release and a reviewed architecture before product implementation begins. HLNA should reuse mature software where it fits, while keeping its own permission, resource, and integration rules under HLNA's control.

This document is a work plan, not an architecture approval or a decision to adopt any listed project.

## What guides v3

The current [master plan](MASTER_PLAN.md) and [product plan](PRODUCT_PLAN.md) are authoritative for HLNA_v3. They establish:

- Local-first operation, with cloud use optional and explicit.
- Linux and Windows as the first platform targets; start on CachyOS/Arch Linux.
- One central orchestrator, with specialist capabilities used when needed.
- A central permission broker and hardware-aware resource manager.
- Reuse of maintained upstream software where it fits.
- Visible, revocable permissions; no hidden screen, camera, or microphone monitoring.
- A free/open-source project goal. The project licence remains deliberately undecided.
- The initial hardware baseline of an RTX 3050 with 4 GB VRAM and 16 GB RAM.

The [HLNA_v2 handoff](https://github.com/joedanielmsn/HLNA_v2/blob/main/HLNA_V2_DEVELOPMENT_PLAN.md) and component research are useful background. They record earlier work with Jan, Ollama, Tauri, Rust, React, and other candidates. Treat those as past v2 choices or experiments—not v3 decisions. No v2 code is to be copied into v3 as part of this discovery work.

## Proposed first usable release

Use this as the working target while researching; confirm it at the Phase 0 review:

- A small desktop chat experience with conversation history and basic settings.
- Local inference as the normal path, with a replaceable connection to a model runtime.
- Clear status when a model is unavailable, and a way to stop a response.
- A local-only mode that does not send chat data to cloud services.
- A central permission broker and resource manager designed into the architecture.
- No computer-control tools enabled until every action can be checked by the permission broker.

Voice, background observation, broad desktop control, learned workflows, plugin marketplaces, sync, and the custom Arch distribution remain later-stage work. Research their requirements and dependencies, but do not let them make the first release unnecessarily large.

## Research plan

### 1. Finalise the first-release requirements

Group the master-plan requirements into:

1. Foundations needed for every stage.
2. The first usable release.
3. Later assistant capabilities.
4. The long-term Arch distribution.

For each first-release item, define a simple way to tell whether it works. Keep proposed scope separate from confirmed requirements.

### 2. Check the real hardware and model baseline

Confirm the machine details that affect the design, especially the reported CPU model. Use the existing local model experience as a reference point: the v2 handoff records a Qwen 3.5 2B model at 16K context on the RTX 3050. Recheck actual memory use and answer quality before treating that as an HLNA_v3 guarantee.

Do not set performance targets by guesswork. Measure candidate runtimes and background services on the baseline hardware.

### 3. Compare upstream candidates

Start with the projects most relevant to the first release:

| Capability | Candidates to compare | Main questions |
|---|---|---|
| Desktop chat foundation | Jan, AnythingLLM, LibreChat, and a focused HLNA shell | Can it run on Linux and Windows? Can it be adapted without importing unwanted services or tool paths? Does its licence fit HLNA's goals? |
| Local model runtime | Ollama, llama.cpp, LocalAI | How easy is it to connect, stop, load, unload, and limit? What happens when VRAM is low or the GPU is busy? |
| Permission broker | HLNA-owned broker design; relevant Jan/v2 research as reference | Can every tool request be checked in one trusted place, even if it comes from a plugin or workflow? |
| Memory and documents | Existing local database options, Jan's prior RAG work as a reference, document-processing candidates such as Docling | Can users inspect, edit, export, and delete stored data? Are document sources traceable? What is the CPU/RAM cost? |
| Later capabilities | Computer-use, offline voice, workflow engines, plugin runtimes | Which should wait? What permission, platform, maintenance, and hardware limits would each add? |

For every candidate, check current maintenance, supported interfaces, Linux/Windows support, security and privacy behavior, CPU/RAM/GPU use, dependency footprint, and licence. Check model-weight licences separately from application-code licences.

### 4. Compare architecture choices

Describe how the following parts fit together, without choosing a programming language or framework before the comparison:

- Desktop interface.
- Central orchestrator.
- Permission broker.
- Resource manager and model runtime.
- Conversation and project data.
- Integrations and optional specialist workers.

Compare a small modular application with other realistic options. Prefer the simplest design that meets the requirements; do not split components into separate background services without a clear reason.

The permission broker must be an actual enforcement point in a trusted host. A chat application's confirmation dialog can help the user, but it cannot be the only security check. Tools that can change files, run commands, control applications, or contact outside services must not have a path around the broker.

### 5. Record the recommendation and remaining questions

For each major choice, record the requirement, candidates, evidence, trade-offs, recommendation, risks, and what would make us change the decision. Add significant decisions under `docs/decisions/` and keep evaluated upstreams in [UPSTREAMS.md](../UPSTREAMS.md).

## Evaluation checklist

Use the same checklist for each candidate:

- Does it meet a real v3 requirement?
- Is the project actively maintained?
- Does it work on the platforms we need?
- Can HLNA connect through a documented API, SDK, plugin, or other stable interface?
- Can privileged actions be made to pass through HLNA's permission broker?
- Does it work with local data and explicit cloud settings?
- What background CPU, RAM, GPU, and VRAM does it use?
- What extra services, downloads, or dependencies does it need?
- What licence applies to the code, bundled assets, and models?
- Can HLNA replace it later without a full rewrite?

Popularity by itself is not enough reason to select a project.

## Work sequence and deliverables

1. **Requirements map:** priorities, dependencies, and proposed first-release checks.
2. **Hardware note:** confirmed baseline and measured limits from candidate evaluation.
3. **Upstream comparison:** candidates, evidence, trade-offs, and adopt/evaluate/defer/reject status in `UPSTREAMS.md`.
4. **Architecture comparison:** module boundaries and how permissions, resources, data, and integrations fit together.
5. **Decision records:** reasons for important choices and alternatives considered.
6. **Phase 0 review:** a plain-language recommendation and the few remaining decisions that need the product owner's input.

## Phase 0 exit gate

Do not begin broad product implementation until review has produced:

- An agreed first-release scope and measurable checks.
- An agreed architecture and integration strategy.
- A documented permission path for every privileged action.
- A resource-management approach suited to the baseline hardware.
- Defined boundaries for conversation, project, and integration data.
- Upstream selections with alternatives, licence notes, and replacement reasons.
- A staged implementation plan with tests and safety checks.
- A licensing review plan for architecture finalisation and public release.

## Known history and limits

The v2 handoff describes useful tests and plans, but they belong to v2. They are evidence to consider, not proof that the same result holds in v3. This discovery work has not built, installed, or benchmarked a v3 application. No technology or upstream is selected by this document.


## Preliminary research result — 24 November 2026

A first check of current upstream documentation narrows the next evaluation:

- **Jan is the strongest desktop candidate so far.** It has chat, history/projects, model providers, and works with Ollama through an OpenAI-compatible endpoint. Its current app also bundles a llama.cpp engine, so v3 must compare the cost of using that engine with using the user's existing Ollama service. The v0.8.8 release assets are large: about 1.0 GB for the Linux .deb and 545 MB for the Windows installer. This is a real concern for a lightweight platform.
- **Ollama is the strongest runtime candidate so far.** It is already installed for the user and offers controls for model loading, unloading, queueing, and concurrency. Treat the previous small-model/16K-context test as useful past evidence, not an HLNA_v3 guarantee.
- **AnythingLLM and LibreChat remain useful comparisons**, but both provide their own agent/tool features. We must determine whether those can be fully disabled or routed through the HLNA broker. LibreChat's standard container setup also runs supporting services, which adds memory use.
- **Open WebUI is not a leading code-foundation candidate** because of its current branding condition. Keep it as a feature reference unless a suitable license-compatible use is found.
- The next source-level review should focus on Jan's current tool paths, data paths, telemetry defaults, and whether its bundled inference engine can be excluded safely. Do not rely on UI approval prompts alone.

**Working recommendation, not an architecture decision:** compare a Jan-based desktop with Ollama as the external runtime against Jan using its own bundled runtime. Keep all privileged tools disabled until the trusted HLNA broker can mediate them. If Jan cannot fit the v3 security, size, or maintenance needs, compare a smaller HLNA shell that reuses suitable components rather than adopting a full chat stack automatically.

This review used upstream documentation and release information. No application was installed, built, benchmarked, or adopted.


### Permission and sandbox findings

Keep three ideas separate in the comparison:

- **Approval prompt:** what the user sees and answers.
- **Permission broker:** the central checker that decides whether an action is allowed and records it.
- **Sandbox:** an operating-system limit on what a running tool process can access.

Jan Desktop's current MCP docs show individual tool-call approval and an option that pre-approves all MCP tools. That is useful reference behavior, but a prompt inside Jan is not proof that every v3 tool path goes through HLNA's broker. Jan's CLI/Agent permission guide is a separate surface from Desktop and must not be treated as the Desktop security model.

Cedar may help write and evaluate permission rules; it does not run tools or enforce OS file boundaries by itself. Linux Landlock and Rust cap-std may help limit file access, but each covers a different layer and neither is a complete Linux/Windows broker. Tauri capabilities are only relevant if Tauri remains a framework candidate.

**Working safety requirement:** every enabled tool route must either be disabled or call the trusted HLNA broker before acting. The OS sandbox should further limit tool access where supported. Review how the broker, prompt, and sandbox work together before choosing a framework or enabling computer-control tools.

