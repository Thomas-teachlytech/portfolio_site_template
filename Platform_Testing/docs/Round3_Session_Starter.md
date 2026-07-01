# Round 3 Session Starter — Data Volume Testing

## What this project is

A domain-portable AI model capability testing framework inspired by FollowBench (ACL 2024).
It tests how well AI models follow system prompt instructions as rule complexity increases,
using a cumulative tier ladder (T1 = 1 rule active, T7 = 7 rules active simultaneously).
The framework uses a two-call approach: Call 1 = model under test, Call 2 = Claude-as-judge
scoring PASS/FAIL per rule.

## What we have completed

**Round 1 — Single category baseline**
- Tested 11 instruction categories in isolation across 3 models
- Derived category weights (failures / 21 opportunities per category)
- Key weights: Scope=0.71, Chained=0.38, Situation=0.38, Negation=0.19, Persona=0.10
- Models: claude-opus-4-8, claude-sonnet-4-6, claude-haiku-4-5
- Domain: Finance (NVDA and JPM earnings, insider activity, price data)
- Fixed user prompt: "Summarise the earnings performance, insider activity, and recent price movement for NVDA and JPM based on the attached data."

**Round 2 — Cross-category combinations**
- Tested 8 combinations across Hard / Medium / Easy / Control bands
- Key findings:
  - Scope fails at T1 on Sonnet and Haiku regardless of what it is paired with — it dominates
  - Chained + Situation (M4) compounds on Haiku — 5 consecutive failing tiers — without Scope present
  - Opus had isolated single-tier failures only, never consecutive collapse
  - Control tests (zero-weight categories) failed on Haiku — Haiku is unreliable above T2 even for simple rules
- Safe rule count ceilings: Opus T5-T6, Sonnet T3-T4, Haiku T1-T2

**Round 3 — What we are doing next (DATA VOLUME)**
Hold the rule set constant and increase the size of the financial data payload.
The question: at what payload size does the model start dropping rules it was
following cleanly on small data?

## File locations

All files are in:
`C:\Users\tabea\OneDrive\Desktop\Clients\ME\tutorials\prompt_difficulty\Anthropic_Platform_Test\`

Key files:
- `capability_testing.xlsx` — Round 1 workbook (Agent Design, Round 1 Data, Results sheet)
- `capability_testing_round2.xlsx` — Round 2 workbook (Combination Design, Round 2 Results, Round 1 Data)
- `run_capability.py` — Round 1 runner
- `run_round2.py` — Round 2 runner

Supporting files in parent folder:
`C:\Users\tabea\OneDrive\Desktop\Clients\ME\tutorials\prompt_difficulty\`
- `Anthropic_Platform_Report.docx`
- `Anthropic_Round2_Results_Report.docx`
- `anthropic_platform_dashboard.html`
- `round2_dashboard.html`

## Round 3 design

**What changes:** Only the data payload size. Everything else stays identical —
same models, same rule sets, same user prompt, same judge.

**Payload sizes to test:**
- Small — current dataset (the existing Round 1 Data, ~10-15 rows)
- Medium — 2-3x the current data (add more quarters for NVDA and JPM)
- Large — 5x (add more tickers or more periods)
- XL — 10x (stress test, approaching context limits)

**What to hold constant:**
- Use the Round 1 category weights to pick which rule sets to test
- Test the two heaviest categories (Scope at 0.71 and Chained at 0.38) plus one zero-weight control
- Run all 7 tiers for each payload size
- Same 3 models

**The hypothesis:**
First failure tier drops as payload grows. A model that holds Scope rules at T4
on small data may fail at T1 on large data because the context is dominated by
the payload and the model loses track of its rules.

**What to build:**
1. Scaled datasets — 4 payload sizes of NVDA/JPM financial data
2. A new workbook: `capability_testing_round3.xlsx` with a Data Volume Design sheet
   and a Round 3 Results sheet
3. A runner: `run_round3.py` that loops through payload sizes × rule sets × tiers × models
4. Results report and dashboard after results come in

## Technical setup

- Python with anthropic and openpyxl libraries
- API key in environment as ANTHROPIC_API_KEY
- Judge model: claude-opus-4-8
- All workbooks are self-contained (data, design, results in same file)
- Rule separator in cells: " | " (pipe with spaces)
- Results sheet structure matches Round 1 and 2 (Model, Combo/Category, Tier, Rule Count,
  Active Rules, Rules Violated, Pass/Fail, Soft Score, First Failure Tier, Collapse, Notes)
  plus a new Payload Size column

## What to do in this session

1. Build the 4 scaled datasets (extend the NVDA/JPM data to create Medium, Large, XL payloads)
2. Create capability_testing_round3.xlsx with Cover, Data Volume Design, Round 3 Results,
   Scoring Guide sheets
3. Write run_round3.py
4. Run a dry run to validate before spending API budget
5. Run the test and analyse results
6. Write a results report and dashboard

## Key conventions to follow

- Workbook tabs colour coded: Cover=gold, Design=blue, Results=blue, Scoring=gold
- Rule cells use " | " as separator between rules, no label prefixes (no SCO-1: etc.)
- Each tier cell contains the full cumulative plain-text rules for that tier
- find_next_row() checks the Pass/Fail column (not col 1) to skip placeholder rows
- Validate rules before any API calls — check rule counts per tier are cumulative
- Save results incrementally (save workbook after each model completes)
