# transformer.py
# Module 2: Transformer
# Purpose: Takes raw JSON lists from Module 1 and converts them into
#          clean pandas DataFrames ready for SQL Server
# Handles: flattening nested fields, dropping sensitive data,
#          exploding child arrays into separate DataFrames

import pandas as pd

# ── PRODUCTS TRANSFORMER ──────────────────────────────────────────────────────
def transform_products(raw: list) -> tuple:
    """
    Takes raw products list from fetch_products() and returns two DataFrames:
    1. df_products  - one row per product (flat)
    2. df_reviews   - one row per review  (child table)

    Nested fields flattened:
        dimensions.width/height/depth  -> dim_width, dim_height, dim_depth
        meta.createdAt/updatedAt       -> meta_createdAt, meta_updatedAt
        tags[]                         -> tags (comma joined string)

    Args:
        raw : list of product dicts from fetch_products()

    Returns:
        tuple: (df_products, df_reviews)
    """
    try:
        rows = []

        for p in raw:
            # ── Flatten dimensions (nested object) ────────────────────────
            # dimensions is a dict like: {"width": 15.14, "height": 13.08, "depth": 22.99}
            # We pull each value out and give it a flat column name
            dims = p.get("dimensions", {})

            # ── Flatten meta (nested object) ──────────────────────────────
            # meta is a dict like: {"createdAt": "2025-04-30", "barcode": "123"}
            meta = p.get("meta", {})

            # ── Flatten tags (array -> comma joined string) ────────────────
            # tags is a list like: ["beauty", "mascara"]
            # We join them into one string: "beauty, mascara"
            tags = ", ".join(p.get("tags", []))

            # ── Build one flat row per product ────────────────────────────
            rows.append({
                "id"                   : p.get("id"),
                "title"                : p.get("title"),
                "description"          : p.get("description"),
                "category"             : p.get("category"),
                "price"                : p.get("price"),
                "discountPercentage"   : p.get("discountPercentage"),
                "rating"               : p.get("rating"),
                "stock"                : p.get("stock"),
                "brand"                : p.get("brand"),        # nullable
                "sku"                  : p.get("sku"),
                "weight"               : p.get("weight"),
                "availabilityStatus"   : p.get("availabilityStatus"),
                "returnPolicy"         : p.get("returnPolicy"),
                "warrantyInformation"  : p.get("warrantyInformation"),
                "minimumOrderQuantity" : p.get("minimumOrderQuantity"),
                "thumbnail"            : p.get("thumbnail"),
                "tags"                 : tags,
                # Flattened from dimensions{}
                "dim_width"            : dims.get("width"),
                "dim_height"           : dims.get("height"),
                "dim_depth"            : dims.get("depth"),
                # Flattened from meta{}
                "meta_createdAt"       : meta.get("createdAt"),
                "meta_updatedAt"       : meta.get("updatedAt"),
                "meta_barcode"         : meta.get("barcode"),
            })

        # Convert list of dicts to DataFrame
        df_products = pd.DataFrame(rows)

        # ── Build reviews child table ─────────────────────────────────────
        # Each product has a reviews[] array
        # We explode it into a separate table with product_id as foreign key
        review_rows = []

        for p in raw:
            for r in p.get("reviews", []):
                review_rows.append({
                    "product_id"     : p.get("id"),
                    "rating"         : r.get("rating"),
                    "comment"        : r.get("comment"),
                    "review_date"    : r.get("date"),
                    "reviewer_name"  : r.get("reviewerName"),
                    "reviewer_email" : r.get("reviewerEmail"),
                })

        df_reviews = pd.DataFrame(review_rows)

        print(f"SUCCESS: Transformed products  - {len(df_products)} rows, {len(df_reviews)} reviews")
        return df_products, df_reviews

    except Exception as e:
        print(f"ERROR: transform_products failed - {e}")
        return None, None


# ── CARTS TRANSFORMER ─────────────────────────────────────────────────────────
def transform_carts(raw: list) -> tuple:
    """
    Takes raw carts list from fetch_carts() and returns two DataFrames:
    1. df_carts      - one row per cart (flat)
    2. df_cart_items - one row per line item (child table)

    Args:
        raw : list of cart dicts from fetch_carts()

    Returns:
        tuple: (df_carts, df_cart_items)
    """
    try:
        cart_rows = []
        item_rows = []

        for c in raw:
            # ── Build one flat row per cart ───────────────────────────────
            cart_rows.append({
                "id"              : c.get("id"),
                "userId"          : c.get("userId"),
                "total"           : c.get("total"),
                "discountedTotal" : c.get("discountedTotal"),
                "totalProducts"   : c.get("totalProducts"),
                "totalQuantity"   : c.get("totalQuantity"),
            })

            # ── Explode products array into cart_items child table ────────
            # Each cart has a products[] array (line items)
            # We give each line item the cart_id as a foreign key
            for item in c.get("products", []):
                item_rows.append({
                    "cart_id"            : c.get("id"),
                    "product_id"         : item.get("id"),
                    "title"              : item.get("title"),
                    "price"              : item.get("price"),
                    "quantity"           : item.get("quantity"),
                    "total"              : item.get("total"),
                    "discountPercentage" : item.get("discountPercentage"),
                    "discountedTotal"    : item.get("discountedTotal"),
                    "thumbnail"          : item.get("thumbnail"),
                })

        df_carts      = pd.DataFrame(cart_rows)
        df_cart_items = pd.DataFrame(item_rows)

        print(f"SUCCESS: Transformed carts     - {len(df_carts)} rows, {len(df_cart_items)} line items")
        return df_carts, df_cart_items

    except Exception as e:
        print(f"ERROR: transform_carts failed - {e}")
        return None, None


