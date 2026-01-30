---
title: "Beolink Output — KiCad Implementation"
section: "Projects"
category: "Beomaster 1900"
tags:
  - Beomaster 1900
  - Beolink
  - KiCad
  - PCB
  - Relays
  - Trigger
date: "2026-01-25"
status: "draft"
summary: "KiCad schematic/PCB implementation notes and consolidated BOM for the Beolink output relay/trigger board."
---

## Overview

This page documents the **KiCad schematic and PCB implementation** for the **Beolink Output relay/trigger interface** used in the Beomaster 1900 project.

Key characteristics:

- **No op-amp / no buffering**: audio is routed by relays.
- **12 V relay coils** switched from **+15_BEOLINK_SEL** via series resistors.
- **LM7805** generates **+5V_TRIG** rail for trigger/logic.
- **RC delay** creates a delayed enable (**TRIG_DELAY**), gating relay enable (**RELAY_EN**).
- **PARK_L / PARK_R** are bled to ground to avoid floating audio nodes.

---

## KiCad / Net Naming Notes

Notable nets (as used on the schematic/PCB):

- `+15_BEOLINK_SEL`: board supply for relay coils and regulator input
- `+5V_TRIG`: regulated 5 V rail (LM7805 output)
- `RELAY_EN`: relay enable control node (drives Q1 / relay coil return)
- `TRIG_DELAY`: RC-delayed node for gating / timing
- `DIN_TRIG`: external 5 V trigger in (from DIN/Powerlink/Beolink side)
- `DIN_L`, `DIN_R`: DIN audio L/R in
- `PRE_L`, `PRE_R`: preamp L/R
- `INT_L`, `INT_R`: internal path L/R
- `AMP_IN_L`, `AMP_IN_R`: amplifier input L/R
- `PARK_L`, `PARK_R`: parked/muted nodes (bled to GND via resistors)
- `PROTECT_OK`: protect/interlock input that can contribute to RELAY_EN

Relays:

- **K1 (DPDT)** routes between INT / PRE / DIN paths (as drawn)
- **K2 (DPDT)** routes AMP_IN to PARK nodes (muting / routing)

---

## Consolidated Parts List (De-duplicated BOM)

This table is grouped by **unique part/value** for ordering.

### Semiconductors

| Part | Description | Package | Qty | Required |
|---|---|---:|---:|:--:|
| LM7805 | 5 V linear regulator | TO-220 | 1 | ✅ |
| BC547 | NPN transistor | TO-92 | 2 | ✅ |
| BC557 | PNP transistor | TO-92 | 1 | ✅ |
| 1N4001 | Rectifier diode (relay flyback) | DO-41 | 2 | ✅ |
| 1N4148 | Signal diode | DO-35 | 2 | ✅ |

### Relays

| Part | Description | Coil | Qty | Required |
|---|---|---:|---:|:--:|
| TQ2-12V | DPDT signal relay | 12 V | 2 | ✅ |

### Resistors  
(Recommended: **¼ W**, 5% metal film, unless otherwise specified.)

| Value | Qty | Required | Used as |
|---:|---:|:--:|---|
| 10 kΩ | 2 | ✅ | Q1/Q2 base resistors (R1, R2) |
| 100 kΩ | 7 | ✅ | delay/pull-down/base bias/park bleeds (R3, R4, R6, R7, R8, R11, R12) |
| 270 Ω | 2 | ✅ | relay coil feed (R9, R10) |
| 220 Ω | 1 | ✅ | DIN_TRIG current limit (R5) |

### Capacitors

| Value | Type | Voltage | Qty | Required | Notes |
|---:|---|---:|---:|:--:|---|
| 47 µF | Electrolytic | ≥25 V | 1 | ✅ | regulator input bulk (C4) |
| 47 µF | Electrolytic | ≥16 V | 2 | ✅ | +5 V bulk + delay timing (C5, C1) |
| 1 µF | Ceramic | ≥25 V | 1 | ✅ | regulator input bypass (C2) |
| 100 nF | Ceramic | ≥25 V | 1 | ✅ | regulator output bypass (C3) |

### Connectors

(Choose pitch/series to match the PCB footprints used in your KiCad design.)

| Connector | Description | Qty | Required |
|---|---|---:|:--:|
| J1 | 2-pin header: `+15_BEOLINK_SEL`, `PROTECT_OK` | 1 | ✅ |
| J2 | 4-pin header: `DIN_L`, `DIN_R`, `GND_SIGNAL`, `DIN_TRIG` | 1 | ✅ |
| J3 | 5-pin header: `GND_SIGNAL`, `PRE_L`, `PRE_R`, `INT_L`, `INT_R` | 1 | ✅ |
| J4 | 2-pin header: `AMP_IN_L` | 1 | ✅ |
| J5 | 2-pin header: `AMP_IN_R` | 1 | ✅ |

### Test / Debug (Optional)

| Item | Description | Qty | Required |
|---|---|---:|:--:|
| TP1–TP5 | Test points (as placed) | 5 | ◻️ |

---

## KiCad Manufacturing Outputs

Recommended outputs to archive alongside this page (if not already committed):

- **Gerbers**: F.Cu / B.Cu, F.Mask / B.Mask, F.Silk / B.Silk, Edge.Cuts
- **Drill**: Excellon `.drl`
- **Gerber job file**: `.gbrjob`
- **BOM**: CSV
- **Pick-and-place** (if ever assembling): CPL/PNP

Suggested directory convention in repo (example only):

- `/docs/kicad/beolink-output/`
  - `gerbers/`
  - `bom/`
  - `renders/` (optional)

---

## Build Notes / Sanity Checks

### LM7805 dissipation (check before final assembly)
LM7805 drop = `(+15_BEOLINK_SEL - 5 V)`. Heat depends on load current.
- If load is mainly transistors + indicator(s), it will be modest.
- If you later add external draw from +5V_TRIG, consider a small heatsink or a buck regulator.

### Relay coil feed resistors (R9/R10 = 270 Ω)
These set coil current (and reduce stress/heat). Confirm relay coil voltage/current for your specific relay variant.

### Park resistors (R3/R4)
These prevent `PARK_L` / `PARK_R` floating when muted. Populate them.

---

## Reference Designators (Quick Map)

- Supply/reg: U1, C2–C5, C1
- Relay switching: K1, K2, D1, D2, R9, R10
- Logic steering: D3, D4
- Enable/delay: Q1, Q2, R1, R2, R6, R7, R8, C1
- Trigger interface: Q3, R5, R11, R12

