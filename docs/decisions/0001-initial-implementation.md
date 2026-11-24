# ADR 0001: Initial desktop foundation

**Status:** Selected for the first implementation baseline  
**Date:** 24 November 2026  
**Scope:** HLNA_v3 only  
**Decision owner:** User delegated the initial architecture choices to the project agent

## Decision

Start HLNA_v3 from the **Jan v0.8.8 desktop application source**, obtained directly from the Jan upstream repository. HLNA_v2 is reference only; do not copy its code into v3.

Use the following initial shape:

- **Desktop foundation:** Jan v0.8.8, which provides a Linux/Windows desktop app, chat, history, model providers, and an existing Tauri/Rust host.
- **Local model runtime:** the user's existing **Ollama** service, through its loopback API. Use one runtime and one active generation at a time by default.
- **Model settings:** keep the historical Qwen 2B / 16K experience as a benchmark; use 16K as the initial context default with a 4K–16K setting range, subject to verification with the selected Jan/Ollama combination.
- **Local storage:** use Jan's existing SQLite storage only after confirming it can be rooted in a separate HLNA data directory. Do not import, inspect, migrate, or modify data from HLNA v1, HLNA v2, or an existing Jan installation.
- **Orchestrator:** begin with Jan's existing desktop chat/agent loop to avoid rebuilding it. Add HLNA's policy checks at the trusted Rust host boundary.
- **Permission broker:** create an HLNA-owned Rust broker in the trusted desktop host. Default to deny. Do not expose Jan's direct MCP, shell, extension, or API tool execution until every enabled action has passed through this broker.
- **Resource management:** keep the first version simple: one runtime, bounded inference, explicit cancellation, and unloading/queuing through the runtime. Do not add a background resource-manager service yet.
- **Deployment:** one modular desktop app plus the user's existing local model service. Start and validate on CachyOS/Arch Linux; keep Windows support in the design and add a Windows build/validation gate.
- **Bundled Jan model engine:** do not use it as the initial runtime. First establish a clean Jan baseline. Then check whether it can be omitted from the HLNA package while Ollama chat still works. If not, measure the package cost and revisit the desktop foundation before release.

## First implementation stages

1. **Upstream baseline:** fetch the exact Jan v0.8.8 tag, preserve its license/attribution, build and launch it unmodified in an isolated profile. Do not import any HLNA_v2 source.
2. **Identity and isolation:** set an HLNA application name, bundle identifier, and data directory. Prove the app cannot read or alter Jan/v1/v2 profiles. Disable Jan analytics, updater, local API listeners, and direct tools unless a documented v3 need requires one.
3. **Local chat:** connect only to the user's Ollama loopback endpoint. Verify streaming, stop/cancel, history, 16K context behavior, and clear errors when Ollama is unavailable.
4. **Permission core:** add deny-by-default broker logic in the trusted host. Add tests for unknown actions, scopes, approval decisions, cancellation, audit records, and attempts to call tools outside the broker.
5. **One controlled tool:** expose one narrow read-only operation through an HLNA broker bridge. Keep Jan's other built-in tools, arbitrary MCP servers, shell, external writes, and computer control disabled.
6. **Platform and release checks:** validate clean Linux install/launch, then Windows build/launch; review package size, dependencies, bundled assets, licenses, and local-only behavior.

## Required stop gates

Do not continue to broad feature work unless:

- The untouched Jan baseline builds and starts on the development platform.
- A clean HLNA profile is isolated from Jan and HLNA v1/v2 data.
- No unapproved remote or analytics traffic occurs.
- Local Ollama chat works without starting a second model engine.
- Every enabled tool execution is checked by the HLNA broker, and all other tool paths are disabled.
- The baseline hardware remains responsive.

If Jan cannot meet the identity, privacy, package-size, or broker requirements without major invasive changes, stop and compare Option C in [ARCHITECTURE_OPTIONS.md](../ARCHITECTURE_OPTIONS.md): a small HLNA desktop with focused reuse.

## Why this direction

Jan is the strongest existing desktop candidate found so far: it already provides the interface and connects to OpenAI-compatible local providers such as Ollama. This follows HLNA's reuse-first requirement and avoids building a new chat application before proving a genuine gap.

The main risks are its bundled model engine, large release packages, and multiple ways to execute tools. The staged gates above make those risks visible before broad adoption. This is a reversible starting direction; it is not a claim that Jan is suitable for a public HLNA release.

## Decisions deliberately deferred

- Whether to remove the bundled Jan model engine from HLNA builds.
- Whether Jan remains the final desktop base after baseline and broker checks.
- Full memory/document retrieval and vector search.
- Voice, desktop observation, computer control, workflows, plugin marketplace, sync, and the Arch distribution.
- HLNA's own project license.
- Windows release packaging details.

