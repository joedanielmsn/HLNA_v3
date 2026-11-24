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
