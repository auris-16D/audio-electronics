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
weight: 50
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

