import requests

BASE_URL = "https://api.stlouisfed.org/fred/series/observations"

SERIES = {
    "median_home_price": "MSPUS",
    "mortgage_rate_30yr": "MORTGAGE30US",
    "housing_inventory": "ACTLISCOUUS",
    "median_rent": "CUSR0000SEHA",
}


def get_series(series_id, limit=10):
    params = {
        "series_id": series_id,
        "api_key": "abcdefghijklmnopqrstuvwxyz123456",  # use your key or omit for limited access
        "file_type": "json",
        "sort_order": "desc",
        "limit": limit,
    }
    response = requests.get(BASE_URL, params=params)
    response.raise_for_status()
    return response.json()["observations"]


if __name__ == "__main__":
    for name, series_id in SERIES.items():
        print(f"\n=== {name.replace('_', ' ').title()} ({series_id}) ===")
        try:
            observations = get_series(series_id, limit=5)
            for obs in observations:
                print(f"  {obs['date']}: {obs['value']}")
        except Exception as e:
            print(f"  Error: {e}")
