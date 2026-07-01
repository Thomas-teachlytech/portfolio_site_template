"""
analyst.py
----------
Main entry point. Accepts a user question, routes it to the
right SQL query, fetches data, and returns an LLM answer.

Usage:
    python analyst.py                  # interactive mode
    python analyst.py --test           # runs 3 end-to-end test questions

Full pipeline:
    User question
        → question_router  → query key
        → db_reader        → raw data (list of dicts)
        → llm_connector    → plain-English answer
"""

import sys
from question_router import route_question
from db_reader       import run_query
from llm_connector   import ask_llm


# ── Core pipeline ─────────────────────────────────────────────────────────────
def answer_question(question: str) -> str:
    """
    Full pipeline: question → route → SQL → LLM → answer string.
    Raises ValueError if no route matches.
    """
    # Step 1: route
    query_key = route_question(question)
    if not query_key:
        raise ValueError(
            "Sorry, I don't have a query for that question. "
            "Try asking about product categories, prices, stock, users, or cart totals."
        )

    # Step 2: fetch data
    rows = run_query(query_key)
    if not rows:
        return "The query returned no data. The database may be empty for this topic."

    # Step 3: ask LLM
    return ask_llm(question, rows)


def run_interactive():
    """Simple REPL — type a question, get an answer. Type 'quit' to exit."""
    print("\n=== Ecommerce AI Analyst ===")
    print("follow your wuick start guide to ask question about the cataegories listed in the guide")
    print("Type 'quit' to exit.\n")

    while True:
        try:
            question = input("Your question: ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nGoodbye!")
            break

        if not question:
            continue
        if question.lower() in {"quit", "exit", "q"}:
            print("Goodbye!")
            break

        try:
            answer = answer_question(question)
            print(f"\nAnswer: {answer}\n")
        except ValueError as e:
            print(f"\n[Routing] {e}\n")
        except (ConnectionError, RuntimeError) as e:
            print(f"\n[Error] {e}\n")


def run_tests():
    """Run 3 end-to-end questions and print results."""
    test_questions = [
        "Which product category has the highest average price?",
        "Which users have placed the largest orders by total value?",
        "Which products have low stock (under 20 units)?",
        "Are there any orders with discount abuse?"
    ]

    print("\n=== End-to-End Test: 3 Questions ===\n")
    for i, question in enumerate(test_questions, 1):
        print(f"[{i}] {question}")
        print("-" * 60)
        try:
            answer = answer_question(question)
            print(f"Answer: {answer}")
        except (ValueError, ConnectionError, RuntimeError) as e:
            print(f"ERROR: {e}")
        print()


# ── Entry point ───────────────────────────────────────────────────────────────
if __name__ == "__main__":
    if "--test" in sys.argv:
        run_tests()
    else:
        run_interactive()