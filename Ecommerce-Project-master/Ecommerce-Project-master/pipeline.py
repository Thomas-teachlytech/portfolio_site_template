# pipeline.py
# Module 5: Pipeline
# Purpose: Runs the entire ETL pipeline end to end in one script
#          Extract  -> api_client.py   (fetch raw JSON from DummyJSON API)
#          Transform -> transformer.py  (flatten JSON into clean DataFrames)
#          Load     -> db_writer.py    (insert DataFrames into SQL Server)
#
# Usage: Run this file directly to execute the full pipeline
#        python pipeline.py

import sys
from api_client  import fetch_products, fetch_carts, fetch_users
from transformer import transform_products, transform_carts, transform_users
from db_writer   import create_tables, write_products, write_carts, write_users


def run_pipeline():
    """
    Runs the full ETL pipeline in order:
    1. Create tables in SQL Server
    2. Extract raw data from DummyJSON API
    3. Transform raw data into clean DataFrames
    4. Load DataFrames into SQL Server

    Returns:
        True if pipeline completes successfully
        False if any step fails
    """

    print("=" * 50)
    print("  ECOMMERCE ETL PIPELINE - STARTING")
    print("=" * 50)
    print()

    # ── STEP 1: Create Tables ─────────────────────────────────────────────────
    print("STEP 1: Creating tables in SQL Server...")
    success = create_tables()

    if not success:
        print("PIPELINE FAILED: Could not create tables - stopping")
        return False
    print()

    # ── STEP 2: Extract - Fetch raw data from API ─────────────────────────────
    print("STEP 2: Extracting data from DummyJSON API...")

    products_raw = fetch_products()
    if products_raw is None:
        print("PIPELINE FAILED: Could not fetch products - stopping")
        return False

    carts_raw = fetch_carts()
    if carts_raw is None:
        print("PIPELINE FAILED: Could not fetch carts - stopping")
        return False

    users_raw = fetch_users()
    if users_raw is None:
        print("PIPELINE FAILED: Could not fetch users - stopping")
        return False

    print()

    # ── STEP 3: Transform - Flatten JSON into DataFrames ──────────────────────
    print("STEP 3: Transforming raw data into DataFrames...")

    df_products, df_reviews = transform_products(products_raw)
    if df_products is None:
        print("PIPELINE FAILED: Could not transform products - stopping")
        return False

    df_carts, df_cart_items = transform_carts(carts_raw)
    if df_carts is None:
        print("PIPELINE FAILED: Could not transform carts - stopping")
        return False

    df_users = transform_users(users_raw)
    if df_users is None:
        print("PIPELINE FAILED: Could not transform users - stopping")
        return False

    print()

    # ── STEP 4: Load - Insert DataFrames into SQL Server ──────────────────────
    print("STEP 4: Loading data into SQL Server...")

    success = write_products(df_products, df_reviews)
    if not success:
        print("PIPELINE FAILED: Could not write products - stopping")
        return False

    success = write_carts(df_carts, df_cart_items)
    if not success:
        print("PIPELINE FAILED: Could not write carts - stopping")
        return False

    success = write_users(df_users)
    if not success:
        print("PIPELINE FAILED: Could not write users - stopping")
        return False

    print()

    # ── PIPELINE COMPLETE ─────────────────────────────────────────────────────
    print("=" * 50)
    print("  PIPELINE COMPLETE - ALL TABLES LOADED")
    print("=" * 50)
    print()
    print("Tables loaded into EcommerceDB:")
    print(f"  products       : {len(df_products)} rows")
    print(f"  product_reviews: {len(df_reviews)} rows")
    print(f"  carts          : {len(df_carts)} rows")
    print(f"  cart_items     : {len(df_cart_items)} rows")
    print(f"  users          : {len(df_users)} rows")
    print(f"  Total rows     : {len(df_products) + len(df_reviews) + len(df_carts) + len(df_cart_items) + len(df_users)}")
    print()
    print("Verify in SSMS:")
    print("  SELECT COUNT(*) FROM products")
    print("  SELECT COUNT(*) FROM product_reviews")
    print("  SELECT COUNT(*) FROM carts")
    print("  SELECT COUNT(*) FROM cart_items")
    print("  SELECT COUNT(*) FROM users")

    return True


# ── Entry Point ───────────────────────────────────────────────────────────────
# This block runs when you execute pipeline.py directly
# It will NOT run when pipeline.py is imported by another file
if __name__ == "__main__":
    success = run_pipeline()
    if not success:
        sys.exit(1)    # exit with error code 1 if pipeline failed