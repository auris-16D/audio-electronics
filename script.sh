#!/usr/bin/env bash
set -euo pipefail

# Hugo content root (edit if your repo uses a different path)
ROOT="content/projects/rotel-rm-5010-restore/tuner-recap-shenanigans"
mkdir -p "$ROOT"

# 1) Index / hub page
cat > "$ROOT/_index.md" <<'EOF'
---
title: "RM-5010 Tuner Recap Shenanigans"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - FM
  - tuner
  - HA1137W
  - HA1156W
  - uPC30C
  - recap
  - diagnostics
  - flux
  - EMI
  - PWM
date: 2026-01-02
status: "draft"
summary: "A full write-up of the FM tuner recap journey: false IC failures, flux contamination, PWM LED interference, and the path back to stable stereo FM."
---

This is the hub page for the RM-5010 tuner recap journey. It links to the detailed pages that capture the full troubleshooting narrative, what was measured, what was concluded (sometimes incorrectly), and what ultimately fixed the behaviour.

## Pages in this series

- **Timeline & diagnostics narrative**: see `tuner-diagnostics-timeline/`
- **IC notes & interaction (HA1137W / HA1156W / uPC30C)**: see `tuner-ics-and-signal-flow/`
- **Flux contamination: the real root cause**: see `flux-contamination-and-false-faults/`
- **LED PWM interference & how twisting pairs fixed FM noise**: see `led-pwm-emi-and-fm-noise/`
- **Future improvement: LM317 linear LED dimmer (silent FM)**: see `lm317-linear-led-dimmer/`
- **MW/LW → AUX repurpose side-effect: tuning meter pegging & damping**: see `mw-lw-to-aux-meter-fix/`

## Quick summary

- Stereo and audio faults were repeatedly consistent with **contamination/leakage** on high-impedance tuner nodes.
- Multiple “IC failure” hypotheses were tested (including cross-swaps) but behaviour strongly correlated with:
  - **flux residue** and cleaning quality, and
  - **EMI injection** from a PWM LED circuit.
- After proper cleaning and wiring changes, the FM tuner returned to stable operation:
  - Stereo lamp only indicates near strong signal
  - Audio output to both speakers is restored
  - Remaining “tuning seems off” symptoms were later found to be dominated by LED PWM noise coupling (not alignment).

EOF

# 2) Timeline / diagnostics narrative
mkdir -p "$ROOT/tuner-diagnostics-timeline"
cat > "$ROOT/tuner-diagnostics-timeline/index.md" <<'EOF'
---
title: "RM-5010 FM Tuner Diagnostics Timeline"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - FM
  - diagnostics
  - recap
  - HA1137W
  - HA1156W
  - muting
  - stereo-lamp
  - flux
date: 2026-01-02
status: "draft"
summary: "Chronological diagnostic record: what was observed, what was measured, and how conclusions evolved (including wrong turns)."
---

This page captures the chronological diagnostic path taken while chasing the RM-5010 FM tuner issues after a tuner-board recap. It deliberately preserves the *evolution* of the diagnosis, including incorrect hypotheses, because that was part of the learning.

## Initial symptom set (post-recap context)

- Stereo lamp behaviour abnormal (at times: **no lock**, later **permanently illuminated**).
- Audio and stereo decode behaviour inconsistent with signal strength.
- Multiple measurements suggested the stereo chain was not receiving a clean MPX/composite feed.
- The tuner behaviour sometimes changed after warm-up or after additional probing/soldering.

## Early working model

We focused on the FM stereo chain and three ICs present in the tuner subsystem:

- **HA1137W**: FM IF / detector / control-related functions; provides a composite/AF path toward the stereo decoder.
- **HA1156W**: stereo decoder (pilot, switching demod, L/R audio, stereo indicator behaviour).
- **uPC30C**: system/control interface interacting with the FM chain (muting/control-level interactions).

The working theory was that one IC (or a coupling component between them) was responsible for the stereo lamp and audio symptoms.

## Key traced connection (confirmed)

A critical physical trace/continuity confirmation was made:

