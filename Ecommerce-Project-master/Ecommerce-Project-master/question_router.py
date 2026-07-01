"""
question_router.py
------------------
Maps a user's plain-English question to the correct SQL query key
using simple keyword matching.

Test:
    python question_router.py
"""


# ── Routing table ─────────────────────────────────────────────────────────────
# Each entry: (list_of_keywords_that_must_match, query_key)
# Keywords are checked against the lowercase question.
# First match wins — order from most-specific to least-specific.

ROUTES: list[tuple[list[str], str]] = [
    # "Which product category has the highest average price?"
    (["category", "costs", "most"],                 "highest_avg_price_category"),
    (["category", "expensive"],                     "highest_avg_price_category"),
    (["category", "price"],                         "highest_avg_price_category"),

    # "Which users have placed the largest orders by total value?"
    (["user", "order"],                             "largest_orders_by_user"),
    (["user", "cart"],                              "largest_orders_by_user"),
    (["largest", "order"],                          "largest_orders_by_user"),
    (["biggest", "order"],                          "largest_orders_by_user"),

    # "What is the average cart total across all orders?"
    (["average", "cart"],                           "average_cart_total"),
    (["avg", "cart"],                               "average_cart_total"),
    (["average", "order"],                          "average_cart_total"),

    # "Which products have low stock (under 20 units)?"
    (["low stock"],                                 "low_stock_products"),
    (["stock"],                                     "low_stock_products"),
    (["inventory"],                                 "low_stock_products"),

    # "Which category has the most products?"
    (["category", "most product"],                  "most_products_by_category"),
    (["category", "most"],                          "most_products_by_category"),
    (["category", "count"],                         "most_products_by_category"),
    (["how many product"],                          "most_products_by_category"),
]


def route_question(question: str) -> str | None:
    """
    Return the query key that best matches the user's question,
    or None if no route matches.
    """
    q = question.lower()
    for keywords, query_key in ROUTES:
        if all(kw in q for kw in keywords):
            return query_key
    return None


# ── Test ─────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    test_questions = [
        # Expected matches
        ("Which product category has the highest average price?",    "highest_avg_price_category"),
        ("Which users have placed the largest orders by total value?","largest_orders_by_user"),
        ("What is the average cart total across all orders?",        "average_cart_total"),
        ("Which products have low stock (under 20 units)?",          "low_stock_products"),
        ("Which category has the most products?",                    "most_products_by_category"),
        # Paraphrases
        ("What category costs the most on average?",                 "highest_avg_price_category"),
        ("Show me users with the biggest orders",                    "largest_orders_by_user"),
        ("What's the average order value?",                          "average_cart_total"),
        ("What items are low on inventory?",                         "low_stock_products"),
        ("How many products does each category have?",               "most_products_by_category"),
        # Should return None
        ("What is the weather today?",                               None),
    ]

    print(f"{'Question':<55} {'Expected':<30} {'Got':<30} {'OK'}")
    print("-" * 125)
    all_pass = True
    for question, expected in test_questions:
        result = route_question(question)
        ok     = "✓" if result == expected else "✗"
        if result != expected:
            all_pass = False
        print(f"{question:<55} {str(expected):<30} {str(result):<30} {ok}")

    print()
    print("All tests passed ✓" if all_pass else "Some tests FAILED ✗")