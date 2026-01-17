---
title: "Beomaster 1900 — BeoLink Output KiCad Implementation Spec"
section: "Projects"
category: "Beomaster 1900"
date: 2026-01-08
status: "draft"
summary: "Canonical net-level implementation spec for the BeoLink output using two Panasonic TQ2-12V DPDT relays, protection-aware gating, and a delayed 5V trigger. Includes KiCad net/label debugging notes (TRIG_DELAY verification)."
---

## Purpose

This page is the canonical implementation specification for the Beomaster 1900 **BeoLink output with delayed 5V trigger**.

It is written so you can reproduce the design in **KiCad** with minimal interpretation.

---

## Behavioural requirements

### Entering BeoLink mode
1. Relays switch: audio routed to BeoLink and power amp inputs parked.
2. After a short delay (relay settle), **5V trigger asserts**.

### Leaving BeoLink mode
1. **5V trigger must drop first** (active speakers mute internally).
2. Relays release afterwards (audio routing changes after speakers are muted).

---

## Functional blocks

- **K1 (DPDT)**: Audio routing (L/R)
- **K2 (DPDT)**: Power amp input parking (L/R)
- **U1**: 5V regulator for trigger (7805 or equivalent)
- **Q1**: Relay coil driver (low-side switch)
- **Q2**: Trigger gate transistor (low-side switch)
- **RC delay**: delays trigger assertion (not removal)

---

## Parts (frozen)

### Relays
- **K1, K2**: Panasonic **TQ2-12V** (DPDT, signal relay)

### Driver devices
- **Q1, Q2**: small NPN (BC547 / BC337 / 2N3904)

### Diodes
- **D1, D2**: flyback diodes for relay coils (1N4001 ok)
- **D3, D4**: logic gating diodes (use **1N4148**)

### Resistors / capacitors (baseline values)
| Ref | Value | Notes |
|---|---:|---|
| R1 | 10k | Q1 base resistor |
| R2 | 10k | Q2 base resistor |
| R3 | 100k | Park/mute L power amp input (via K2) |
| R4 | 100k | Park/mute R power amp input (via K2) |
| R5 | 220Ω (100–470Ω ok) | 5V trigger series resistor to DIN |
| R6 | 100k | RC delay charge resistor (from RELAY_EN) |
| R7 | 100k | RC delay discharge / bleed resistor (TRIG_DELAY → GND) |
| R8 | 100k | RELAY_EN pull-down |
| C1 | 47µF (10–47µF ok) | Delay capacitor |
| C2 | 100nF | 7805 decoupling (place close) |
| C3 | 10µF | 7805 output bulk (place close) |

---

## Nets (name these in KiCad)

### Audio nets
- `PRE_L`, `PRE_R` (from Beomaster preamp output)
- `INT_L`, `INT_R` (internal feed to the power amp path via C219/C319 preamp-side)
- `AMP_IN_L`, `AMP_IN_R` (power amp input node, power-amp side of C219/C319)
- `DIN_L`, `DIN_R` (to BeoLink DIN audio pins)

### Control / power nets
- `BEOLINK_SEL` (user selects BeoLink mode)
- `PROTECT_OK`  (high only when main relay/protection indicates stable)
- `RELAY_EN`    (combined enable used to energise K1 and K2)
- `TRIG_DELAY`  (RC timing node that delays trigger assertion)
- `+12V_RELAY`  (relay supply rail)
- `+5V_TRIG`    (regulated 5V rail)
- `GND_SIGNAL`  (signal ground reference)
- `DIN_TRIG`    (trigger pin to DIN)

---

## RELAY_EN (explicit definition)

Requirement:
- Relays energise only when BOTH:
  - `BEOLINK_SEL` is true
  - `PROTECT_OK` is true

Implement AND gating with diodes + pull-down:

- D3: anode `BEOLINK_SEL` → cathode `RELAY_EN`
- D4: anode `PROTECT_OK`  → cathode `RELAY_EN`
- R8: `RELAY_EN` → `GND_SIGNAL` (100k)