- **HA1156 pin 2** is fed via a coupling capacitor from **HA1137 pin 6**.
- This established HA1137 pin 6 as the *intended* source feeding the HA1156 input node.

This became the main diagnostic spine: if pin 6 is wrong, HA1156 cannot decode properly.

## Muting pin behaviour (HA1137 pin 12)

We identified **pin 12** as the muting-related pin and measured it versus signal strength:

- Strong tuned station (confirmed with audio probe & tuning meter): **~40 mV**
- Weak signal: **~1.6 V**
- No signal: **~2.3 V**

This behaviour matches the idea of a thresholded muting function: low voltage corresponds to mute released; higher voltage corresponds to mute active.

Later, additional pin 12 readings were also noted in a different context (and on a different tuner), reinforcing that absolute values can vary by implementation, but on/off-station trend is what matters.

## Pin 6 vs pin 7 confusion resolved

At one point audio was heard on a HA1137 pin believed to be “pin 7”, but later continuity work confirmed:

- The HA1156 feed goes to **HA1137 pin 6**, not pin 7.
- Pin 7 was associated with other functions (including meter-related paths) and could carry “audio-ish” content without being the actual composite feed to HA1156.

## “471K” capacitor episode

A small capacitor (“471K” marking) associated with HA1156 timing / PLL areas was replaced with a **~470/471 pF** capacitor.

- After replacement, behaviour did not improve.
- At various points, additional symptoms appeared (including more severe loss of signal to HA1156), which later turned out to be strongly correlated with contamination / rework side effects.

## VR101 discussion

VR101 (on/near HA1156 timing network) was discussed as an adjustment point; it was treated cautiously due to risk of turning the wrong control without a service manual.

- Observations suggested VR101 might have been set to an extreme.
- A theory was developed that historical drift could have caused past “compensation adjustments.”
- Ultimately, later evidence indicated that adjustment was not the primary fix; contamination and EMI were.

## Misleading “IC failure” hypothesis and cross-swap attempts

A donor tuner (JVC JT-V11G) using the same **HA1137W** was used to compare behaviour.

- Initially, swapping the RM HA1137W into the JVC appeared to work, then later the JVC developed similar faults after time.
- Cooling attempts were tried; results were inconsistent (and introduced moisture risk).
- Eventually, the pattern pointed away from a clean “bad IC” story and toward rework/contamination effects that could reappear after handling and heating.

This portion is retained because it illustrates how easily contamination can mimic thermal IC failure.

## The actual turning points

Two turning points ultimately explained the “mystery” symptoms:

1) **Flux contamination / leakage** on the tuner board created bias shifts and false thresholds.  
2) **LED PWM interference** injected noise into the FM path, masquerading as weak signal / poor tuning.

Both were consistent with:
- symptoms appearing after warm-up,
- instability following soldering/probing,
- and dramatic improvement after cleaning and wiring changes.

## Outcome after cleaning

After re-soldering HA1137W in the RM and performing more thorough cleaning:

- Stereo lamp stopped being permanently on and became correlated with station strength.
- Audio returned cleanly to both speakers.

Subsequently, additional “tuning seems off” behaviour was traced to LED PWM noise (see dedicated page).

EOF

# 3) IC notes & interaction page (collated, not just summary)
mkdir -p "$ROOT/tuner-ics-and-signal-flow"
cat > "$ROOT/tuner-ics-and-signal-flow/index.md" <<'EOF'
---
title: "RM-5010 FM Chain: HA1137W, HA1156W, uPC30C"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - FM
  - HA1137W
  - HA1156W
  - uPC30C
  - stereo-decoder
  - muting
  - signal-flow
date: 2026-01-02
status: "draft"
summary: "Collated notes from datasheets + board tracing: roles, interconnects, key pins, and what was proven on the RM."
---

This page collates the *practical* extraction work done from datasheets and board tracing for the three FM-related ICs used in the RM-5010 tuner chain. The intent is to help others diagnose similar issues in the absence of a service manual.

## Datasheet links

If local copies are not stored in this repo, these were referenced:

