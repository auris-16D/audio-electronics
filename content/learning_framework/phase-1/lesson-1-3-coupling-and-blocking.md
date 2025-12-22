---
title: "Lesson 1.3 — Coupling and Blocking: Why Capacitors Exist"
phase: 1
difficulty: foundational
weight: 130
---

## Purpose

This lesson explains **why coupling exists between audio stages**, and why capacitors are used so pervasively in audio circuits.

It builds directly on:
- Lesson 1.1 — Signal Flow
- Lesson 1.2 — AC vs DC

By the end of this lesson you should be able to:
- Describe the behavioural requirements of a stage interface
- Explain why DC must be blocked while AC is passed
- Understand why frequency matters for coupling
- Recognise classic capacitor-related failure symptoms

---

## The Stage Interface Contract

In a well-designed audio system:

- Each stage owns its **DC operating conditions**
- Stages exchange **AC information only**
- The interface between stages enforces this contract

In behavioural terms, the interface must:
- Pass changing signals (AC)
- Reject steady-state levels (DC)
- Behave consistently regardless of what stage follows

This separation is deliberate and fundamental.

---

## Why Time and Frequency Matter

DC is not a separate phenomenon from AC.

> **DC is simply AC at 0 Hz.**

This has an important consequence:

- Very slow AC begins to resemble DC
- An interface that blocks DC must therefore also attenuate *very low frequencies*
- Faster changes are easier to pass cleanly

As a result:

> **An AC-passing / DC-blocking interface can never be frequency-neutral.**

It will always:
- Reject 0 Hz completely
- Attenuate very low frequencies first
- Pass higher frequencies more easily

This behaviour is unavoidable and must be designed around.

---

## Real-World Consequences

Because slow changes are affected first, coupling problems often present as:

- Weak or missing bass
- Thin or “tinny” sound
- Audio that fades in after power-on
- Channels that work intermittently
- Silence despite healthy power rails

Importantly:
- The stage itself may be functional
- The fault exists at the **interface**
- No component needs to be completely open or shorted

Partial degradation is enough.

---

## Why Capacitors Are Used

A capacitor is the simplest device that naturally:
- Blocks steady-state voltage (DC)
- Responds to change (AC)
- Responds more strongly to faster change than slower change

This makes it a natural implementation of the stage interface contract.

Capacitors are not arbitrary parts added “for sound” — they exist to enforce **DC independence between stages**.

---

## Key Takeaway

> **Coupling is not about passing signal.  
> It is about preventing DC from propagating.**

Loss of bass, delayed audio, and silent channels are often **DC problems expressed as AC symptoms**.

Understanding this makes capacitor placement — and capacitor failure — intelligible.

---

## Reflection

- Where in your equipment have you seen bass loss without total failure?
- How might this explain “it works after warming up” faults?
- Which stages in an amplifier are most sensitive to coupling behaviour?

This lesson sets the stage for understanding real capacitor choices and failures.
