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
weight: 60
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

