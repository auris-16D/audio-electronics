#!/usr/bin/env bash
set -euo pipefail

# Beomaster 1900 project scaffolding + two Hugo pages
#
# Creates:
#   content/projects/beomaster-1900/index.md
#   content/projects/beomaster-1900/beolink-output-kicad-implementation.md
# Plus (optional) image folders:
#   static/images/projects/beomaster-1900/
#
# Safe behaviour:
# - Will NOT overwrite existing files unless you set OVERWRITE=1

OVERWRITE="${OVERWRITE:-0}"

PROJECT_DIR="content/projects/beomaster-1900"
STATIC_IMG_DIR="static/images/projects/beomaster-1900"

mkdir -p "$PROJECT_DIR"
mkdir -p "$STATIC_IMG_DIR"

write_file() {
  local path="$1"
  shift
  if [[ -f "$path" && "$OVERWRITE" != "1" ]]; then
    echo "SKIP (exists): $path"
    return 0
  fi
  cat > "$path" <<'EOF'
'"$@"'
EOF
}

# -----------------------------
# Page 1: Project index
# -----------------------------
INDEX_MD_CONTENT='---
title: "Beomaster 1900 — BeoLink Output with 5V Trigger"
section: "Projects"
category: "Beomaster 1900"
tags:
  - beomaster-1900
  - bang-olufsen
  - modification
  - beolink
  - beolab
  - preamp-out
  - trigger
  - relay
  - kicad
date: 2026-01-07
status: "draft"
summary: "Implement a BeoLink-style line output using 8-pin DIN sockets with protection-aware 5V trigger logic, using relays for silent switching and a KiCad-defined schematic ready for PCB manufacture."
---

## Scope

Goal: add a **BeoLink-style line output** to the **Beomaster 1900** using **8-pin DIN** sockets carrying:

- Left audio (line level)
- Right audio (line level)
- Signal ground
- A **5V trigger** that turns compatible active speakers on **only after**:
  1) the Beomaster has completed its own power-up/protection sequencing, and  
  2) the user has selected the **BeoLink** mode.

This work replaces a simpler “PRE OUT / MAIN IN with link bars” approach with a more integrated B&O-style solution.

> Design emphasis: **no switching noise** through active speakers, and deterministic behaviour when entering/leaving BeoLink mode.

---

## Design summary

### Key decisions

- Use **two Panasonic TQ2-12V DPDT signal relays**:
  - **K1**: routes preamp L/R either to internal power amp path (normal) or to BeoLink DIN (BeoLink mode).
  - **K2**: “parks” the power amp input nodes so they never float when BeoLink mode is selected.

- Create a **regulated 5V** for the trigger (U1 = 7805 or equivalent), derived from a switched rail.

- Gate the trigger so that **5V is asserted only when**:
  - the unit is stable (**PROTECT_OK** true; main relay/protection has released), **and**
  - the user has selected BeoLink (**BEOLINK_SEL** true), **and**
  - relay switching has completed (via a short RC delay).

### Switching-order requirement

When **leaving** BeoLink mode, the order must be:

1) **Remove 5V trigger first** (active speakers mute internally)  
2) Then allow **audio routing** to change

This avoids transients through active speakers.

---

## Signals / tap points (schematic-driven)

- Preamp outputs (line level) are taken from the same nodes previously identified as:
  - **P2-1** (Left preamp output)
  - **P2-3** (Right preamp output)

- Power amp coupling capacitors:
  - **C219** (Left coupling into power amp)
  - **C319** (Right coupling into power amp)

These are used to define “internal amp feed” and “power amp input nodes” for parking.

---

## Implementation approach

- Replace the rear “extra speaker” connectors with **8-pin DIN** sockets for BeoLink output.
- Use the existing speaker selector / mode switch as a **control input** (logic), not as an audio switch.
- Use relays on a small daughterboard (or PCB) to perform:
  - audio routing (K1)
  - power amp input parking (K2)
  - trigger gating and sequencing

---

## KiCad implementation guide

Follow the dedicated implementation page:

- **Beomaster 1900 — BeoLink Output (KiCad Implementation Spec)**  
  (see `beolink-output-kicad-implementation.md` in this project folder)

