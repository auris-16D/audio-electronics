---
title: "Rotel RM-5010 — AUX Input Implementation"
date: 2025-12-20
draft: false
weight: 70
summary: "Add a stereo AUX input using an isolated jack, coupling capacitors, optional RF resistors, and correct single-point signal grounding."
---

## Outcome (agreed implementation)

Add a **stereo line-level AUX input** (phone/streamer) to the Rotel RM-5010 in a way that is:

- Quiet (no hum / ground-loop noise)
- Stable (reduced RF pickup)
- Reversible
- Integrated with the existing selector, volume, and tone controls

No changes are made to the power amplifier gain or output stage.

---

## Injection point (where AUX joins the Rotel)

Inject AUX at a **low-level input node**, such as:

- **Tape In** pads (common and safe), or
- Selector switch input pads that feed the preamp/tone/volume stages

Do **not** inject into the power amplifier stage.

---

## Connector mounting (avoid ground loops)

The AUX connector must **not bond signal ground to chassis** when mounted to the rear metal panel.

Accepted solutions (preferred → acceptable):

- **Isolated / insulated RCA (phono) sockets** (best)
- **Plastic RCA sockets**
- Metal RCA sockets with **insulating shoulder washers**

Verification:
- Measure with a multimeter
- **AUX sleeve ↔ chassis = open circuit** (no continuity)

---

## Component placement

Place the coupling capacitors and resistors **near the Rotel injection point**
(selector or Tape-In PCB pads), not back at the rear jack.

Use **shielded cable** from the AUX jack to this area.

---

## Circuit diagram (stereo AUX interface)

Legend:
- J1: isolated AUX jack
- SG: Rotel signal ground on the input PCB
- IN_L / IN_R: Rotel input nodes
- C1/C2: coupling capacitors
- RPD_L / RPD_R: pull-down (reference) resistors
- RS_L / RS_R: optional series resistors

LEFT CHANNEL (L) — identical circuit for RIGHT CHANNEL (R)

![RM-5010 AUX input interface schematic](/diagrams/rm-5010-aux-in.svg)

Notes:
- Shield/return connects to **SG at the Rotel PCB end**
- AUX sleeve is **intentionally not bonded to chassis**
- Signal and return run together to minimise loop area

---

## Recommended component values

### Coupling capacitors (C1, C2) — required
- **1 µF to 4.7 µF**
- **≥ 25 V**
- Film preferred if size permits; otherwise electrolytic or non-polar electrolytic

Purpose:
- Blocks DC between external source and Rotel circuitry

### Pull-down / reference resistors (RPD_L, RPD_R) — recommended
- **47 kΩ to 100 kΩ**, 1/4 W
- From IN_L / IN_R to **SG**

Purpose:
- Defines input impedance
- Prevents floating input pops and noise

### Series “stopper” resistors (RS_L, RS_R) — optional
- **220 Ω to 1 kΩ**, 1/4 W
- In series with L and R near the injection point

Purpose:
- Reduces RF pickup
- Improves robustness against cable capacitance and ESD

---

## Wiring and grounding rules (key points)

- Use **shielded cable** from AUX jack to injection point
- Keep **signal and return together**
- Tie AUX ground to Rotel **signal ground at one point only**
- Keep AUX wiring away from transformer, mains, rectifiers, and PWM LED wiring
- Verify isolation before power-up

---

## Do / Don’t

**Do**
- Isolate AUX jack sleeve from chassis
- Use coupling capacitors
- Use pull-down resistors
- Keep wiring short and shielded

**Don’t**
- Inject into power amp stages
- Create multiple ground-to-chassis bonds
- Run long unshielded signal wiring

---

## Implementation checklist

1. Mount isolated RCA sockets on rear panel
2. Identify Tape-In or selector input pads (IN_L, IN_R, SG)
3. Install C1/C2 and optional RS_L/RS_R near those pads
4. Install RPD_L/RPD_R from IN_L/IN_R to SG
5. Run shielded cable from AUX jack to injection point
6. Meter check: AUX sleeve ↔ chassis = open circuit
7. Power-on test at low volume
8. Confirm no hum and normal control operation
