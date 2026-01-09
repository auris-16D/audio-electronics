---
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
weight: 100
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