---

## Files / assets

Recommended (optional) project image folder:

- `static/images/projects/beomaster-1900/`

Suggested filenames:
- `beolink-output-overview.png`
- `beolink-output-kicad-schematic.png`
- `beolink-output-wiring-notes.png`

---

## Status

- Design specification: drafted (07/01/2026)
- Bench POC: pending
- KiCad schematic capture: pending
- PCB layout + manufacture: pending
'

if [[ -f "$PROJECT_DIR/index.md" && "$OVERWRITE" != "1" ]]; then
  echo "SKIP (exists): $PROJECT_DIR/index.md"
else
  cat > "$PROJECT_DIR/index.md" <<< "$INDEX_MD_CONTENT"
  echo "WROTE: $PROJECT_DIR/index.md"
fi

# -----------------------------
# Page 2: KiCad implementation spec (canonical)
# -----------------------------
KICAD_MD_CONTENT='---
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

## Purpose

This page is the **canonical implementation specification** for the Beomaster 1900 **BeoLink output with delayed 5V trigger**.

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
- **D1, D2**: flyback diodes for relay coils (1N4148 or 1N4001)

### Resistors / capacitors (baseline values)
| Ref | Value | Notes |
|---|---:|---|
| R1 | 10k | Q1 base resistor |
| R2 | 10k | Q2 base resistor |
| R3 | 100k | Park/mute L power amp input (via K2) |
| R4 | 100k | Park/mute R power amp input (via K2) |
| R5 | 100Ω–470Ω | 5V trigger series resistor to DIN |
| R6 | 100k | RC delay charge resistor |
| R7 | 100k | RC discharge resistor (ensures quick off) |
| C1 | 10–47µF | RC delay capacitor (sets 0.1–0.5s class delay) |
| C2 | 100nF | 7805 input/output decoupling (place close) |
| C3 | 10µF | 7805 output bulk (place close) |

---

## Nets (name these in KiCad)

### Audio nets
- `PRE_L`  (from Beomaster preamp output, e.g. P2-1)
- `PRE_R`  (from Beomaster preamp output, e.g. P2-3)

- `INT_L`  (internal feed to the power amp path via C219 preamp-side)
- `INT_R`  (internal feed to the power amp path via C319 preamp-side)

- `AMP_IN_L` (power amp input node, power-amp side of C219)
- `AMP_IN_R` (power amp input node, power-amp side of C319)

- `DIN_L` (to BeoLink 8-pin DIN left audio)
- `DIN_R` (to BeoLink 8-pin DIN right audio)

### Control / power nets
- `BEOLINK_SEL` (from user selector switch; high = BeoLink selected)
- `PROTECT_OK`  (high only when main protection/relay indicates stable)
- `RELAY_EN`    (combined enable used to energise K1 and K2)
- `TRIG_DELAY`  (RC node that delays trigger assertion)
- `+12V_RELAY`  (relay supply rail)
- `+5V_TRIG`    (regulated 5V rail)
- `GND_SIGNAL`  (signal ground reference)

---

## Relay wiring

### K1 — Audio routing (DPDT)
Goal: route `PRE_L/PRE_R` either to internal feed (`INT_L/INT_R`) or to DIN (`DIN_L/DIN_R`).

- K1 COM-A  → `PRE_L`
- K1 NC-A   → `INT_L`  (Normal mode)
- K1 NO-A   → `DIN_L`  (BeoLink mode)

- K1 COM-B  → `PRE_R`
- K1 NC-B   → `INT_R`
- K1 NO-B   → `DIN_R`

> Choose which state is NC/NO depending on your preferred default (power-off) behaviour. The above assumes **default = Normal** when relays are not energised.

### K2 — Power amp input parking (DPDT)
Goal: when BeoLink is active, prevent the internal power amp input nodes from floating.

- K2 COM-A → `AMP_IN_L`
- K2 NC-A  → (leave open / no connect)
- K2 NO-A  → `PARK_L` where `PARK_L → R3 (100k) → GND_SIGNAL`

- K2 COM-B → `AMP_IN_R`
- K2 NC-B  → (leave open / no connect)
- K2 NO-B  → `PARK_R` where `PARK_R → R4 (100k) → GND_SIGNAL`

