
---
title: "Lesson 1.1 — Signal Flow in Audio Systems"
phase: 1
difficulty: foundational
weight: 110
---

## Purpose
...

Each block has:
- A defined **input**
- A defined **output**
- A specific **responsibility**

Signal-flow thinking focuses on the *handoff points* between these blocks.

---

## Strategic Test Points

Effective diagnosis does not follow wires — it checks **boundaries**.

At each stage boundary, ask one question:

> **Is the audio signal present here or not?**

This “divide-and-conquer” approach:
- Narrows faults rapidly
- Works even without a schematic
- Prevents unnecessary component replacement
- Keeps troubleshooting safe and deliberate

---

## Diagnostic Heuristics (Very Important)

### Rule 1 — No sound vs low sound
- **Very quiet sound** → gain problem
- **Distorted sound** → bias or linearity problem
- **Hum** → grounding or power-supply problem
- **No sound at all** → **signal interruption**

If an amplifier powers on normally but produces *absolutely no audio*, the most likely fault is **not lack of power** — it is a **break in the signal path**.

---

### Rule 2 — Always trace the signal before the components
Do not start with output transistors or power rails.

First determine:
- How far the signal gets
- Where it disappears

Only then consider *why*.

---

## Diagnostic Examples

### Example A — No signal after the volume control
If audio is missing immediately after the volume control:
- Suspect blocks **before** this point:
  - Input selector
  - Preamp
  - Tone stages
- Do **not** suspect:
  - Power amplifier
  - Output stage
  - Speaker circuitry

---

### Example B — Signal present after volume control, none at speakers
If audio is present after the volume control but absent at the speaker terminals:
- Suspect blocks **after** the volume control:
  - Power amplifier
  - Output relay or coupling
  - Protection circuitry
- Do **not** suspect:
  - Source
  - Preamp or tone stages

---

## Key Takeaway

> **Signal flow turns a complex circuit into a sequence of simple questions.**

You don’t need to know every component to diagnose intelligently.  
You need to know:
- Where the signal should be
- Where it actually is

Everything else follows from that.

---

## Reflection

- Do you tend to think in components or in functional blocks?
- Where in past repairs did you skip signal tracing and go straight to parts?
- How might this approach reduce risk when working on powered equipment?

Keep this lesson in mind — every future topic builds on it.
