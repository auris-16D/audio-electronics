---
title: "Lesson 1.2 — AC vs DC in Audio Circuits"
phase: 1
difficulty: foundational
---

## Purpose

This lesson explains the fundamental distinction between **AC signals** and **DC operating conditions** in audio circuits.

Understanding this separation is essential for:
- Signal coupling
- Biasing
- Diagnosing “no sound” faults
- Understanding why capacitors and protection circuits exist

By the end of this lesson you should be able to:
- Explain the role of DC in audio stages
- Describe what the AC audio signal represents
- Predict what happens when DC enters the signal path
- Recognise DC-related faults without seeing a schematic

---

## The Role of DC

DC exists to place circuit stages into a **defined operating state**.

At system level:
- DC powers stages
- DC establishes bias points
- DC defines headroom and linear operating regions

DC does **not** carry audio information.

A useful rule:

> **DC creates the conditions for operation.  
> AC carries the information.**

Each stage is designed around its own DC assumptions.

---

## The AC Audio Signal

The AC audio signal represents **time-varying information**.

Conceptually:
- It is encoded media (music, speech)
- It varies continuously with time

Physically:
- It appears as small voltage and current variations
- It spans a range of frequencies
- It is reproduced stage by stage, not “pushed” through the circuit

In early stages, the AC signal carries very little energy — it is almost entirely informational.

---

## Why AC and DC Must Be Separated

Each circuit stage:
- Requires its own DC conditions
- Is designed to manage and monitor those conditions internally

Passing DC from one stage to the next is dangerous because:
- One stage’s DC level can shift the next stage’s bias point
- DC can force stages into cutoff or saturation
- DC can eliminate headroom and block AC entirely
- DC at outputs can trigger protection or damage speakers

For this reason:

> **Only AC information should be handed from one stage to the next.  
> DC must be locally sourced and locally controlled.**

This separation is intentional and fundamental.

---

## Common DC-Related Failure Symptoms

DC problems often present as:
- Complete loss of audio with normal power-up
- Audio that appears briefly, then disappears
- Protection relays that never engage
- Silent channels with healthy power rails

These symptoms frequently occur **without visible damage**.

---

## Key Takeaway

> **AC is shared. DC is not.**

Each stage owns its DC requirements.  
The signal path exists to transfer information, not operating conditions.

Understanding this principle explains:
- Why coupling exists
- Why leakage causes faults
- Why many vintage “no sound” problems are DC problems in disguise

---

## Reflection

- Where have you seen DC faults masquerade as signal faults?
- How might this model change how you approach “no sound” repairs?
- Which stages in a typical amplifier are most sensitive to DC errors?

This lesson underpins everything that follows.
