"""
llm_connector.py
----------------
Formats query results into a plain-text table and sends
them to OpenAI along with the user's question.

Test:
    python llm_connector.py
"""

from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
MODEL          = "gpt-4o-mini"
MAX_TOKENS     = 512


def format_results_as_table(rows: list[dict]) -> str:
    """Convert a list of row dicts into a readable plain-text table."""
    if not rows:
        return "No data returned."

    headers    = list(rows[0].keys())
    col_widths = {h: max(len(h), max(len(str(r[h])) for r in rows)) for h in headers}

    header_line = " | ".join(h.ljust(col_widths[h]) for h in headers)
    separator   = "-+-".join("-" * col_widths[h] for h in headers)
    data_lines  = [
        " | ".join(str(row[h]).ljust(col_widths[h]) for h in headers)
        for row in rows
    ]

    return "\n".join([header_line, separator] + data_lines)


def ask_llm(user_question: str, query_results: list[dict]) -> str:
    """
    Send question + formatted SQL results to OpenAI.
    Returns a plain-English answer as a string.
    """
    client     = OpenAI(api_key=OPENAI_API_KEY)
    data_table = format_results_as_table(query_results)

    prompt = f"""You are a concise ecommerce data analyst.
Answer the user's question using ONLY the data provided below.
Be specific — reference actual values from the data.
If the data does not contain enough information, say so clearly.

USER QUESTION:
{user_question}

DATA:
{data_table}

Answer:"""

    try:
        response = client.chat.completions.create(
            model=MODEL,
            max_tokens=MAX_TOKENS,
            messages=[{"role": "user", "content": prompt}],
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        raise RuntimeError(f"OpenAI API error: {e}") from e


# ── Test ─────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    # Use sample data so this module can be tested without a DB connection
    sample_data = [
        {"category": "laptops",     "avg_price": 1299.99, "product_count": 5},
        {"category": "smartphones", "avg_price":  899.49, "product_count": 8},
        {"category": "skincare",    "avg_price":   39.99, "product_count": 12},
    ]
    question = "Which product category has the highest average price?"

    print(f"Question: {question}\n")
    print("Formatted table sent to LLM:")
    print(format_results_as_table(sample_data))
    print()

    try:
        answer = ask_llm(question, sample_data)
        print(f"LLM Answer:\n{answer}")
    except RuntimeError as e:
        print(f"ERROR: {e}")