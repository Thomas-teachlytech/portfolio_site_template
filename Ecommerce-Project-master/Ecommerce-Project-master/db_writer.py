# db_writer.py
# Module 4: Database Writer
# Purpose: Creates SQL tables and inserts DataFrames into SQL Server
#          Uses pyodbc for CREATE TABLE and DELETE statements
#          Uses SQLAlchemy engine for pandas to_sql() inserts

import pandas as pd
from db_connector import get_connection, get_engine


def create_tables():
    """
    Creates all 5 tables in EcommerceDB if they don't already exist.
    Uses pyodbc connection for DDL statements.
    """
    conn = get_connection()

    if conn is None:
        print("ERROR: create_tables failed - no database connection")
        return False

    try:
        cursor = conn.cursor()

        cursor.execute("""
            IF NOT EXISTS (
                SELECT * FROM INFORMATION_SCHEMA.TABLES
                WHERE TABLE_NAME = 'products'
            )
            CREATE TABLE products (
                id                   INT PRIMARY KEY,
                title                NVARCHAR(255),
                description          NVARCHAR(MAX),
                category             NVARCHAR(100),
                price                DECIMAL(10,2),
                discountPercentage   DECIMAL(5,2),
                rating               DECIMAL(3,2),
                stock                INT,
                brand                NVARCHAR(100),
                sku                  NVARCHAR(100),
                weight               INT,
                availabilityStatus   NVARCHAR(100),
                returnPolicy         NVARCHAR(255),
                warrantyInformation  NVARCHAR(255),
                minimumOrderQuantity INT,
                thumbnail            NVARCHAR(MAX),
                tags                 NVARCHAR(MAX),
                dim_width            DECIMAL(10,2),
                dim_height           DECIMAL(10,2),
                dim_depth            DECIMAL(10,2),
                meta_createdAt       NVARCHAR(50),
                meta_updatedAt       NVARCHAR(50),
                meta_barcode         NVARCHAR(100)
            )
        """)
        print("SUCCESS: products table ready")

        cursor.execute("""
            IF NOT EXISTS (
                SELECT * FROM INFORMATION_SCHEMA.TABLES
                WHERE TABLE_NAME = 'product_reviews'
            )
            CREATE TABLE product_reviews (
                review_id      INT IDENTITY(1,1) PRIMARY KEY,
                product_id     INT,
                rating         INT,
                comment        NVARCHAR(MAX),
                review_date    NVARCHAR(50),
                reviewer_name  NVARCHAR(255),
                reviewer_email NVARCHAR(255)
            )
        """)
        print("SUCCESS: product_reviews table ready")

        cursor.execute("""
            IF NOT EXISTS (
                SELECT * FROM INFORMATION_SCHEMA.TABLES
                WHERE TABLE_NAME = 'carts'
            )
            CREATE TABLE carts (
                id              INT PRIMARY KEY,
                userId          INT,
                total           DECIMAL(12,2),
                discountedTotal DECIMAL(12,2),
                totalProducts   INT,
                totalQuantity   INT
            )
        """)
        print("SUCCESS: carts table ready")

        cursor.execute("""
            IF NOT EXISTS (
                SELECT * FROM INFORMATION_SCHEMA.TABLES
                WHERE TABLE_NAME = 'cart_items'
            )
            CREATE TABLE cart_items (
                item_id            INT IDENTITY(1,1) PRIMARY KEY,
                cart_id            INT,
                product_id         INT,
                title              NVARCHAR(255),
                price              DECIMAL(10,2),
                quantity           INT,
                total              DECIMAL(12,2),
                discountPercentage DECIMAL(5,2),
                discountedTotal    DECIMAL(12,2),
                thumbnail          NVARCHAR(MAX)
            )
        """)
        print("SUCCESS: cart_items table ready")

        cursor.execute("""
            IF NOT EXISTS (
                SELECT * FROM INFORMATION_SCHEMA.TABLES
                WHERE TABLE_NAME = 'users'
            )
            CREATE TABLE users (
                id              INT PRIMARY KEY,
                firstName       NVARCHAR(100),
                lastName        NVARCHAR(100),
                maidenName      NVARCHAR(100),
                age             INT,
                gender          NVARCHAR(20),
                email           NVARCHAR(255),
                phone           NVARCHAR(50),
                username        NVARCHAR(100),
                birthDate       NVARCHAR(50),
                bloodGroup      NVARCHAR(10),
                height          DECIMAL(5,2),
                weight          DECIMAL(5,2),
                eyeColor        NVARCHAR(50),
                university      NVARCHAR(255),
                role            NVARCHAR(50),
                hair_color      NVARCHAR(50),
                hair_type       NVARCHAR(50),
                addr_street     NVARCHAR(255),
                addr_city       NVARCHAR(100),
                addr_state      NVARCHAR(100),
                addr_postalCode NVARCHAR(20),
                addr_country    NVARCHAR(100),
                company_name    NVARCHAR(255),
                company_dept    NVARCHAR(100),
                company_title   NVARCHAR(100),
                bank_cardType   NVARCHAR(50),
                bank_currency   NVARCHAR(10),
                bank_iban       NVARCHAR(50)
            )
        """)
        print("SUCCESS: users table ready")

        conn.commit()
        cursor.close()
        conn.close()
        return True

    except Exception as e:
        print(f"ERROR: create_tables failed - {e}")
        conn.close()
        return False


