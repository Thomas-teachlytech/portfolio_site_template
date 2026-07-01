import requests

BASE_URL = "https://api-web.nhle.com/v1"


def get(endpoint):
    response = requests.get(f"{BASE_URL}/{endpoint}")
    response.raise_for_status()
    return response.json()


def get_standings():
    return get("standings/now")


def get_live_scores():
    return get("score/now")


def get_schedule(date=None):
    if date:
        return get(f"schedule/{date}")  # date format: YYYY-MM-DD
    return get("schedule/now")


def get_player(player_id):
    return get(f"player/{player_id}/landing")


def get_team_roster(team_abbrev, season="20242025"):
    return get(f"roster/{team_abbrev}/{season}")


def get_game(game_id):
    return get(f"gamecenter/{game_id}/landing")


if __name__ == "__main__":
    import json

    print("=== Live Scores ===")
    scores = get_live_scores()
    games = scores.get("games", [])
    if games:
        for game in games:
            home = game["homeTeam"]
            away = game["awayTeam"]
            print(f"{away['abbrev']} {away.get('score', 0)} @ {home['abbrev']} {home.get('score', 0)} — {game.get('gameState')}")
    else:
        print("No games currently.")

    print("\n=== Standings (Top 5 by points) ===")
    standings = get_standings()
    teams = standings.get("standings", [])
    for team in teams[:5]:
        print(f"{team['teamAbbrev']['default']:4} — {team['points']} pts ({team['wins']}-{team['losses']}-{team['otLosses']})")
