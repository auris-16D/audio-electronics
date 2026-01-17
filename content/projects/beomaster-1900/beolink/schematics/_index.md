---
title: "Beomaster 1900 — BeoLink Output KiCad Implementation Spec"
section: "Projects"
category: "Beomaster 1900"
tags:
  - beomaster-1900
  - bang-olufsen
  - beolink
  - beolab
  - trigger
  - relay
  - tq2
  - kicad
date: 2026-01-07
status: "draft"
summary: "Canonical net-level implementation spec for building the BeoLink output schematic in KiCad using two Panasonic TQ2-12V DPDT relays, protection-aware gating, and delayed 5V trigger sequencing."
---

## DIN_TRIG high-side switching (BeoLink trigger)

### Objective
Provide a +5 V trigger on the BeoLink DIN socket **only after relay switching is complete**, and **remove the trigger first** when leaving BeoLink mode to prevent audible transients.

**Important:** The DIN cable already carries signal ground. Therefore the trigger must be switched on the **high side** (switching the ground return is unsafe and unreliable).

---

### Circuit implementation (locked)

#### Parts
- **Q2** — NPN transistor (BC547 / 2N3904)
- **Q3** — PNP transistor (BC557 / 2N3906)
- **R2** — 10 kΩ (TRIG_DELAY → Q2 base)
- **R3** — 100 kΩ (Q3 base pull-up)
- **R5** — 100–470 Ω (series protection to DIN_TRIG)

#### Connections
- **Q3 (PNP, high-side switch)**
  - Emitter → `+5_TRIG`
  - Collector → `DIN_TRIG` (via R5 if fitted)
  - Base → `Q3_BASE`

- **Q2 (NPN driver)**
  - Emitter → `GND`
  - Collector → `Q3_BASE`
  - Base ← `TRIG_DELAY` via R2 (10 kΩ)

- **Pull-up**
  - R3 (100 kΩ) from `Q3_BASE` → `+5_TRIG`

---

### Behaviour check
- **TRIG_DELAY = LOW**
  - Q2 OFF → Q3 base pulled HIGH → Q3 OFF  
  - `DIN_TRIG` is high-impedance (OFF)

- **TRIG_DELAY = HIGH**
  - Q2 ON → Q3 base pulled LOW → Q3 ON  
  - +5 V applied to `DIN_TRIG`

---

### Timing requirement
`TRIG_DELAY` must be **slow-on / fast-off** so that:
- entering BeoLink: relays switch first, then trigger is asserted
- leaving BeoLink: trigger is removed first, then relays change state

This guarantees no switching noise reaches active speakers.