This ensures that in BeoLink mode the amp inputs are referenced and quiet.

---

## Relay coil drive (Q1)

### Requirement
Relays energise only when:
- `PROTECT_OK` is true, AND
- `BEOLINK_SEL` is true

Implement:
- `RELAY_EN = PROTECT_OK ∧ BEOLINK_SEL`

### Implementation (recommended)
- Use Q1 as a **low-side switch** for both relay coils:
  - Q1 E → `GND_SIGNAL`
  - Q1 C → one side of both coils (K1 coil-, K2 coil-)
  - Other side of both coils → `+12V_RELAY`
- Diodes across each coil (D1, D2), cathode to `+12V_RELAY`.

Drive Q1 base from `RELAY_EN` via R1 (10k).

---

## 5V trigger gating with “switching complete” delay (Q2 + RC)

### Requirement
- Trigger asserts only after relays have settled.
- Trigger drops immediately on deselect.

### RC delay
- R6 (100k): `RELAY_EN` → `TRIG_DELAY`
- C1 (10–47µF): `TRIG_DELAY` → `GND_SIGNAL`
- R7 (100k): `TRIG_DELAY` → `GND_SIGNAL` (provides defined discharge behaviour; keep if you find timing needs tightening)

### Gate transistor
- Q2 E → `GND_SIGNAL`
- Q2 C → DIN trigger return switch node (see below)
- Q2 base driven by `TRIG_DELAY` via R2 (10k)

### Trigger output wiring
- `+5V_TRIG` → R5 (100Ω–470Ω) → `DIN_TRIG`
- `DIN_TRIG` is connected to Q2 collector (so Q2 completes the circuit when enabled)

This arrangement makes trigger assertion delayed (RC), and trigger removal fast (base drive collapses as soon as `RELAY_EN` falls).

---

## DIN pinout (placeholder)

Assign pins to match your target BeoLab/BeoLink standard. Placeholder mapping:

- `DIN_L`      → DIN pin (Left audio)
- `DIN_R`      → DIN pin (Right audio)
- `GND_SIGNAL` → DIN pin (Signal ground)
- `DIN_TRIG`   → DIN pin (5V trigger)

Update this once the exact pin numbering is confirmed for your speaker/cable standard.

---

## KiCad capture checklist

1. Create new KiCad project.
2. Place parts with frozen references:
   - K1, K2, Q1, Q2, U1, D1, D2, R1–R7, C1–C3, connectors.
3. Name nets exactly as specified above.
4. Wire K1 and K2 contacts per the relay wiring section.
5. Wire coil drive (Q1) and add flyback diodes.
6. Wire trigger gate (Q2) and RC delay.
7. Run ERC and resolve any power pin warnings (use PWR_FLAG if needed).
8. Only after schematic is stable: assign footprints and run footprint association.
9. Generate a first PCB outline and place connectors/relays (layout phase).

---

## Notes for layout (when you reach PCB)

- Keep relay coils and coil traces away from the audio traces.
- Run `GND_SIGNAL` as a continuous reference (prefer a solid ground plane).
- Keep DIN audio traces short and paired with ground return.
- Place 7805 (or buck) and its decoupling close together.
- Place RC delay components near Q2.

'

if [[ -f "$PROJECT_DIR/beolink-output-kicad-implementation.md" && "$OVERWRITE" != "1" ]]; then
  echo "SKIP (exists): $PROJECT_DIR/beolink-output-kicad-implementation.md"
else
  cat > "$PROJECT_DIR/beolink-output-kicad-implementation.md" <<< "$KICAD_MD_CONTENT"
  echo "WROTE: $PROJECT_DIR/beolink-output-kicad-implementation.md"
fi

echo
echo "Done."
echo "Project pages:"
echo "  - $PROJECT_DIR/index.md"
echo "  - $PROJECT_DIR/beolink-output-kicad-implementation.md"
echo
echo "Optional images folder:"
echo "  - $STATIC_IMG_DIR"
echo
echo "To overwrite existing files, run:"
echo "  OVERWRITE=1 $0"
