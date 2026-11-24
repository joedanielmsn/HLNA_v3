# Upstream Projects and Integration Register

## Policy

HLNA follows a reuse-first development strategy:

- Prefer mature, maintained open-source applications and services that already solve substantial parts of the product.
- Prefer integrating a complete upstream application where practical instead of rebuilding its functionality.
- Use supported APIs, SDKs, MCP, plugins, and stable service interfaces.
- Keep HLNA-specific code focused on integration, orchestration, permissions, resource management, compatibility, and genuine product gaps.
- Evaluate maintenance health, security, licence compatibility, platform support, resource requirements, extension points, and long-term sustainability.
- Pin exact releases or commits only after a component is selected for a concrete integration.
- Preserve attribution, copyright notices, and all applicable upstream licence obligations.

## Current selection status

**No upstream application or runtime is currently approved as the foundation of HLNA v3.** Previous prototypes and candidate evaluations are historical research, not binding architecture decisions. Re-evaluate candidates against the current master plan before adopting them.

## Evaluation register

Add entries here as research is performed. For each candidate, record:

| Field | What to record |
|---|---|
| Project | Name and canonical upstream URL |
| Role | Capability it may provide |
| Maintenance | Recent releases, activity, issue response, governance |
| Integration | API, SDK, MCP, plugin, service, or source-level integration |
| Platforms | Linux and Windows support, packaging |
| Resources | CPU, RAM, GPU/VRAM and background overhead |
| Security | Isolation, permissions, update and supply-chain practices |
| Licence | Project and relevant dependency/model licence terms |
| Decision | Adopt, evaluate further, defer, or reject—with rationale |
| Pin | Exact version/commit once selected |

## Integration rules

- Do not copy or fork large codebases without a clear technical reason.
- Prefer narrow adapters and upstream-supported extension points.
- Avoid tightly coupling HLNA to replaceable providers.
- Do not bundle cloud credentials, private user data, or model weights.
- Audit transitive dependencies and bundled assets before redistribution.
- Treat model-weight and dataset licences separately from application-code licences.


## Preliminary evaluations — 24 November 2026

These are research findings for HLNA_v3. None is approved for adoption. HLNA_v2 documents are historical context only; no code has been taken from HLNA_v2.