Then drive Q1:
- `RELAY_EN` → R1 (10k) → Q1 base

---

## Relay wiring

### K1 — Audio routing (DPDT)
- COM-A  → `PRE_L`
- NC-A   → `INT_L`  (Normal mode)
- NO-A   → `DIN_L`  (BeoLink mode)

- COM-B  → `PRE_R`
- NC-B   → `INT_R`
- NO-B   → `DIN_R`

> Default state assumed: **Normal** when relay is de-energised.

### K2 — Power amp input parking (DPDT)
- COM-A → `AMP_IN_L`
- NC-A  → (no connect)
- NO-A  → `PARK_L`, where `PARK_L → R3 (100k) → GND_SIGNAL`

- COM-B → `AMP_IN_R`
- NC-B  → (no connect)
- NO-B  → `PARK_R`, where `PARK_R → R4 (100k) → GND_SIGNAL`

---

## Relay coil drive (Q1)

- Q1 is a low-side switch for both relay coils:
  - Q1 E → `GND_SIGNAL`
  - Q1 C → coil negative nodes
  - Coil positive nodes → `+12V_RELAY`

- Flyback diodes:
  - D1 across K1 coil
  - D2 across K2 coil
  - cathode to `+12V_RELAY`

---

## 5V trigger gating with delayed assertion (Q2 + RC)

### Trigger output wiring (low-side gated)
- `+5V_TRIG` → R5 → `DIN_TRIG`
- Q2 collector → `DIN_TRIG`
- Q2 emitter → `GND_SIGNAL`

When Q2 turns on, it completes the return path and the DIN trigger pin presents +5V relative to `GND_SIGNAL`.

### RC delay node (TRIG_DELAY) — verified topology

**TRIG_DELAY must be a single junction** connecting all of:
- R6 bottom pin
- C1 top pin
- R7 top pin
- R2 left pin (to Q2 base)

And:
- C1 bottom pin → `GND_SIGNAL`
- R7 bottom pin → `GND_SIGNAL`

So R7 is a bleed resistor **from TRIG_DELAY to ground**, i.e. C1 and R7 are **in parallel** to ground.

### RC network wiring
- `RELAY_EN` → R6 (100k) → `TRIG_DELAY`
- `TRIG_DELAY` → C1 (47µF) → `GND_SIGNAL`
- `TRIG_DELAY` → R7 (100k) → `GND_SIGNAL`
- `TRIG_DELAY` → R2 (10k) → Q2 base

Resulting behaviour:
- Trigger asserts only after delay (C1 charging through R6)
- Trigger drops promptly when `RELAY_EN` drops (C1 discharges via R7; Q2 base drive collapses)

---

## KiCad notes: nets, labels, and debugging (important)

### Net labels only work when attached to copper
A net label must be **placed on a wire segment** (or a pin-connected wire). Text placed “near” a wire does nothing.

Recommended workflow:
1. **Wire first** (make the junction real)
2. **Label second** (name that wire/junction)

### Fast, reliable net verification
- Hover over a wire and press the **backtick** key: **`**
  - KiCad highlights the entire connected net.
- This is the definitive check for “is this actually connected?”

Use this to verify:
- `TRIG_DELAY` highlights R6 bottom, C1 top, R7 top, R2 left, and Q2 base network.
- `RELAY_EN` highlights D3/D4 cathodes, R8 top, R1 input, and R6 top.

If the highlight stops short of a component pin, that pin is **not connected** (even if it looks connected).

---

## DIN pinout (placeholder)

Assign pins to match your target BeoLab/BeoLink standard. Placeholder mapping:

- `DIN_L`      → DIN pin (Left audio)
- `DIN_R`      → DIN pin (Right audio)
- `GND_SIGNAL` → DIN pin (Signal ground)
- `DIN_TRIG`   → DIN pin (5V trigger)

Update this once the exact pin numbering is confirmed for your speaker/cable standard.

---
