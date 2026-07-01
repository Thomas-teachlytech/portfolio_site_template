"""
connector.py — API provider connector.

This is the ONLY file you need to change to swap providers.
Replace create_client() and call_model() with the equivalent
for OpenAI, Gemini, Mistral, etc.

Current provider: Anthropic
"""

import anthropic


def create_client(api_key: str):
    """Return an authenticated client for the provider."""
    return anthropic.Anthropic(api_key=api_key)


def call_model(client, system: str, user: str, model: str) -> str:
    """
    Send a single system+user turn and return the text response.

    Args:
        client: the object returned by create_client()
        system: system prompt string
        user:   user message string
        model:  model identifier string (provider-specific)

    Returns:
        Response text as a plain string.
    """
    response = client.messages.create(
        model=model,
        max_tokens=2048,
        system=system,
        messages=[{"role": "user", "content": user}],
    )
    return next((b.text for b in response.content if b.type == "text"), "")


# ── Example swap: OpenAI ──────────────────────────────────────────────
# To use OpenAI, replace the block above with:
#
# import openai
#
# def create_client(api_key: str):
#     return openai.OpenAI(api_key=api_key)
#
# def call_model(client, system: str, user: str, model: str) -> str:
#     response = client.chat.completions.create(
#         model=model,
#         messages=[
#             {"role": "system", "content": system},
#             {"role": "user",   "content": user},
#         ],
#         max_tokens=2048,
#     )
#     return response.choices[0].message.content or ""
