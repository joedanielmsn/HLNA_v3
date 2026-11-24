# Connect an existing Ollama runtime

Jan supports custom OpenAI-compatible endpoints, including Ollama. This is the preferred first local-runtime path for HLNA on systems with limited VRAM.

## Configure it in the desktop app

1. Start Ollama and confirm the model you want to use is already available.
2. Open **Settings → Model Providers**.
3. Add a custom provider and select **OpenAI-compatible**.
4. Use these values:

   | Field | Value |
   |---|---|
   | Provider name | HLNA Local (Ollama) |
   | Base URL | `http://127.0.0.1:11434/v1` |
   | API key | `sk-no-key` (a non-empty placeholder for a local server that does not require authentication) |
   | Model | The exact model ID reported by `ollama list` |

5. Save the provider, select the model in chat, and send a short test prompt.

If the model list does not load automatically, add the model ID manually. Do not guess the model identifier; copy it from the local Ollama model list.

## Privacy and network scope

- Keep the endpoint on `127.0.0.1` / `localhost` for a single-machine setup.
- Do not bind the Ollama API to all network interfaces unless you intentionally configure and secure remote access.
- Requests to this local endpoint stay on the machine. If you switch to a cloud provider, prompts and attached context are sent to that provider.
- The HLNA installer does not download model weights. Model downloads are large and must be a deliberate user action.

## Hardware note

The previously tested low-resource target is a small quantized model with a 16K context window. Context size and GPU offload affect memory use; start with the model's known working settings and change one setting at a time.
 
## Upstream documentation

- [Jan custom endpoints](https://docs.jan.ai/desktop/remote-models/custom-endpoint)
- [Ollama OpenAI compatibility](https://ollama.com/blog/openai-compatibility)
