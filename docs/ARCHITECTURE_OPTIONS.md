# HLNA_v3 — Preliminary Architecture Options

**Status:** Research recommendation only; no architecture or framework is approved  
**Date:** 24 November 2026  
**Scope:** HLNA_v3

This document compares practical shapes for the first HLNA_v3 release. It does not approve an implementation or carry HLNA_v2 decisions into v3.

## What the architecture has to do

The first useful version should offer local chat while leaving room for the larger HLNA vision. The design must:

- Work on ordinary CachyOS/Arch Linux and Windows installs.
- Keep cloud use optional and easy to identify.
- Have one main orchestrator and one central permission broker.
- Avoid loading several models or running unnecessary AI services at once.
- Keep chat and project data under the user's control.
- Allow the desktop app, model runtime, and later specialist features to be replaced independently.
- Reuse existing software where it meets these needs.

## Three practical options

| Option | How it works | Benefits | Main costs and risks |
|---|---|---|---|
| **A. Adapt a complete desktop app such as Jan** | Use an existing desktop assistant for chat and settings. Put HLNA's own permission and resource rules in its trusted host layer. Connect one model runtime, likely Ollama, through its documented provider interface. | Reuses a working desktop experience and provider connections. Jan supports Linux and Windows and its docs show Ollama-compatible endpoints. This is the best match to the reuse-first goal so far. | Jan's standard release bundles a llama.cpp model engine; v0.8.8 downloads are large. A custom build might omit that engine, but this is unverified. Its built-in agents, MCP connectors, shell and other tool paths need a full audit and may need to be disabled or changed so all actions go through HLNA's broker. |
| **B. Run a complete chat app beside an HLNA broker** | Use an existing app such as AnythingLLM or LibreChat for chat, with a separate HLNA service as the only approved tool connection. | Could reuse more complete features and make an early chat demo quicker. | The app may expose its own tools directly, so those paths must be disabled. Users would see two parts of the product. LibreChat's standard setup runs multiple supporting services; AnythingLLM has its own server and agent system. Extra services use memory and create more setup and update work. |
| **C. Build a small HLNA desktop and reuse focused components** | Create a thin user interface and trusted core, using established runtimes and libraries behind clear interfaces. | HLNA controls the permission boundary, app identity, and resource behavior directly. It avoids adopting a broad app with features HLNA does not want yet. | Requires more HLNA code and long-term UI maintenance. This risks rebuilding solved chat features if a suitable existing desktop foundation can be adapted safely. |

## Working recommendation

**Evaluate Option A first, with Option C as the fallback.** Jan currently appears to be the strongest desktop candidate because it already has desktop chat and can connect to Ollama. This recommendation is based on the current v3 requirements and Jan's current documentation; Jan's earlier use in v2 is only historical context.

Before choosing Jan, answer two questions:

1. Can v3 build and package Jan without shipping a second model engine, while preserving ordinary chat and Ollama connection behavior?
2. Can every action-capable path be disabled or routed through the HLNA permission broker?

If either answer is no, compare a thin HLNA desktop with focused reuse. Running a complete chat app beside a separate broker remains a prototype option, not the preferred product shape.

## Proposed component boundaries

These are responsibilities to compare, not a commitment to a language or framework:

- **Desktop app:** chat, history, settings, permission prompts, and status.
- **Trusted HLNA core:** one orchestrator, the permission broker, runtime selection, resource limits, audit events, and local service coordination.
- **Model runtime:** one local inference service at a time. Ollama is the leading candidate because it is already installed and has prior user test history. Jan's bundled engine is an alternative if its integration is better and the additional package size is acceptable.
- **Local data:** conversation and project data stored locally, with ownership and export/delete controls. Reuse an upstream data store only after checking its paths, migrations, and licence.
- **Optional workers:** document parsing, speech, or desktop interaction should start only when needed and only after their permissions and resource costs are understood.

Prefer in-process coordination for simple events and tasks at first. Add separate services only where isolation or an existing upstream makes the added memory and setup worthwhile.

## Permission and safety boundary

An approval popup, a rule checker, and an operating-system sandbox solve different problems:

1. The **popup** explains an action and asks the user.
2. The **permission broker** checks the requesting component, action, target, scope, user policy, and approval before the action runs.
3. The **sandbox** limits what a process can reach if a tool is faulty or misused.

The broker must run in a trusted host and check every enabled tool route. A UI prompt alone is insufficient. MCP (a standard way for AI apps to connect tools) is a connection format, not a safety guarantee. Direct connectors, shell tools, plugins, workflows, local API servers, and desktop-control paths must be disabled or pass through the same broker.

For the first release, the safest working scope is chat only until the broker has tests for permission checks, cancellation, and logging. Add one limited read-only tool only after those checks pass. Destructive or external actions need specific user approval.

## Model and resource plan to evaluate

- Use one model runtime and one model workload at a time by default.
- Compare Jan's bundled engine with the user's existing Ollama service. Do not run both merely because both are available.
- Keep model loading, unloading, queueing, and cancellation visible and controlled by the resource manager.
- Defer unnecessary background work. Check CPU/RAM/GPU/VRAM before adding voice or document workers.
- Treat the Qwen 2B / 16K test from the v2 handoff as a useful baseline to repeat, not a guarantee for every task.

## Main unresolved checks

| Check | Evidence needed |
|---|---|
| Jan engine-free build | Reproducible build and package check showing the engine is omitted and chat with Ollama still works |
| Jan permission paths | Trace every Desktop tool, MCP, shell, extension, and local-server path in the selected source revision |
| Local-only behavior | Confirm a fresh setup makes no remote requests except user-enabled updates/model downloads/providers |
| Windows parity | Build and run the selected shell/runtime path on Windows, not only Linux |
| Baseline hardware | Measure package size, idle memory, one active model, and behavior while the GPU is busy |
| Data ownership | Confirm app data roots, migrations, backup/export, and delete behavior are isolated to HLNA |

No v3 application has been built or benchmarked as part of this comparison. The Phase 0 exit gate in [PHASE_0_DISCOVERY_PLAN.md](PHASE_0_DISCOVERY_PLAN.md) still applies.

### Additional Jan action-path concern

Current Jan Desktop has more than the visible chat approval card: its local API can execute MCP tools server-side when that setting is enabled, and the app can launch MCP servers and extensions. These settings are disabled or require user configuration in some paths, but v3 must either remove those paths or route their actions through the same broker. Keep the API server disabled until this is reviewed. See the [upstream register](../UPSTREAMS.md) for the source notes.

## Local data storage candidate

For a first release aimed at one person using one desktop, **an embedded local database such as SQLite is the leading storage candidate**. It runs inside the application, stores data in a local file, and does not need a separate database server. SQLite supports Linux and Windows and is public-domain software. It allows many readers but only one writer at a time, which is usually manageable when app writes are short.

A PostgreSQL service is better suited to many concurrent client connections or shared server use, but adds a long-running database process and setup work. The v3 plan does include eventual multi-user and self-hosted use; that does not require a database server for the first release if the storage interface leaves room to change later.

If Jan remains the desktop candidate, inspect its SQLite schema, migrations, project separation, and backup/export paths before selecting storage. Reuse compatible existing storage rather than adding another database. Do not select a vector-search add-on until document retrieval is part of the agreed first-release or next milestone.