# ── USERS TRANSFORMER ─────────────────────────────────────────────────────────
def transform_users(raw: list) -> pd.DataFrame:
    """
    Takes raw users list from fetch_users() and returns one clean DataFrame.

    Nested fields flattened:
        address.city/state/postalCode  -> addr_city, addr_state, addr_postalCode
        address.address                -> addr_street
        hair.color/type                -> hair_color, hair_type
        company.name/department/title  -> company_name, company_dept, company_title
        bank.cardType/currency/iban    -> bank_cardType, bank_currency, bank_iban

    Sensitive fields DROPPED:
        password, ssn, ein, ip, macAddress,
        userAgent, crypto, bank.cardNumber,
        bank.cardExpire, image

    Args:
        raw : list of user dicts from fetch_users()

    Returns:
        pd.DataFrame: clean users DataFrame
    """
    try:
        rows = []

        for u in raw:
            # ── Extract nested objects ────────────────────────────────────
            # Each of these is a dict nested inside the user object
            # We flatten them by pulling out individual fields
            # and naming them with a prefix (addr_, hair_, company_, bank_)

            address = u.get("address", {})
            # address looks like:
            # {"address": "626 Main St", "city": "Phoenix", "state": "MS",
            #  "postalCode": "29112", "coordinates": {...}, "country": "US"}

            hair    = u.get("hair", {})
            # hair looks like: {"color": "Brown", "type": "Curly"}

            company = u.get("company", {})
            # company looks like:
            # {"name": "Acme Corp", "department": "Engineering",
            #  "title": "Sales Manager", "address": {...}}

            bank    = u.get("bank", {})
            # bank looks like:
            # {"cardExpire": "05/28", "cardNumber": "3693...",
            #  "cardType": "Visa", "currency": "GBP", "iban": "GB74..."}
            # NOTE: we keep cardType, currency, iban but DROP cardNumber and cardExpire

            # ── Build one flat row per user ───────────────────────────────
            rows.append({
                # Core fields
                "id"           : u.get("id"),
                "firstName"    : u.get("firstName"),
                "lastName"     : u.get("lastName"),
                "maidenName"   : u.get("maidenName"),
                "age"          : u.get("age"),
                "gender"       : u.get("gender"),
                "email"        : u.get("email"),
                "phone"        : u.get("phone"),
                "username"     : u.get("username"),
                "birthDate"    : u.get("birthDate"),
                "bloodGroup"   : u.get("bloodGroup"),
                "height"       : u.get("height"),
                "weight"       : u.get("weight"),
                "eyeColor"     : u.get("eyeColor"),
                "university"   : u.get("university"),
                "role"         : u.get("role"),

                # Flattened from hair{}
                "hair_color"   : hair.get("color"),
                "hair_type"    : hair.get("type"),

                # Flattened from address{}
                # address.address is the street - renamed to addr_street
                "addr_street"      : address.get("address"),
                "addr_city"        : address.get("city"),
                "addr_state"       : address.get("state"),
                "addr_postalCode"  : address.get("postalCode"),
                "addr_country"     : address.get("country"),

                # Flattened from company{}
                "company_name"     : company.get("name"),
                "company_dept"     : company.get("department"),
                "company_title"    : company.get("title"),

                # Flattened from bank{}
                # NOTE: cardNumber and cardExpire intentionally excluded
                "bank_cardType"    : bank.get("cardType"),
                "bank_currency"    : bank.get("currency"),
                "bank_iban"        : bank.get("iban"),

                # SENSITIVE FIELDS INTENTIONALLY DROPPED:
                # password, ssn, ein, ip, macAddress,
                # userAgent, crypto, image,
                # bank.cardNumber, bank.cardExpire
            })

        df_users = pd.DataFrame(rows)

        print(f"SUCCESS: Transformed users     - {len(df_users)} rows")
        return df_users

    except Exception as e:
        print(f"ERROR: transform_users failed - {e}")
        return None