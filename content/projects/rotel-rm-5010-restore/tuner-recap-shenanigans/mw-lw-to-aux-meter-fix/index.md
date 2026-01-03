---
title: "MW/LW → AUX Repurpose: Tuning Meter Pegging and Flicker Fix"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - AUX
  - MW
  - LW
  - selector-switch
  - meter
  - tuning-meter
date: 2026-01-02
status: "draft"
summary: "After repurposing MW/LW to AUX, the tuning meter pegged hard right. Passive clamping and damping stabilised it."
---

After repurposing the MW/LW position on the selector switch to behave as an AUX input, a side effect appeared:

- The **tuning meter** strained to the **right-hand extreme** when the (now AUX) MW/LW mode was selected.

The AUX audio itself worked fine.

## Why this happens

The tuning meter is normally driven by tuner-derived DC (AGC/detector related). When MW/LW is selected but the AM tuner path is no longer used (or is effectively off-tune), the control voltage can rail, pegging the meter. This is separate from the audio path.

## Passive fix (no spare switch poles required)

Goal: prevent hard-over deflection and reduce flicker without impacting normal FM operation.

### Step 1: Clamp/bleed resistor

- Add **10 kΩ–22 kΩ** from the meter drive node to ground.
- Start with **22 kΩ**; reduce to 10 kΩ if needed.

Result:
- meter becomes more centred, but may flicker due to residual noise/ripple.

### Step 2: Add damping capacitor (to stop flicker)

Add a capacitor from the meter drive node to ground:

- **1 µF to 4.7 µF** electrolytic (≥16 V)
- polarity: **+ to meter drive node**, **– to ground**

This forms an RC low-pass with the bleed resistor and removes jitter.

Guidance:
- 22 kΩ + 1 µF is a good starting point.
- Increase capacitor value if flicker persists.
- Avoid very large capacitance that makes the meter sluggish in FM.