def write_products(df_products, df_reviews):
    """
    Deletes existing data and inserts fresh products
    and product_reviews DataFrames into SQL Server.
    Uses pyodbc for DELETE and SQLAlchemy engine for to_sql().
    """
    # Step 1 - Delete existing data using pyodbc
    conn = get_connection()
    if conn is None:
        print("ERROR: write_products failed - no connection")
        return False

    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM product_reviews")
        cursor.execute("DELETE FROM products")
        conn.commit()
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"ERROR: Could not delete existing products - {e}")
        conn.close()
        return False

    # Step 2 - Insert using SQLAlchemy engine
    engine = get_engine()
    if engine is None:
        print("ERROR: write_products failed - no engine")
        return False

    try:
        df_products.to_sql(
            "products",
            engine,            # SQLAlchemy engine - not pyodbc conn
            if_exists="append",
            index=False,
            schema="dbo"
        )
        print(f"SUCCESS: Inserted {len(df_products)} rows into products")

        df_reviews.to_sql(
            "product_reviews",
            engine,            # SQLAlchemy engine - not pyodbc conn
            if_exists="append",
            index=False,
            schema="dbo"
        )
        print(f"SUCCESS: Inserted {len(df_reviews)} rows into product_reviews")

        return True

    except Exception as e:
        print(f"ERROR: write_products failed - {e}")
        return False


def write_carts(df_carts, df_cart_items):
    """
    Deletes existing data and inserts fresh carts
    and cart_items DataFrames into SQL Server.
    """
    # Step 1 - Delete existing data using pyodbc
    conn = get_connection()
    if conn is None:
        print("ERROR: write_carts failed - no connection")
        return False

    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM cart_items")
        cursor.execute("DELETE FROM carts")
        conn.commit()
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"ERROR: Could not delete existing carts - {e}")
        conn.close()
        return False

    # Step 2 - Insert using SQLAlchemy engine
    engine = get_engine()
    if engine is None:
        print("ERROR: write_carts failed - no engine")
        return False

    try:
        df_carts.to_sql(
            "carts",
            engine,
            if_exists="append",
            index=False,
            schema="dbo"
        )
        print(f"SUCCESS: Inserted {len(df_carts)} rows into carts")

        df_cart_items.to_sql(
            "cart_items",
            engine,
            if_exists="append",
            index=False,
            schema="dbo"
        )
        print(f"SUCCESS: Inserted {len(df_cart_items)} rows into cart_items")

        return True

    except Exception as e:
        print(f"ERROR: write_carts failed - {e}")
        return False


def write_users(df_users):
    """
    Deletes existing data and inserts fresh users
    DataFrame into SQL Server.
    """
    # Step 1 - Delete existing data using pyodbc
    conn = get_connection()
    if conn is None:
        print("ERROR: write_users failed - no connection")
        return False

    try:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM users")
        conn.commit()
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"ERROR: Could not delete existing users - {e}")
        conn.close()
        return False

    # Step 2 - Insert using SQLAlchemy engine
    engine = get_engine()
    if engine is None:
        print("ERROR: write_users failed - no engine")
        return False

    try:
        df_users.to_sql(
            "users",
            engine,
            if_exists="append",
            index=False,
            schema="dbo"
        )
        print(f"SUCCESS: Inserted {len(df_users)} rows into users")

        return True

    except Exception as e:
        print(f"ERROR: write_users failed - {e}")
        return False