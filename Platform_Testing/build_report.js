const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        HeadingLevel, AlignmentType, BorderStyle, WidthType, ShadingType } = require('docx');
const fs = require('fs');

const border = { style: BorderStyle.SINGLE, size: 1, color: 'CCCCCC' };
const borders = { top: border, bottom: border, left: border, right: border };
const headerFill = { fill: '1F3864', type: ShadingType.CLEAR };
const altFill = { fill: 'F2F7FC', type: ShadingType.CLEAR };
const hardFill = { fill: 'FADADD', type: ShadingType.CLEAR };
const medFill = { fill: 'FFF3CD', type: ShadingType.CLEAR };
const easyFill = { fill: 'D4EDDA', type: ShadingType.CLEAR };
const exclFill = { fill: 'F0F0F0', type: ShadingType.CLEAR };
const whiteFill = { fill: 'FFFFFF', type: ShadingType.CLEAR };
const lightBlueFill = { fill: 'EAF1FB', type: ShadingType.CLEAR };
const promptFill = { fill: 'EBF5FB', type: ShadingType.CLEAR };
const codeFill = { fill: 'F8F9FA', type: ShadingType.CLEAR };

function cell(text, fill, bold=false, color='000000', size=18, align=AlignmentType.LEFT) {
  return new TableCell({
    borders, shading: fill,
    margins: { top: 80, bottom: 80, left: 120, right: 120 },
    children: [new Paragraph({ alignment: align, children: [new TextRun({ text, bold, size, color, font: 'Arial' })] })]
  });
}

function para(text, bold=false, size=20, spacingAfter=120) {
  return new Paragraph({
    spacing: { after: spacingAfter },
    children: [new TextRun({ text, bold, size, font: 'Arial' })]
  });
}

function heading1(text) {
  return new Paragraph({
    spacing: { before: 280, after: 140 },
    children: [new TextRun({ text, bold: true, size: 26, font: 'Arial', color: '1F3864' })]
  });
}

function heading2(text) {
  return new Paragraph({
    spacing: { before: 200, after: 100 },
    children: [new TextRun({ text, bold: true, size: 22, font: 'Arial', color: '2E5C8A' })]
  });
}

function spacer(after=200) {
  return new Paragraph({ children: [], spacing: { after } });
}

