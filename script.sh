#!/usr/bin/env bash
set -euo pipefail

FILE="content/projects/beomaster-1900/beolink/schematics/_index.md"

if [[ ! -f "$FILE" ]]; then
  echo "ERROR: File not found: $FILE"
  echo "Create it (or confirm your Hugo content path) and re-run."
  exit 1
fi

MARKER="## DIN_TRIG high-side switching (BeoLink trigger)"

if grep -qF "$MARKER" "$FILE"; then
  echo "OK: DIN_TRIG section already present in $FILE (no changes made)."
  exit 0
fi

cat >> "$FILE" <<'MD'

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
MD

echo "DONE: Added DIN_TRIG section to $FILE"