- HA1137W datasheet: https://datasheet4u.com/pdf-down/H/A/1/HA1137W_Hitachi.pdf
- HA1156W datasheet: https://datasheet4u.com/pdf-down/H/A/1/HA1156W_HitachiSemiconductor.pdf

## High-level functional blocks and interaction



## FM stereo signal flow (RM-5010 – proven on PCB)

```text
FM IF / discriminator output (composite MPX)
│
├─> HA1137W  (FM IF / detector / AF + control interface)
│        │
│        └─> Composite feed toward stereo decoder
│             (PCB continuity confirmed: HA1137 pin 6)
│
└─> HA1156W  (stereo decoder: pilot detect, reference, switching demodulation)
         │
         ├─> Left audio output
         └─> Right audio output
Notes:

HA1137 pin 6 → coupling capacitor → HA1156 pin 2 was physically traced and continuity-verified.

Audio or “audio-like” content elsewhere (e.g. HA1137 pin 7) must not be mistaken for the MPX feed.

Flux contamination on this path was sufficient to completely suppress stereo decode while leaving RF/IF apparently functional.


### Why this matters (explicitly)
- This diagram was **central to the diagnostic breakthrough**
- It anchors:
  - why HA1137 pin 6 mattered,
  - why HA1156 initially appeared “dead”,
  - and how contamination + EMI mimicked IC failure
- Having it **inside the Hugo source** (not just chat text) preserves the learning for others

If you want, next we can:
- tighten the wording around *“composite MPX vs AF-like signals”*, or
- add a **second diagram** showing *how PWM LED noise coupled in* (radiated vs ground paths) using the same style.


**uPC30C** participates as a system-level control/muting interface interacting with the FM chain (implementation-specific wiring).

## HA1137W in this project

### Role (project interpretation)

- Provides an interface between the FM IF/detector stages and the downstream decoder/control circuitry.
- Exposes a node that feeds the stereo decoder input in the RM (proven via continuity).

### Key pin confirmations (RM-specific)

- **HA1137 pin 6**: confirmed by continuity to the coupling capacitor that feeds **HA1156 pin 2**.
- **HA1137 pin 12**: used as a muting-related pin in the diagnostic work; it demonstrated signal-strength-dependent voltage.

### Muting pin behaviour (measured)

These are the HA1137 pin 12 DC voltages measured on the RM:

- Strong tuned station: **~40 mV**
- Weak signal: **~1.6 V**
- No signal: **~2.3 V**

(Interpreted as “mute released on strong station, asserted as signal weakens.”)

### Output node behaviour (pin 6)

At various points pin 6 was probed with:
- audio probe (with series capacitor),
- oscilloscope (AC coupled).

The key learning: pin 6 is highly sensitive to leakage/contamination and to downstream loading; flux residue can make it appear “dead” or “unresponsive” even when the RF chain is otherwise alive.

## HA1156W in this project

### Role (project interpretation)

- Stereo decoder receiving the composite/MPX feed.
- Provides stereo separation and stereo-indication behaviour dependent on pilot lock and decoder state.

### Proven interconnect

- **HA1156 pin 2** receives signal via coupling capacitor from **HA1137 pin 6**.

### VR101 and timing network discussions

A variable resistor (VR101) associated with timing/PLL behaviour was discussed and treated as high-risk to adjust blindly. The take-away:

- Adjustment should not be used to “fix” contamination or EMI issues.
- Only consider alignment/adjustment after the circuit is clean and quiet and after confirming signal integrity into the decoder.

## uPC30C in this project

### Role (project interpretation)

- System-level control/muting interface interacting with the FM chain.
- In the broader troubleshooting, uPC30C was considered as a possible contributor to muting/stereo lamp behaviour depending on wiring.

Because the RM-5010 lacks a service manual, the most reliable method here was board tracing and pin-level confirmation rather than assumptions.

## Practical diagnostic guidance (service-manual-free)

If you have RM-5010 FM stereo issues:

1) Prove the interconnect:
   - confirm continuity: **HA1137 pin 6 → coupling cap → HA1156 pin 2**.

2) Measure muting node trend:
   - HA1137 pin 12 should trend “released on strong station, asserted off-station.”

3) Verify MPX presence:
   - pin 6 should show increased activity on strong station *relative to off-station*.
   - If it doesn’t, first suspect **contamination/flux leakage** before suspecting the IC.

4) Only after the above:
   - consider decoder alignment/adjustment.

EOF

# 4) Flux contamination page (core learning)
mkdir -p "$ROOT/flux-contamination-and-false-faults"
cat > "$ROOT/flux-contamination-and-false-faults/index.md" <<'EOF'
---
title: "Flux Contamination: The Root Cause That Mimicked IC Failure"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - flux
  - contamination
  - leakage
  - FM
  - diagnostics
  - HA1137W
  - HA1156W
date: 2026-01-02
status: "draft"
summary: "How flux residue created leakage paths that produced time-dependent faults, false IC hypotheses, and misleading measurements."
---

This is the most important learning outcome from the RM-5010 tuner work: **flux residue can create leakage paths** that are large enough to upset high-impedance analogue circuitry, yet subtle enough to masquerade as “intermittent IC failure” or “alignment drift.”

## What triggered the insight

A separate LED PCB project produced repeated failures after ~10 minutes:
- flicker
- smoke-like behaviour
- intermittent operation

In every case, the cause was flux residue left after soldering. Once the flux was properly removed (which was not easy with IPA alone), the problems disappeared.

That experience mapped directly onto the RM-5010 FM tuner symptoms: similar time-dependent behaviour, threshold weirdness, and “impossible” measurement patterns.

## Why flux breaks FM circuits

FM detector / muting / stereo-decoder circuits contain nodes that:
- are high impedance,
- operate on small DC offsets,
- use thresholds (mute release, stereo detect),
- and are sensitive to microamps of leakage.

Flux residue can:
- absorb moisture,
- become slightly conductive,
- create kΩ–MΩ leakage paths between pins and traces,
- change behaviour as the board warms.

## How this derailed diagnosis (and why it looked like IC failure)

Symptoms created or exaggerated by contamination included:
- stereo lamp stuck on or off
- audio disappearing after warm-up
- “weak signal” behaviour on a strong station
- pin-level DC voltages that moved with time
- test results that changed after rework / probing

At multiple points, contamination was suggested as the likely cause, but it was not immediately treated as the primary hypothesis until the LED PCB experience made the mechanism undeniable.

## What fixed the RM-5010 FM behaviour

After re-soldering the HA1137W and performing a thorough cleaning pass on the tuner board:
- Stereo lamp stopped being permanently on and became correlated with strong signals.
- FM audio output returned to both speakers.
- The system behaviour became stable instead of time-dependent.

## Cleaning notes (practical)

IPA alone may smear certain flux residues rather than remove them. Effective approaches:

- Dedicated flux remover (preferred).
- Mechanical action (brush while wet) and *wicking* dissolved residue away.
- Repeat cycles of dissolve → brush → wick → rinse.

## Diagnostic principle to keep

When faults:
- appear after soldering,
- change with time/warm-up,
- follow rework,
- and involve thresholds (mute/stereo),

**assume contamination first** until proven otherwise.

EOF

# 5) LED PWM EMI page
mkdir -p "$ROOT/led-pwm-emi-and-fm-noise"
cat > "$ROOT/led-pwm-emi-and-fm-noise/index.md" <<'EOF'
---
title: "LED PWM EMI: The Hidden FM ‘Weak Signal’ Generator"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - EMI
  - PWM
  - LEDs
  - FM
  - interference
  - wiring
date: 2026-01-02
status: "draft"
summary: "FM sounded misaligned until we discovered the real cause: PWM LED wiring radiated noise into the tuner. Twisting pairs fixed it."
---

After cleaning restored correct stereo decode and audio, a remaining symptom looked like “tuning is off / weak signal / lots of hiss.” The real cause was not alignment: it was **interference caused by the LED PWM circuit**.

## The decisive observation

- FM reception is **perfect** when the LED circuit is **off**.
- FM becomes noisy (weak-signal-like hiss) when the LED circuit is **on**.

This immediately indicates the tuner itself is not “misaligned”: it is being *polluted*.

## Why external powering didn’t eliminate it

Even powering the LED PWM from an external 14 V supply did not eliminate the interference. This indicates the dominant coupling mode was **radiated EMI** (wiring/PCB acting as an antenna), not simply supply ripple injected through the RM power rails.

## The confirmation test

- Noise was much lower at **100% brightness** than at partial brightness.

That is classic PWM behaviour: at 100% duty there are fewer switching edges; at partial duty, there are constant fast edges which produce broadband noise.

## Fix that worked immediately

- **Twisting the LED + and LED – wires tightly** (twisted pair) significantly reduced the interference.

This reduces loop area and cancels radiated magnetic fields, preventing the LED wiring from acting like an antenna.

## Recommended hardening steps (if needed)

- Keep LED wiring short and routed away from:
  - the tuner front end (tuning capacitor area),
  - antenna lead,
  - IF/discriminator sections.
- Add ferrites near the PWM output and/or at LED boards.
- Add local decoupling at each LED PCB:
  - 100 nF ceramic across LED supply,
  - 10–47 µF electrolytic across LED supply.

## Alignment warning

Do not attempt FM alignment while PWM interference is present. You will “align to the noise” and make true reception worse once the interference is removed.

EOF

# 6) LM317 future improvement page
mkdir -p "$ROOT/lm317-linear-led-dimmer"
cat > "$ROOT/lm317-linear-led-dimmer/index.md" <<'EOF'
---
title: "Future Improvement: LM317 Linear LED Dimmer (No PWM EMI)"
section: "Technical Notes"
category: "Rotel RM-5010"
tags:
  - LEDs
  - LM317
  - dimmer
  - EMI
  - PWM
date: 2026-01-02
status: "draft"
summary: "A quiet alternative to PWM dimming: LM317 linear regulator feeding the LED strings for FM-friendly illumination."
---

To eliminate PWM-generated RF noise entirely, a linear dimming approach can be used. This trades efficiency for silence.

## LED load summary (existing)

- 4 sets of 2 LEDs
- each set has a **470 Ω** resistor
- supply derived from **12 VAC → bridge → 6800 µF reservoir**
- expected DC at reservoir: roughly **15–16 V** (12 VAC RMS ≈ 17 V peak minus bridge drop)
- estimated current per string (typical white LEDs): ~18 mA
- total current ~70–80 mA

## Proposed linear dimmer (LM317 adjustable regulator)

Use an LM317 as an adjustable voltage regulator feeding the LED “+” rail (keep each 470 Ω string resistor).

### Parts

- LM317T (TO-220)
- R1: 240 Ω (OUT → ADJ)
- Pot: 2 kΩ linear (ADJ → GND)
- Rmin: 1.0 kΩ fixed resistor in series with the pot (to keep minimum output above LED conduction)
- Cin: 0.1 µF ceramic (IN → GND, close to LM317)
- Cout: 10 µF electrolytic (OUT → GND, close to LM317)
- D1: 1N400x from OUT to IN (anode OUT, cathode IN)
- D2: 1N4148 (or 1N400x) from ADJ to OUT (anode ADJ, cathode OUT)

### Why Rmin = 1 kΩ

With R1 = 240 Ω, the minimum setpoint roughly lands around:

Vout_min ≈ 1.25 × (1 + 1000/240) ≈ 6.5 V

This keeps the LEDs illuminated even at minimum setting.

### Heat

At low brightness (worst case), LM317 may dissipate roughly ~0.5–0.8 W at ~80 mA, so a small heatsink is recommended.

## When to choose this

- If you want FM to remain quiet regardless of wiring placement.
- If you want to avoid PWM entirely near the tuner.

EOF

# 7) MW/LW to AUX meter fix page
mkdir -p "$ROOT/mw-lw-to-aux-meter-fix"
cat > "$ROOT/mw-lw-to-aux-meter-fix/index.md" <<'EOF'
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

EOF

echo "Created Hugo pages under: $ROOT"
echo "Next: open the folder, review, and adjust paths/taxonomy to match your site structure if needed."
