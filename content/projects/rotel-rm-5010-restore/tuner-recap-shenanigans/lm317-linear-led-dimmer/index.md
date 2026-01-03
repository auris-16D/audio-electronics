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