const doc = new Document({
  sections: [{
    properties: {
      page: {
        size: { width: 12240, height: 15840 },
        margin: { top: 1080, right: 1080, bottom: 1080, left: 1080 }
      }
    },
    children: [

      // ── Title block ──────────────────────────────────────────────
      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [10080],
        rows: [
          new TableRow({ children: [new TableCell({
            borders, shading: headerFill,
            margins: { top: 200, bottom: 120, left: 240, right: 240 },
            children: [
              new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: 'Round 1 Adapted Report', bold: true, size: 32, color: 'FFFFFF', font: 'Arial' })] }),
              new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: 'Single User Prompt  |  Category Difficulty Bands', size: 22, color: 'BDD7EE', font: 'Arial' })] }),
            ]
          })] }),
          new TableRow({ children: [new TableCell({
            borders, shading: lightBlueFill,
            margins: { top: 80, bottom: 80, left: 240, right: 240 },
            children: [
              new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: 'Models: claude-opus-4-8, claude-sonnet-4-6, claude-haiku-4-5  |  11 categories  |  7 tiers  |  Finance domain  |  Adapted from capability_testing.xlsx', size: 16, color: '444444', font: 'Arial' })] })
            ]
          })] })
        ]
      }),

      spacer(280),

      // ── Section 1: Single User Prompt ────────────────────────────
      heading1('1. Single User Prompt'),

      para('The original Round 4 test used 8 varying user prompts (UP1-UP8) across different ticker pairs and data sources. This adaptation replaces all 8 with one fixed prompt so that system prompt complexity (tier) is the only variable being tested.', false),

      spacer(160),

      // Prompt box
      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [10080],
        rows: [new TableRow({ children: [new TableCell({
          borders, shading: promptFill,
          margins: { top: 140, bottom: 140, left: 240, right: 240 },
          children: [
            new Paragraph({ spacing: { after: 80 }, children: [new TextRun({ text: 'Fixed User Prompt', bold: true, size: 20, font: 'Arial', color: '1F3864' })] }),
            new Paragraph({ spacing: { after: 100 }, children: [new TextRun({ text: '"Using only the attached data, summarise the most recent quarterly earnings performance, insider share activity, and daily price movement for Microsoft Corp (MSFT) and JPMorgan Chase & Co (JPM)."', italics: true, size: 20, font: 'Arial' })] }),
            new Paragraph({ children: [new TextRun({ text: 'Data sources required: earnings_and_insider.csv  |  prices.csv', size: 16, color: '666666', font: 'Arial' })] })
          ]
        })] })]
      }),

      spacer(160),

      para('Ticker selection rationale: MSFT and JPM are both confirmed present in the DJIA dataset (referenced in UP1 of the original Round 4 design). They represent contrasting sectors — technology vs. financials — which increases the probability that one ticker beats EPS estimates while the other shows distinct price volatility. This ensures the Situation and Chained conditional rules are genuinely triggered rather than vacuously satisfied across all tiers.', false, 18),

      spacer(160),

      // Rule coverage table
      heading2('Rule coverage'),
      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [2000, 1800, 6280],
        rows: [
          new TableRow({ children: [cell('Category', headerFill, true, 'FFFFFF', 18), cell('Rule Type', headerFill, true, 'FFFFFF', 18), cell('Why This Prompt Fires It', headerFill, true, 'FFFFFF', 18)] }),
          new TableRow({ children: [cell('Sco — Scope', altFill, true), cell('Grounding constraint', altFill), cell('"Using only the attached data" directly triggers the scope rule. The model cannot use prior knowledge, infer values, or draw conclusions not supported by the data.', altFill)] }),
          new TableRow({ children: [cell('Neg — Negation', whiteFill, true), cell('Forbidden words', whiteFill), cell('Describing earnings performance and price movement creates natural opportunities to use forbidden words (strong, robust, significant, notable, approximately). The prompt does not avoid these topics.', whiteFill)] }),
          new TableRow({ children: [cell('Sit — Situation', altFill, true), cell('Conditional (if/then)', altFill), cell('"Earnings performance" asks about EPS vs. estimate. This triggers the Beat: prefix rule and the T7 significant miss rule whenever conditions are met in the data.', altFill)] }),
          new TableRow({ children: [cell('Chn — Chained', whiteFill, true), cell('Two-condition logic', whiteFill), cell('"Daily price movement" and "insider share activity" together provide diff_pct and netShChg — both values required for the chained condition (diff_pct > 5% AND netShChg negative in the same ticker).', whiteFill)] }),
        ]
      }),

      spacer(300),

      // ── Section 2: Difficulty Bands ──────────────────────────────
      heading1('2. Category Difficulty Bands'),

      para('Each category is assigned a difficulty band — Easy, Medium, or Hard — based on its weight in the Round 1 results. Weights are derived empirically from observed failure rates across all three models and all seven tiers. They are not assigned by judgment.', false),

      spacer(160),

      // Formula box
      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [10080],
        rows: [new TableRow({ children: [new TableCell({
          borders, shading: codeFill,
          margins: { top: 100, bottom: 100, left: 200, right: 200 },
          children: [
            new Paragraph({ spacing: { after: 60 }, children: [new TextRun({ text: 'Weight formula', bold: true, size: 18, font: 'Arial' })] }),
            new Paragraph({ spacing: { after: 60 }, children: [new TextRun({ text: 'Weight  =  total failures across all models  /  (models x tiers)  =  (Opus fails + Sonnet fails + Haiku fails)  /  21', size: 17, font: 'Courier New' })] }),
            new Paragraph({ children: [new TextRun({ text: 'Range: 0 = no model ever failed this category.  1 = every model failed every tier.', size: 16, color: '555555', font: 'Arial' })] }),
          ]
        })] })]
      }),

      spacer(160),

      // Band threshold table
      heading2('Thresholds'),
      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [1600, 2000, 6480],
        rows: [
          new TableRow({ children: [cell('Band', headerFill, true, 'FFFFFF', 18), cell('Weight Threshold', headerFill, true, 'FFFFFF', 18), cell('Rationale', headerFill, true, 'FFFFFF', 18)] }),
          new TableRow({ children: [cell('Hard', hardFill, true, '8B0000'), cell('weight >= 0.50', hardFill), cell('Category fails the majority of runs across models. Scope (0.71) is the only Hard category — all three models failed from T2 onward, making it the primary driver of the weighted score penalty.', hardFill)] }),
          new TableRow({ children: [cell('Medium', medFill, true, '7D5A00'), cell('0.20 <= weight < 0.50', medFill), cell('Category fails roughly one-third to half of all runs. Conditional and chained logic (Situation 0.38, Chained 0.38) fall here — models can handle them at low tier counts but degrade under rule accumulation.', medFill)] }),
          new TableRow({ children: [cell('Easy', easyFill, true, '155724'), cell('0 < weight < 0.20', easyFill), cell('Category rarely fails. Word-level constraints (Negation 0.19, Persona 0.10, Format/Example/Precision 0.05) are tractable even at T7. Included in weighted scoring but with low penalty.', easyFill)] }),
          new TableRow({ children: [cell('Excluded', exclFill, false, '888888'), cell('weight = 0', exclFill), cell('No model ever failed. Content, Style, and Priority contributed zero failures. They carry no discriminative value for cross-category testing and are excluded from weighted score calculations.', exclFill, false, '888888')] }),
        ]
      }),

      spacer(200),

      // Full category band table
      heading2('All 11 categories with bands'),
      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [2400, 1200, 1200, 1200, 1280, 2800],
        rows: [
          new TableRow({ children: [
            cell('Category', headerFill, true, 'FFFFFF', 18),
            cell('Fails / 21', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Weight', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Band', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Platform Score', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Notes', headerFill, true, 'FFFFFF', 18),
          ] }),
          new TableRow({ children: [cell('Sco — Scope', hardFill, true), cell('15 / 21', hardFill, false, '000000', 18, AlignmentType.CENTER), cell('0.71', hardFill, true, '8B0000', 18, AlignmentType.CENTER), cell('Hard', hardFill, true, '8B0000', 18, AlignmentType.CENTER), cell('29%', hardFill, false, '000000', 18, AlignmentType.CENTER), cell('All models failed from T2. Highest-impact category.', hardFill)] }),
          new TableRow({ children: [cell('Sit — Situation', medFill, true), cell('8 / 21', medFill, false, '000000', 18, AlignmentType.CENTER), cell('0.38', medFill, true, '7D5A00', 18, AlignmentType.CENTER), cell('Medium', medFill, true, '7D5A00', 18, AlignmentType.CENTER), cell('62%', medFill, false, '000000', 18, AlignmentType.CENTER), cell('Opus 7/7. Sonnet 5/7. Haiku 1/7. Sharpest model-tier step function.', medFill)] }),
          new TableRow({ children: [cell('Chn — Chained', medFill, true), cell('8 / 21', medFill, false, '000000', 18, AlignmentType.CENTER), cell('0.38', medFill, true, '7D5A00', 18, AlignmentType.CENTER), cell('Medium', medFill, true, '7D5A00', 18, AlignmentType.CENTER), cell('62%', medFill, false, '000000', 18, AlignmentType.CENTER), cell('First fail: Opus T6, Sonnet T5, Haiku T4. Tracks model size directly.', medFill)] }),
          new TableRow({ children: [cell('Neg — Negation', easyFill, true), cell('4 / 21', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('0.19', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('Easy', easyFill, true, '155724', 18, AlignmentType.CENTER), cell('81%', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('Highest-weight Easy category. Word constraints tractable across all tiers.', easyFill)] }),
          new TableRow({ children: [cell('Per — Persona', easyFill), cell('2 / 21', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('0.10', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('Easy', easyFill, true, '155724', 18, AlignmentType.CENTER), cell('90%', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('Low failure rate across all models and tiers.', easyFill)] }),
          new TableRow({ children: [cell('Fmt / Exa / Pre', easyFill), cell('1 / 21', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('0.05', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('Easy', easyFill, true, '155724', 18, AlignmentType.CENTER), cell('95%', easyFill, false, '000000', 18, AlignmentType.CENTER), cell('Near-zero failure rate. Mechanical rule-following well within model capacity.', easyFill)] }),
          new TableRow({ children: [cell('Cnt / Sty / Pri', exclFill), cell('0 / 21', exclFill, false, '888888', 18, AlignmentType.CENTER), cell('0.00', exclFill, false, '888888', 18, AlignmentType.CENTER), cell('Excluded', exclFill, false, '888888', 18, AlignmentType.CENTER), cell('100%', exclFill, false, '888888', 18, AlignmentType.CENTER), cell('Perfect scores. No discriminative value for cross-category testing.', exclFill, false, '888888')] }),
        ]
      }),

      spacer(300),

      // ── Section 3: Methodology ───────────────────────────────────
      heading1('3. How Round 1 Results Determine Easy / Medium / Hard'),

      para('The difficulty bands are not assigned by judgment — they emerge directly from the observed failure distribution in Round 1. The five steps below show the derivation.', false),
      spacer(160),

      para('Step 1 — Count failures per category across all models and tiers', true, 20),
      para('Each category was tested at 7 tiers across 3 models = 21 possible passes per category. The raw failure count becomes the numerator of the weight formula. Categories with more platform-wide failures are harder by definition.', false, 18),
      spacer(100),

      para('Step 2 — Compute category weight (normalised failure rate)', true, 20),
      para('Weight = failures / 21. This converts raw counts to a 0-1 scale. A weight of 0.71 means 71% of all model-tier combinations failed that category. The scale is platform-specific — it reflects difficulty on the Anthropic API with this dataset, not a universal measure.', false, 18),
      spacer(100),

      para('Step 3 — Identify natural breaks in the weight distribution', true, 20),
      para('The 11 categories produce a clustered distribution. No category sits between 0.19 and 0.38, and none sits between 0.38 and 0.71. The thresholds at 0.20 and 0.50 fall at natural gaps in the data — the breaks are data-driven, not arbitrary cutoffs.', false, 18),
      spacer(100),

      para('Step 4 — Assign bands', true, 20),
      para('Hard: weight >= 0.50 (Scope only). Medium: 0.20 <= weight < 0.50 (Situation, Chained). Easy: 0 < weight < 0.20 (Negation, Persona, Format, Example, Precision). Excluded: weight = 0 (Content, Style, Priority).', false, 18),
      spacer(100),

      para('Step 5 — Apply to cross-category design', true, 20),
      para('In a cross-category test, bands predict relative difficulty and expected failure tier. A system prompt combining Hard + Medium categories will degrade faster than one combining Easy + Medium. The weighted score formula carries this forward: failures on Hard categories penalise the overall score more than failures on Easy ones — which is why raw scores (unweighted) consistently overstate model performance relative to weighted scores.', false, 18),

      spacer(300),

      // ── Section 4: Per-model baseline ───────────────────────────
      heading1('4. Round 1 Per-Model Performance (Baseline)'),

      para('Scores carried forward as the baseline for cross-category testing. Weighted scores apply platform-derived weights — failures on Hard categories count more than failures on Easy ones.', false),
      spacer(160),

      new Table({
        width: { size: 10080, type: WidthType.DXA },
        columnWidths: [2800, 1560, 1560, 1800, 2360],
        rows: [
          new TableRow({ children: [
            cell('Model', headerFill, true, 'FFFFFF', 18),
            cell('Raw Passes', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Raw Score', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Weighted Score', headerFill, true, 'FFFFFF', 18, AlignmentType.CENTER),
            cell('Notes', headerFill, true, 'FFFFFF', 18),
          ] }),
          new TableRow({ children: [cell('claude-opus-4-8', altFill, true), cell('71 / 77', altFill, false, '000000', 18, AlignmentType.CENTER), cell('92%', altFill, false, '000000', 18, AlignmentType.CENTER), cell('78%', altFill, true, '000000', 18, AlignmentType.CENTER), cell('14-point gap: failures concentrated in Scope (Hard).', altFill)] }),
          new TableRow({ children: [cell('claude-sonnet-4-6', whiteFill, true), cell('65 / 77', whiteFill, false, '000000', 18, AlignmentType.CENTER), cell('84%', whiteFill, false, '000000', 18, AlignmentType.CENTER), cell('52%', whiteFill, true, '8B0000', 18, AlignmentType.CENTER), cell('32-point gap: Scope failures dominant; Situation also degraded.', whiteFill)] }),
          new TableRow({ children: [cell('claude-haiku-4-5', altFill, true), cell('55 / 77', altFill, false, '000000', 18, AlignmentType.CENTER), cell('71%', altFill, false, '000000', 18, AlignmentType.CENTER), cell('36%', altFill, true, '8B0000', 18, AlignmentType.CENTER), cell('35-point gap: failed Hard and Medium categories heavily from early tiers.', altFill)] }),
        ]
      }),

      spacer(200),

      para('The gap between raw and weighted score reveals how much failures concentrated in high-difficulty categories. A 14-point gap (Opus) indicates failures spread across categories. A 32-35 point gap (Sonnet, Haiku) indicates failures concentrated in Hard and Medium categories — exactly the pattern cross-category testing is designed to stress.', false, 18),

    ]
  }]
});

Packer.toBuffer(doc).then(buf => {
  fs.writeFileSync('Round1_Adapted_Report.docx', buf);
  console.log('Done — Round1_Adapted_Report.docx written');
}).catch(err => console.error(err));
