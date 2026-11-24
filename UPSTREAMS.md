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

