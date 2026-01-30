---
title: "RM-5010: 2× LM317 LED dimming with shared potentiometer (prototype build)"
section: "Technical Notes"
category: "Audio Electronics"
tags:
  - Rotel RM-5010
  - LED
  - LM317
  - Dimming
  - Power Supply
  - Prototyping
date: 2026-01-17
status: draft
summary: "Step-by-step prototype guide for dimming the RM-5010 dial LEDs using two LM317 constant-current regulators and one shared potentiometer (two parallel 2-LED strings per regulator)."
---

## Scope and intent

This page describes a **prototype-board** implementation of a **2× LM317 constant-current dimmer** for the RM-5010 dial illumination LED strings using a **single shared potentiometer**.

This approach is relevant when PWM dimming is undesirable (e.g., RF interference concerns), and you still want adjustable brightness.

## Preconditions and assumptions

- LED supply is **smoothed DC** derived from the RM lamp winding (measured previously at approximately **15–16 V DC** at the reservoir capacitor).
- You have **4 LED strings**, each string is: **(LED + LED) + series resistor** (one resistor per string on the LED PCB).
- This guide groups the 4 strings into **two groups**, each group containing **two strings in parallel**.
- This guide avoids guessing LED forward voltage and does not depend on exact Vf, beyond needing adequate LM317 headroom (which is why this is a *two-LED-per-string* grouping, not four-in-series).

## Overview of the 2× LM317 grouping

- **LM317 #1** drives **LED Group A** = two parallel strings
- **LM317 #2** drives **LED Group B** = two parallel strings
- Each LM317 is configured as a **constant-current source** set to approximately **~38–40 mA total**, so each of the two strings in that group runs at roughly **~19–20 mA**.
- A **shared potentiometer** adjusts the current (and therefore brightness) for both LM317 regulators together.

### Diagram: electrical concept

{{< figure
    src="/images/projects/rotel-rm-5010-restore/improvements/refactors/lm317-2reg-shared-pot-schematic-v2.png"
    caption="Shematic(click to view full size)"
    link="/images/projects/rotel-rm-5010-restore/improvements/refactors/lm317-2reg-shared-pot-schematic-v2.png"
    width="500"
>}}
<!-- ![2× LM317 shared-pot schematic](/images/projects/rotel-rm-5010-restore/improvements/refactors/lm317-2reg-shared-pot-schematic-v2.png) -->

## Bill of materials (prototype)

For the **2× LM317** approach:

- 2 × LM317T (TO-220)
- 2 × **Rset = 33 Ω**, **0.5 W** (one per LM317)
- 4 × **Rbal = 10–22 Ω**, **0.25 W** (one per LED string; enforces current sharing inside each parallel pair)
- 1 × **Potentiometer = 250 Ω, linear**, used as a 2-terminal variable resistor (wiper tied to one end)
- 2 × **Radj = 100 Ω**, **0.25 W** (one per LM317 ADJ feed into the shared pot node; helps prevent interaction)
- Optional (recommended):
  - 2 × **100 nF** capacitors (one per LM317) from **IN → 0V**, placed physically close to the regulator pins (local decoupling)
- Heat management:
  - 2 × small TO-220 heatsinks (recommended)

## Step-by-step build guide (prototype board)

### Step 1 — Decide the LED grouping

1. Identify your four existing 2-LED strings (each with its own series resistor on the LED PCB).
2. Assign them:
   - **Group A**: String A1 + String A2
   - **Group B**: String B1 + String B2

Keep the two strings in each group as physically similar as possible.

### Step 2 — Prepare the prototype board rails

On a prototyping board (stripboard or similar):

- Create a **+VLED rail** (incoming ~15–16 V DC).
- Create a **0V rail** (return).

Bring in the supply from your **reservoir capacitor + and −**.

### Step 3 — Mount the two LM317s

Mount **two LM317T** regulators on the board with room for heatsinks.

**Pin order (front view, text facing you):**
- IN — OUT — ADJ

Wire:
- LM317 **IN** → +VLED rail
- LM317 **OUT** → its **group output node**
- LM317 **ADJ** → current-set network (next step)

### Step 4 — Set constant current for each group (Rset)

For each LM317:

- Fit **Rset = 33 Ω (0.5 W)** between **OUT and ADJ**.

This sets group current approximately:
- I ≈ 1.25 V / 33 Ω ≈ 38 mA

### Step 5 — Add the shared potentiometer dimming network

Create a shared “pot node”:

1. Wire **Radj1 = 100 Ω** from **LM317 #1 ADJ** to the **pot node**.
2. Wire **Radj2 = 100 Ω** from **LM317 #2 ADJ** to the **pot node**.
3. Wire the **potentiometer (250 Ω linear)** as a **2-terminal variable resistor**:
   - Tie **wiper to one end**
   - Connect the tied pair to the **pot node**
   - Connect the remaining end of the pot to **0V**

This arrangement reduces regulator interaction while allowing one knob to dim both groups.

### Step 6 — Add current sharing (Rbal) for each string

For each LED string (4 total), add a **small ballast resistor** in series:

- **Rbal = 10–22 Ω** in series with the string feed.

Placement options:
- On the prototype board at each string output, or
- On the LED PCB input per-string feed (if accessible)

Purpose:
- Enforces current sharing between two parallel strings within a group.

### Step 7 — Connect each LM317 output to its LED group

- LM317 #1 OUT → Group A feed node → splits to two strings (each via Rbal) → returns to 0V.
- LM317 #2 OUT → Group B feed node → splits to two strings (each via Rbal) → returns to 0V.

### Step 8 — Add local decoupling (recommended)

Place **100 nF** from each LM317 **IN → 0V** close to the pins.

### Step 9 — First power-up checks

Before powering:
- Confirm polarity: +VLED and 0V are correct.
- Confirm no shorts between rails.

Power on and verify:
1. Both strings in Group A illuminate.
2. Both strings in Group B illuminate.
3. Turning the pot changes brightness smoothly.

#### Quick current sanity check (non-invasive)
Measure voltage across each **Rbal**:
- I_string ≈ V_Rbal / Rbal
- Example: 0.22 V across 11 Ω ≈ 20 mA.

## Diagram: prototyping-board placement (concept)

This is a **conceptual** placement diagram (not a to-scale cut map). It shows how to keep rails and routing compact.

{{< figure
    src="/images/projects/rotel-rm-5010-restore/improvements/refactors/lm317-2reg-shared-pot-stripboard-concept-v2.png"
    caption="Stripboard layout (click to view full size)"
    link="/images/projects/rotel-rm-5010-restore/improvements/refactors/lm317-2reg-shared-pot-stripboard-concept-v2.png"
    width="500"
>}}
<!-- ![Stripboard concept layout](/images/projects/rotel-rm-5010-restore/improvements/refactors/lm317-2reg-shared-pot-stripboard-concept-v2.png) -->

## Notes and cautions

- This approach is **linear** and will dissipate heat in the LM317s.
- Do not omit **Rbal** when running **parallel strings** from a single constant-current source.
- Keep LED wiring as paired feed/return to minimise loop area.
- If you later decide to remove dimming, a fixed resistor-only approach is simpler and cooler.

## Open items / future work

- Convert the concept layout into a specific stripboard **track-cut map** for the exact board you are using.
- Confirm long-term regulator temperature in the RM-5010 enclosure with LEDs at maximum brightness.
