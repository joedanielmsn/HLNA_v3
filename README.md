# HLNA v3

**A local-first desktop AI assistant for Windows and CachyOS.**

HLNA v3 is being assembled around proven upstream software instead of recreating mature components. The first milestone establishes a reproducible desktop build and fresh-machine installers; the next milestones add HLNA's own integration, safety, memory, automation, and desktop-assistance layers.

> **Bootstrap build status:** the initial desktop foundation is Jan Desktop, pinned to a known source revision. This first build is a functional upstream baseline, not yet the finished HLNA-branded experience. The upstream Jan interface and attribution remain visible in this stage.

## Current build target

| Platform | Package |
|---|---|
| Windows 10/11 x64 | Windows installer (.exe; MSI where emitted by Tauri) |
| CachyOS / Arch x86_64 | Pacman package (.pkg.tar.zst), with dependencies declared for pacman |

The installers are intended for ordinary end users. Node.js, Rust, Yarn, Make, and compiler toolchains are CI build dependencies only; they are not required on the target computer.

## Get a test build

There is no published HLNA v3 release yet. When the first CI build completes, download its artifacts from the repository's **Actions** tab. Tagged builds will be attached to GitHub Releases.

For CachyOS, the eventual one-command installer will be:

```bash
curl -fsSL https://raw.githubusercontent.com/joedanielmsn/HLNA_v3/main/packaging/arch/install-cachyos.sh | bash
```

Only run the installer after reviewing the script. It downloads the package from this repository and asks pacman to install it and resolve declared dependencies.

## Local models and hardware

The desktop foundation supports local GGUF inference and OpenAI-compatible custom endpoints, including Ollama. HLNA's intended low-resource profile remains the previously tested Qwen 3.5 2B Q4_K_M setup at a 16K context window on a 4 GB GPU. That profile will be wired in as an HLNA preset after the baseline build is validated; this bootstrap does not bundle model weights or assume that every model fits every GPU.

A local model download is separate from the application installer and can be several gigabytes. Cloud providers remain optional.

## Development principles

- Reuse complete, maintained upstream applications and runtimes where practical.
- Pin upstream revisions; keep attribution and applicable licenses.
- Prefer adapters and narrow patches over wholesale forks or rewrites.
- Local-first by default; cloud providers are opt-in.
- Require explicit approval for sensitive or destructive computer actions.
- Make monitoring visible and pausable; no hidden camera, microphone, or screen recording.
- Keep model/resource use configurable and avoid unnecessary concurrent model loads.

## Repository map

- `UPSTREAMS.md` — upstream selection and pinned revisions.
- `docs/PRODUCT_PLAN.md` — product architecture and staged integration plan.
- `packaging/arch/` — CachyOS/Arch package and installer.
- `.github/workflows/build.yml` — Windows and Linux build/release pipeline.

## License

HLNA's original files will receive an explicit project license after the first-party and third-party license inventory is complete. Upstream components retain their own licenses; see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
