# api_client.py
# Module 1: API Client
# Purpose: Calls DummyJSON endpoints and returns raw JSON as a list of records
# Each function has its own error handling and returns None if something goes wrong

import requests

# ── Base URL ─────────────────────────────────────────────────────────────────
BASE_URL = "https://dummyjson.com"

# ── Helper: Generic Fetch Function ───────────────────────────────────────────
def fetch_data(endpoint: str, limit: int = 100) -> list:
    """
    Generic function to call any DummyJSON endpoint.
    Returns a list of records (the inner array), or None on failure.

    Args:
        endpoint : the API path, e.g. '/products'
        limit    : max number of records to retrieve (default 100)
    """
    url = f"{BASE_URL}{endpoint}?limit={limit}"

    try:
        response = requests.get(url, timeout=10)  # timeout after 10 seconds
        response.raise_for_status()               # raises error for 4xx/5xx status codes

        data = response.json()

        # The inner key matches the endpoint name (e.g. /products -> 'products')
        inner_key = endpoint.strip("/")           # strips the leading slash
        records   = data.get(inner_key, [])

        print(f"SUCCESS: Fetched {len(records)} records from {url}")
        return records

    except requests.exceptions.ConnectionError:
        print(f"ERROR: Connection error - could not reach {url}")
        return None

    except requests.exceptions.Timeout:
        print(f"ERROR: Timeout - {url} took too long to respond")
        return None

    except requests.exceptions.HTTPError as e:
        print(f"ERROR: HTTP error - {e}")
        return None

    except Exception as e:
        print(f"ERROR: Unexpected error - {e}")
        return None


# ── Public Functions (one per endpoint) ──────────────────────────────────────
def fetch_products(limit: int = 100) -> list:
    """Fetches up to `limit` products from DummyJSON. Returns a list of dicts."""
    return fetch_data("/products", limit)


def fetch_carts(limit: int = 100) -> list:
    """Fetches up to `limit` carts from DummyJSON. Returns a list of dicts."""
    return fetch_data("/carts", limit)


def fetch_users(limit: int = 100) -> list:
    """Fetches up to `limit` users from DummyJSON. Returns a list of dicts."""
    return fetch_data("/users", limit)