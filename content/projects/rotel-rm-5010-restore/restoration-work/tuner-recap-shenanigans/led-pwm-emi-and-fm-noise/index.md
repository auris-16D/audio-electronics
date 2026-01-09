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
weight: 40
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

