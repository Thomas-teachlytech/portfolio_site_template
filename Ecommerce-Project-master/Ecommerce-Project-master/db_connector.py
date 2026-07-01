# db_connector.py
# Module 3: Database Connector
# Purpose: Connects to SQL Server using pyodbc and SQLAlchemy
#          get_connection() - used for raw SQL (CREATE, DELETE)
#          get_engine()     - used for pandas to_sql() inserts

import pyodbc
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
import urllib.parse

# Load environment variables from .env file
load_dotenv(override=True)

# Read connection parameters from .env
SERVER   = os.getenv("SQL_SERVER")
DATABASE = os.getenv("SQL_DATABASE")
DRIVER   = "ODBC Driver 17 for SQL Server"


def get_connection():
    """
    Returns a pyodbc connection for raw SQL statements.
    Used for: CREATE TABLE, DELETE, custom queries
    """
    try:
        connection_string = (
            f"Driver={{{DRIVER}}};"
            f"Server={SERVER};"
            f"Database={DATABASE};"
            f"Trusted_Connection=yes;"
            f"Integrated Security=SSPI;"
        )
        conn = pyodbc.connect(connection_string)
        print(f"SUCCESS: Connected to {SERVER} - {DATABASE}")
        return conn

    except pyodbc.OperationalError as e:
        print(f"ERROR: Could not connect to SQL Server - {e}")
        return None

    except Exception as e:
        print(f"ERROR: Unexpected error - {e}")
        return None


def get_engine():
    """
    Returns a SQLAlchemy engine for pandas to_sql() inserts.
    Used for: inserting DataFrames into SQL Server
    """
    try:
        connection_string = (
            f"Driver={{{DRIVER}}};"
            f"Server={SERVER};"
            f"Database={DATABASE};"
            f"Trusted_Connection=yes;"
            f"Integrated Security=SSPI;"
        )

        params = urllib.parse.quote_plus(connection_string)

        engine = create_engine(
            f"mssql+pyodbc:///?odbc_connect={params}",
            fast_executemany=True
        )

        with engine.connect() as conn:
            print(f"SUCCESS: SQLAlchemy engine connected to {SERVER} - {DATABASE}")

        return engine

    except Exception as e:
        print(f"ERROR: Could not create SQLAlchemy engine - {e}")
        return None