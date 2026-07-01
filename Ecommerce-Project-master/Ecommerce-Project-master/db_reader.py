"""
db_reader.py
------------
Handles all database connectivity and query execution.
Returns results as a list of dicts (easy to pass to the LLM).

Test:
    python db_reader.py
"""

import pyodbc
from dotenv import load_dotenv
import os

load_dotenv()

DB_SERVER = os.getenv("DB_SERVER")
DB_NAME   = os.getenv("DB_NAME")

# ── All pre-written SQL queries ───────────────────────────────────────────────
QUERIES = {
    "highest_avg_price_category": """
        SELECT
            category,
            ROUND(AVG(price), 2) AS avg_price,
            COUNT(*)             AS product_count
        FROM products
        GROUP BY category
        ORDER BY avg_price DESC;
    """,

    "largest_orders_by_user": """
        SELECT TOP 10
            u.firstName,
            u.lastName,
            u.email,
            u.addr_city,
            u.addr_state,
            ROUND(c.total, 2)            AS cart_total,
            ROUND(c.discountedTotal, 2)  AS discounted_total,
            c.totalQuantity              AS items
        FROM carts c
        JOIN users u ON u.id = c.userId
        ORDER BY c.total DESC;
    """,

    "average_cart_total": """
        SELECT
            ROUND(AVG(total), 2)           AS avg_cart_total,
            ROUND(AVG(discountedTotal), 2) AS avg_discounted_total,
            COUNT(*)                       AS total_carts
        FROM carts;
    """,

    "low_stock_products": """
        SELECT
            title,
            category,
            brand,
            stock,
            price,
            rating
        FROM products
        WHERE stock < 20
        ORDER BY stock ASC;
    """,

    "most_products_by_category": """
        SELECT
            category,
            COUNT(*)             AS product_count,
            ROUND(MIN(price), 2) AS min_price,
            ROUND(MAX(price), 2) AS max_price
        FROM products
        GROUP BY category
        ORDER BY product_count DESC;
    """,
}


def get_db_connection() -> pyodbc.Connection:
    """Open and return a pyodbc connection using Windows Authentication."""
    conn_str = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={DB_SERVER};"
        f"DATABASE={DB_NAME};"
        "Trusted_Connection=yes;"
        "TrustServerCertificate=yes;"
    )
    try:
        return pyodbc.connect(conn_str, timeout=10)
    except pyodbc.Error as e:
        raise ConnectionError(f"Database connection failed: {e}") from e


def run_query(query_key: str) -> list[dict]:
    """
    Execute the query mapped to query_key.
    Returns a list of row dicts.
    Raises ValueError for unknown keys, RuntimeError on SQL failure.
    """
    sql = QUERIES.get(query_key)
    if not sql:
        raise ValueError(f"Unknown query key: '{query_key}'. "
                         f"Available: {list(QUERIES.keys())}")

    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        columns = [col[0] for col in cursor.description]
        return [dict(zip(columns, row)) for row in cursor.fetchall()]
    except pyodbc.Error as e:
        raise RuntimeError(f"Query '{query_key}' failed: {e}") from e
    finally:
        conn.close()


# ── Test ─────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    print("Testing db_reader.py with: highest_avg_price_category\n")
    try:
        rows = run_query("highest_avg_price_category")
        if rows:
            headers = list(rows[0].keys())
            print(" | ".join(headers))
            print("-" * 60)
            for row in rows:
                print(" | ".join(str(row[h]) for h in headers))
        else:
            print("No rows returned.")
    except (ConnectionError, RuntimeError, ValueError) as e:
        print(f"ERROR: {e}")