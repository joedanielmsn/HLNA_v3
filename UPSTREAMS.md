# Upstream components

HLNA follows a reuse-first policy: use an upstream application as a complete working base when it already solves a substantial part of the problem, then add narrowly scoped HLNA integrations.

## Desktop foundation: Jan

- Project: https://github.com/janhq/jan
- Pinned revision: `49a84bdeaebdfc0f36c00f252eb638f516a48432`
- Upstream version at the pinned revision: `0.8.8`
- License: Apache-2.0 (retain upstream notices and attribution)
- Why selected: native Tauri desktop application; local llama.cpp inference; OpenAI-compatible custom endpoints; assistants, projects, MCP connectors, and agent workflows; Windows installer and Linux AppImage build targets.
- Build entry points used by CI: `yarn build:tauri:win32` and `yarn build:tauri:linux`.

The selected revision is deliberate: it is the clean Jan baseline already used in earlier HLNA development work. CI checks out this exact commit rather than following a moving upstream branch.

### Current limitations to resolve

1. The initial build keeps Jan's upstream UI/identity visible. HLNA-specific branding must not remove attribution or violate upstream terms.
2. Jan's documented GPU recommendation is 6 GB VRAM. HLNA's 4 GB test machine must be supported through a suitable small model and/or the existing Ollama runtime; do not assume Jan's bundled local inference path will use that GPU successfully.
3. The build does not include model weights. A first-run model/runtime setup is a separate integration milestone.
4. The upstream auto-updater must be reviewed before any branded fork or redistributed build is considered production-ready. Do not point it at an unsigned HLNA release.
5. The full transitive dependency and bundled-engine license inventory remains a release gate.

## Candidates for later integration (not bundled yet)

| Project | Potential role | Decision |
|---|---|---|
| Ollama — https://github.com/ollama/ollama | Existing local model runtime and model management | First integration target; preserve the user's proven small-model workflow and avoid requiring a second inference engine |
| AnythingLLM — https://github.com/Mintplex-Labs/anything-llm | Document ingestion, RAG, workspace knowledge, agent flows | Evaluate as a service/module behind a clear interface; MIT-licensed upstream, but its separate desktop distribution is not assumed to be the host |
| Open WebUI — https://github.com/open-webui/open-webui | Alternative chat/workspace interface and tools | Do not merge blindly; its current licensing/branding conditions need a dedicated review |
| n8n — https://github.com/n8n-io/n8n | Visual workflow automation | Not selected for direct bundling: its Sustainable Use License is not a conventional OSI open-source license |

## Integration rules

- Pin every upstream commit or release used in a build.
- Keep upstream license files, copyright headers, and required notices.
- Prefer official APIs, MCP, plugin SDKs, and local HTTP interfaces over copying source files.
- Do not bundle cloud credentials, model weights, or user data.
- Record runtime dependencies and their licenses before publishing releases.