| Project | Useful evidence for HLNA_v3 | Open concern | Current status |
|---|---|---|---|
| [Jan](https://github.com/janhq/jan) | Apache-2.0 desktop app; current docs show Windows and Linux builds, local chat, projects, model providers, MCP, and OpenAI-compatible custom endpoints including Ollama. The v0.8.8 release was published 28 Oct 2026. | Since v0.8.5 the app bundles a llama.cpp engine in a worker. The v0.8.8 Linux .deb was about 1.0 GB and Windows installer about 545 MB. It also includes agent and tool features that need a complete broker-path audit. Its privacy docs describe optional analytics consent; HLNA's defaults must be independently checked. | **Evaluate further; strongest desktop foundation candidate so far, not selected.** Check whether a v3 build can avoid bundling a second runtime, and inspect all tool paths before considering adoption. |
| [Ollama](https://github.com/ollama/ollama) | MIT-licensed local service with Linux and Windows support, a local API, model loading/unloading, queue limits, and settings for loaded models and concurrent requests. The user already has it installed and has prior experience with a small local model. | Check actual v3 integration, resource behavior on the target machine, and whether Ollama or Jan's bundled engine should own inference. Do not assume a past model/context result guarantees quality for all tasks. | **Evaluate as the leading runtime candidate; not selected for v3.** |
| [llama.cpp](https://github.com/ggml-org/llama.cpp) | MIT-licensed inference engine with CPU/GPU options and a server API. Jan's bundled engine uses it; it can also be run as a separate service. | More runtime lifecycle and model-management work may fall to HLNA if used directly. Compare the burden against Ollama and the Jan integration. | **Runtime alternative; evaluate only if it solves a measured need.** |
| [AnythingLLM](https://github.com/Mintplex-Labs/anything-llm) | MIT-licensed app with Linux/Windows desktop builds, multiple model providers, documents, agents, and MCP support. | A broad app with its own frontend/server architecture and direct agent/MCP capabilities. Confirm whether tools can be constrained behind HLNA's broker and measure the extra footprint before considering it as a foundation. | **Comparison/reference candidate; not selected.** |
| [LibreChat](https://github.com/LibreChat-AI/LibreChat) | MIT-licensed self-hosted chat; supports Ollama and has configurable tool-approval policies for agents. | Its standard container setup includes several supporting services and recommends at least 2 GB of container memory. Approval inside the chat app is not by itself HLNA's central enforcement point. | **Comparison/reference candidate; not selected.** |
| [LocalAI](https://github.com/mudler/LocalAI) | MIT-licensed local API with several model backends and broader modality/agent features. | Broader than the chat-first v3 target. Check whether its extra services and tools add value beyond a simpler Ollama connection. | **Runtime alternative; defer unless requirements justify it.** |
| [Open WebUI](https://github.com/open-webui/open-webui) | Broad web chat and model-provider support. | Its current license requires retaining its branding in many deployments; the project's own license page says versions after v0.6.5 are not OSI-approved. This may not fit a separately branded HLNA application. | **Reference only unless a license-compatible use is identified.** |

### Current research direction

For the next comparison, focus on **Jan as a desktop candidate and Ollama as a runtime candidate**, while checking whether one-runtime use is practical. Jan's bundled engine may be useful, but it can overlap with the user's existing Ollama setup and has a large installer footprint. Do not select both as parallel inference systems without a measured reason.

Jan's built-in approval screens or another app's approval screens must not replace the HLNA permission broker. The source and configuration audit must show that every file, shell, desktop, network, plugin, MCP, and workflow action is either disabled or enforced by the same trusted broker.

### Primary references

- Jan: [README and platform/build notes](https://github.com/janhq/jan), [v0.8.8 release](https://github.com/janhq/jan/releases/tag/v0.8.8), [custom endpoints](https://docs.jan.ai/desktop/remote-models/custom-endpoint), [llama.cpp engine](https://docs.jan.ai/desktop/local-engine/llama-cpp), [privacy](https://docs.jan.ai/desktop/privacy).
- Ollama: [Windows support](https://github.com/ollama/ollama/blob/main/docs/windows.mdx), [model memory and concurrency controls](https://github.com/ollama/ollama/blob/main/docs/faq.mdx).
- llama.cpp: [project and license](https://github.com/ggml-org/llama.cpp), [server documentation](https://github.com/ggml-org/llama.cpp/blob/master/tools/server/README.md).
- AnythingLLM: [project README and license](https://github.com/Mintplex-Labs/anything-llm), [MCP desktop documentation](https://docs.anythingllm.com/mcp-compatibility/desktop).
- LibreChat: [tool approval configuration](https://www.librechat.ai/docs/configuration/librechat_yaml/object_structure/agents), [local deployment requirements](https://github.com/LibreChat-AI/docs/blob/main/content/docs/local/docker.mdx).
- LocalAI: [official overview](https://github.com/mudler/LocalAI/blob/master/docs/content/overview.md).
- Open WebUI: [official license guidance](https://docs.openwebui.com/license/).



## Permission and isolation research — 24 November 2026

These candidates solve different parts of the safety problem; none is a complete HLNA permission broker.

| Candidate | What it may help with | Limit / next check | Status |
|---|---|---|---|
| [Cedar](https://github.com/cedar-policy/cedar) | Apache-2.0 policy language and Rust evaluator. It can answer whether a request matches rules written by the application. | It does not itself control tools, identify trusted callers, ask the user, limit filesystem access, or execute actions. A trusted HLNA host must still build the request, enforce the decision, and audit the result. Compare its dependency and policy-authoring cost with simple rules for the first release. | **Evaluate as an optional policy engine; do not adopt yet.** |
| [cap-std](https://docs.rs/cap-std/latest/cap_std/) | Rust APIs that make code access files through an explicitly granted directory handle instead of unrestricted global paths. | Helps constrain HLNA code that uses the API; does not sandbox arbitrary child processes or replace OS enforcement. Check how it handles the paths and file operations HLNA actually needs. | **Candidate for scoped file access if Rust is selected.** |
| [Linux Landlock](https://www.kernel.org/doc/html/latest/userspace-api/landlock.html) | Linux kernel interface for restricting a process's file and network access without root privileges. | Linux-specific; some restrictions do not apply to files opened before sandboxing. Windows needs a different mechanism. Test on the supported CachyOS kernels before relying on it. | **Linux sandbox candidate; not a cross-platform broker.** |
| [Tauri 2 capabilities](https://v2.tauri.app/security/capabilities/) | If the desktop uses Tauri, limits which native commands the frontend can call and with what scopes. | Protects the webview-to-host boundary; it does not by itself enforce policy for every agent, MCP server, plugin, or automation. | **Framework-specific defense layer; evaluate only if Tauri remains a candidate.** |
| [Jan Desktop MCP approvals](https://docs.jan.ai/desktop/mcp) | Current Jan desktop docs describe per-call user approval for MCP tools and a setting that can pre-approve all MCP tools. Jan also documents OS sandboxing for its desktop shell. | A user prompt and a sandbox are useful, but they do not prove every path goes through an HLNA-owned broker. The Jan CLI/Agent permission documentation describes a separate surface; do not assume its rules apply to Desktop. Audit the selected release's complete desktop tool paths. | **Useful design reference; not the HLNA broker.** |

### Safety model to evaluate for HLNA

Treat these as three separate jobs:

1. **User prompt:** shows the user the action and collects a yes/no decision.
2. **Central broker:** checks who asked, what they want to do, which file/app/service it affects, and whether policy allows it. It records the result and can cancel or revoke access.
3. **Operating-system sandbox:** limits what a process can reach even if the model, prompt, or application has a bug.

The central broker remains required. A library such as Cedar may help with step 2, but the broker itself must enforce the decision before the operation runs. Sandboxes help contain the effect; they are not substitutes for user-visible, revocable permissions.



### Jan engine packaging question

The Jan v0.8.8 source gives a useful clue, but not a proven solution:

- The `tauri-plugin-llamacpp` crate declares its native `engine` feature off by default.
- The normal upstream `make build` target explicitly runs `build-engine`, which compiles the llama.cpp worker.
- Jan's release notes and engine docs describe that worker as bundled with the desktop installer.

A custom HLNA build might be able to omit that worker and use Ollama through Jan's custom-provider interface, but the normal build instructions do not prove that the packaged desktop app still builds, runs, and handles errors correctly without it. Record this as an **open validation item**. Do not promise a smaller Jan-based HLNA package until a reproducible build confirms it.

Primary references: [Jan plugin manifest at v0.8.8](https://github.com/janhq/jan/blob/v0.8.8/src-tauri/plugins/tauri-plugin-llamacpp/Cargo.toml), [Jan app features at v0.8.8](https://github.com/janhq/jan/blob/v0.8.8/src-tauri/Cargo.toml), [Jan build target](https://github.com/janhq/jan/blob/v0.8.8/Makefile), [Jan engine documentation](https://docs.jan.ai/desktop/local-engine/llama-cpp).



### Jan Desktop action paths — source and documentation review

Jan Desktop has several ways that actions can reach tools. They must be checked separately before adopting it:

1. **Chat MCP tools:** Jan documents an approval card for each call, but it also offers an “Allow All MCP Tool Permissions” setting. HLNA would need to keep broad approval off and make the broker the actual enforcement point.
2. **Local API server:** Jan documents `/v1/orchestrations` and optional server-side MCP execution through `/v1/chat/completions`. The server-side tool setting is disabled by default, but when enabled the local server executes MCP tools. HLNA should keep this API off by default or ensure all enabled calls go through the broker. If enabled, keep it bound to loopback, require an API key, and review trusted-host/CORS settings.
3. **Built-in agent tools and shell:** Jan's current docs describe file and shell tools, with the desktop shell using an OS sandbox. This is a useful layer, but each built-in tool and command path still needs to be mapped to HLNA's broker.
4. **MCP servers and extensions:** MCP servers may launch separate programs, and extensions have their own host permissions. For v3, do not allow direct tool servers or extension host calls around the broker.

Jan's v0.8.8 notes describe path checks, local API host protections, and a separate opt-in for server-side MCP execution. These are positive signs, not proof of HLNA's requirement: the selected v3 build would need a full path audit and tests. Jan Desktop's permissions must not be confused with Jan CLI/Agent permissions.

References: [MCP approvals](https://docs.jan.ai/desktop/mcp), [Local API server settings](https://docs.jan.ai/desktop/api-server), [v0.8.8 security notes](https://github.com/janhq/jan/blob/main/docs/src/pages/changelog/2026-10-28-jan-v0.8.8.mdx), [Jan Desktop action host source](https://github.com/janhq/jan/tree/v0.8.8/src-tauri/plugins/tauri-plugin-agent-tools).



## Local data storage — preliminary comparison

| Option | Fit for first single-user desktop release | Trade-off | Status |
|---|---|---|---|
| [SQLite](https://sqlite.org/whentouse.html) | One local file, no database server to install or run, works on Linux and Windows, and supports transactions. | Only one writer at a time per database file. The app should keep writes short and use a documented backup method. | **Strong local-storage candidate; not selected.** |
| PostgreSQL | Client/server database with more support for many concurrent clients and writers. | Requires a separate server process and administration. That adds setup and background resource use before v3 needs multi-user/server deployment. | **Defer unless multi-user or concurrent server use becomes an initial requirement.** |
| JSON or many separate files | Simple for small settings and portable exports. | More custom code is needed for safe multi-record updates, queries, recovery, and consistency. | **Use for small config only where appropriate; not the main conversation store by default.** |

HLNA_v2 research says Jan already uses local SQLite components. If Jan is evaluated as the v3 desktop base, first inspect its existing data model and backup/migration behavior. Avoid adding a second database or vector store without measured evidence.

References: [SQLite overview and licensing](https://www.sqlite.org/about.html), [when to use SQLite](https://www.sqlite.org/whentouse.html), [PostgreSQL architecture](https://www.postgresql.org/docs/current/tutorial-arch.html).

