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

