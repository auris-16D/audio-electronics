---
title: "Rotel RM-5010 PSU Pre/Post Recap Bench Measurements"
section: "Technical Notes"
category: "Audio Electronics"
tags:
  - Rotel RM-5010
  - Power Supply
  - Bench Measurements
  - Transformer
  - DBT
  - Recap
date: 2025-12-25
status: draft
summary: "Pre/post recap bench measurement sheet for the RM-5010 PSU with transformer tap mapping, DC rail and ripple benchmarks, and load checks. Pre-recap transformer AC values captured on DBT (100W+40W in parallel)."

---

## Test Conditions
| Item | Pre-Recap | Post-Recap |
|-----|-----------|------------|
| Date (DD/MM/YYYY) | 25/12/2025 | |
| DBT used | Yes | Yes |
| DBT bulbs | 100 W + 40 W | 100 W + 40 W |
| DBT wiring | Parallel | Parallel |
| Mains voltage at unit (V AC) | 239 | 241.3 |
| Meter | Fluke 29 | Fluke 29 |
| Meter mode | V~ | V~ |
| Unit state (cold/warm, mins) | cold | cold |
| Notes | Transformer taps mapped; record post values with same DBT setup for direct comparison. | |

---

## 0) Transformer Secondary Identification — Resistance Benchmarks (POWER OFF)

**Purpose**
- Identify secondaries and taps (should not change post-recap)
- Reference for future diagnostics

**Meter:** Ohms  
**Power:** OFF, unplugged  
**Method:** Post-to-post resistance measurements (not across fuses)

### A) Isolated auxiliary secondary

| Post A | Colour | Post B | Colour | Resistance (Ω) | Notes |
|-------|--------|--------|--------|----------------:|-------|
| AC7 | White | AC6 | Blue | 50–90 | Isolated auxiliary secondary |

### B) Main tapped secondary (single winding with taps)

| From post | Colour | To post | Colour | Resistance (Ω) | Notes |
|----------|--------|---------|--------|----------------:|-------|
| AC5 | Green | AC4 | Yellow | 1.5 | |
| AC5 | Green | AC3 | Yellow | 1.5 | |
| AC5 | Green | AC2 | Red | 1.1 | |
| AC5 | Green | AC1 | Pink | 1.0 | |
| AC4 | Yellow | AC3 | Yellow | 1.9 | |
| AC4 | Yellow | AC2 | Red | 1.5 | |
| AC4 | Yellow | AC1 | Pink | 1.4 | |
| AC3 | Yellow | AC2 | Red | 1.5 | |
| AC3 | Yellow | AC1 | Pink | 1.5 | |
| AC2 | Red | AC1 | Pink | 0.9–1.3 | |

---

## 1) Transformer Secondary Voltages (AC, POWER ON via DBT)

**Meter:** AC Volts (V~)  
**Method:** Measure post-to-post of same winding

### A) Auxiliary secondary

| Winding | Post A (colour) | Post B (colour) | Pre (V AC) | Post (V AC) | Notes |
|--------|------------------|-----------------|-----------:|------------:|-------|
| Aux secondary | AC7 (white) | AC6 (blue) | 102.0 | | High-voltage, low-current secondary plausible given 50–90 Ω DCR |

### B) Main secondary — use full winding + key segments (benchmarks)

**Tap order derived from AC grid:** AC2 → AC5 → AC4 → AC3 → AC1

| Measurement | Post A (colour) | Post B (colour) | Pre (V AC) | Post (V AC) | Notes |
|------------|------------------|-----------------|-----------:|------------:|-------|
| Main full winding (primary benchmark) | AC1 (pink) | AC2 (red) | 42.1 | 43.2 | Use this as “main secondary (full)” |
| Segment | AC2 (red) | AC5 (green) | 8.94 | 9.18 | Low-voltage tap segment |
| Segment | AC4 (yellow) | AC5 (green) | 1.53 | 1.56 | Very small tap segment (likely for trimming/bias/aux feed) |
| Segment | AC3 (yellow) | AC4 (yellow) | 21.4 | 21.68| |
| Segment | AC1 (pink) | AC3 (yellow) | 10.52 | 10.81| |
| Cross-check | AC1 (pink) | AC5 (green) | 33.11 | 34.07| Should equal AC1–AC3 + AC3–AC4 + AC4–AC5 |

> Repeat post-recap with the same DBT setup for apples-to-apples comparison.
> Optionally add a second pass on direct mains once DBT behaviour is normal.

---

## 2) Main DC Rails at Reservoir Capacitors (most important)

0 V reference = Node B (cap midpoint), bonded to chassis (0.0 Ω).

**Meter:** DC Volts  
**Black probe:** PSU 0 V (main cap negative / ground bus)

| Rail | Probe location | Pre (V DC) | Post (V DC) | Notes |
|------|---------------|-----------:|------------:|-------|
| +Raw rail | Main cap A positive | 27.75| 28.29 ||
| −Raw rail | Main cap B positive (ref. PSU 0 V) | 27.75| 28.28 | |

---

## 3) Ripple at Main Reservoir Capacitors (key recap outcome)

**Meter:** AC Volts (lowest range)  
**Probes:** Across capacitor (+ to −)

| Capacitor | Pre Ripple (mV / V) | Post Ripple (mV / V) | DBT / Direct | Notes |
|-----------|--------------------:|---------------------:|--------------|-------|
| Main cap A |30mv | 25.3 | DBT | |
| Main cap B |29.3mv | 25.3 | DBT | |

---

## 4) Distributed / Secondary DC Outputs

**Meter:** DC Volts  
**Black probe:** PSU 0 V

| Destination / Output | Wire colour(s) | Pre (V DC) | Post (V DC) | Notes |
|----------------------|----------------|-----------:|------------:|-------|
| +DC output harness | Red | 28v| 28.33 | |
| −DC output harness | Grey |-28v | -28.33 | |
| Other supply 1 | | | | |
| Other supply 2 | | | | |

---

## Observations
- DBT behaviour (pre): no visible activation detected
- DBT behaviour (post): no visible activation detected
- Audible hum change:
- Thermal change (rectifiers, cement resistors):
- Notes / conclusions:

