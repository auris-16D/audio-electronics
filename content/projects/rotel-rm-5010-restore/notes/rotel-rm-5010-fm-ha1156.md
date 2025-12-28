---
title: "Rotel RM-5010 — HA1156 (FM Stereo Decoder)"
section: "Technical Notes"
category: "Audio Electronics"
tags:
  - Rotel RM-5010
  - FM tuner
  - stereo decoder
  - HA1156
  - multiplex
  - pilot
  - muting
date: 2025-12-27
status: "draft"
summary: "HA1156-focused reference: block diagram and typical circuits (as used during RM-5010 diagnosis), pin-level confirmation points (pins 2/4/5/10/14), and the diagnostic trail that led to replacing the 471 pF capacitor on the pin 14 timing node."
---

## Datasheet link

Full PDF (as used for diagrams on this page):  
https://datasheet4u.com/pdf-down/H/A/1/HA1156W_HitachiSemiconductor.pdf

---

## Diagrams used in this RM-5010 work

### Functional block diagram

{{< lfimg
    src="/images/technical-notes/rm-5010/fm/ha1156/ha1156-functional-block.png"
    caption="HA1156 functional block diagram"
    width="1000"
>}}

### Circuit schematic and typical external parts

{{< lfimg
    src="/images/technical-notes/rm-5010/fm/ha1156/ha1156-internal-schematic-typical-parts.png"
    caption="HA1156 circuit schematic and typical external parts"
    width="1000"
>}}

### Test circuit

{{< lfimg
    src="/images/technical-notes/rm-5010/fm/ha1156/ha1156-test-circuit.png"
    caption="HA1156 test circuit"
    width="1000"
>}}

---

## What HA1156 does (practical view)

In the RM-5010 chain, HA1156 is the **multiplex stereo decoder**. It accepts the composite MPX signal, extracts/locks to the pilot reference, generates switching/timing, and outputs L/R audio. It also drives the stereo indicator lamp (per the datasheet’s block diagram/test circuit).

---

## Pins that mattered in RM-5010 diagnosis (confirmed)

Pin numbering below follows your RM-5010 probing points and the datasheet diagrams.

### Pin 2 — IN (MPX input)
Confirmed:
- Audio probe: **clear FM audio** present.
- Tektronix TDS1002: approx **~1 V p-p**.

Meaning:
- Composite/MPX content is reaching the decoder input.
- Upstream chain is unlikely to be the primary “no audio” cause.

### Pins 4 and 5 — Lout / Rout (audio outputs)
Observed:
- Audio probe: **hiss/static**, no intelligible program audio.

Meaning:
- Decoder is not delivering valid decoded L/R audio (or is being held in a condition that produces noise).

### Pin 10 — 19 kHz monitor
Measured:
- Approx **19.37 kHz** waveform present.

Meaning:
- Pilot/reference-related activity exists.

### Pin 14 — VCO / timing node (external time constant components)
Measured:
- Approx **62 kHz** present in all cases.

Meaning:
- Timing/reference oscillator activity is present.
- External parts on the pin 14 node still matter even when the frequency exists.

---

## Diagnostic summary: why the 471 pF capacitor was replaced (RM-5010)

This section is a summary of the decision trail, kept separate from the pin/diagram collation above.

### Evidence chain

1) Signal present at input:
- HA1156 pin 2: clear audio by audio probe, ~1 V p-p.

2) Outputs invalid:
- HA1156 pins 4/5: hiss/static only.

3) Timing/reference present:
- HA1156 pin 10: ~19.37 kHz.
- HA1156 pin 14: ~62 kHz present in all cases.

4) Physical anomaly tied to a critical node:
- The **first component connected to HA1156 pin 14** showed visible contamination/fluid at its base.
- Marking: **“471K”** (interpreted as **470 pF**, ±10%).

### Why pin 14 external parts were prioritised

Pin 14 is shown (block diagram + typical circuit) as part of the oscillator/timing loop (“TIME CONST”/VCO area). A capacitor fault on this node can:
- leave an oscillation frequency observable on a scope,
- yet alter loop conditions enough to break decode behaviour or force noise-like output.

### Decision logic

- Upstream delivery confirmed (HA1137 pin 6 and HA1156 pin 2 both show healthy signal).
- HA1156 timing nodes not dead.
- Outputs wrong.
- A physically suspicious capacitor sat directly on the pin 14 timing node.

Conclusion:
- Replace the **471 pF** capacitor before suspecting HA1156 itself.

---

## Notes to future RM-5010 troubleshooters

- Seeing “the right frequency” does not prove correct decode.
- Probe input first (pin 2), then check pilot/timing nodes (pin 10 / pin 14), then check outputs (pins 4/5).
