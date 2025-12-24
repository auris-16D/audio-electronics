---
title: "Lesson 1.7 — Functional Patterns: Seeing Stages in Schematics"
phase: 1
weight: 170
status: "complete"
summary: "Distilled notes from an interactive session: how to recognise a common amplifier pattern on a schematic, what rules out a buffer, and how to diagnose ‘clean but very low’ audio using AC reasoning and the emitter bypass capacitor."
---

## What you should be able to do after this lesson

- Look at a small cluster of parts around a transistor and decide its likely **job** (amplify vs buffer vs DC support) using connection cues.
- Identify a **common-emitter amplifier** pattern and state what feature most strongly distinguishes it from a buffer.
- Use symptom → hypothesis thinking for **clean but very low audio**, without defaulting to “bad transistor”.
- Choose a first measurement that tests the hypothesis directly (AC at the emitter).

---

## Core pattern covered (real-world example)

### Pattern: Common-emitter voltage amplifier

{{< lfimg
  src="images/lessons/lesson-1-7/common-emitter-nodes-explicit.svg"
  alt="Common-emitter amplifier pattern"
  caption="Common-emitter amplifier pattern (simplified): base input via coupling capacitor, collector output, emitter resistor, and emitter bypass capacitor."
>}}

**What we saw:**
- NPN transistor
- Collector resistor to the positive supply rail
- Emitter resistor to ground
- Base fed from previous stage via a **coupling capacitor**
- Two resistors as a base bias divider (supply → base → ground)
- Capacitor across the emitter resistor (emitter bypass capacitor)

**What it is (job):**  
- **Amplifier** (voltage gain stage)

**Why (connection-based):**
- Clear **signal input** (base via coupling capacitor)
- Clear **signal output** taken at the **collector**
- Collector resistor turns device current changes into output voltage swing
- Emitter resistor sets DC conditions; bypass capacitor restores AC gain

---

## Signal path vs DC support (critical mental separation)

{{< lfimg
  src="images/lessons/lesson-1-7/signal-path-vs-dc-support-fully-connected.svg"
  alt="Signal path vs DC support with correct wiring and transistor action"
  caption="Corrected view: Vin enters via Cin to the base node; the signal is observed at the collector node. DC parts (R1, R2, Re, rails) set operating point; Ce changes AC feedback without changing DC bias."
>}}

- **Signal path (AC):** coupling capacitor → transistor action → collector load
- **DC support:** bias divider, emitter resistor, supply rails

Both coexist in the same area of the schematic but serve **different purposes**.  
Many faults affect one without breaking the other.

---

## Key distinction: Amplifier vs buffer

**Most decisive cue (from the exercise):**  
> If the output is taken from the **collector** through a resistor to the supply rail, the stage is intended to provide **voltage gain**.

**Common buffer cue (for contrast):**
- Output taken from the **emitter** (near-unity voltage gain by topology)

This single connection cue is more reliable than counting components.

---

## Diagnostic insight from the exercise

### Symptom: Clean but very low audio from this stage

**Incorrect first instinct (common):**
- “The transistor must be bad because it amplifies.”

**Better first suspect (often correct in vintage gear):**
- **Emitter bypass capacitor** open / degraded (high ESR).

**Why:**
- DC bias can remain correct.
- The signal path remains intact and linear.
- AC negative feedback increases (AC must flow through the emitter resistor), collapsing gain.

**Practical keypoint:**
> Clean but very low audio often indicates **lost AC gain**, not a dead transistor.

---

{{< lfimg
  src="images/lessons/lesson-1-7/emitter-bypass-parallel-connection.svg"
  alt="Emitter bypass capacitor connected in parallel with emitter resistor"
  caption="Emitter bypass capacitor (Ce) is connected between the same two nodes as the emitter resistor (Re). Re sets DC bias; Ce bypasses Re for AC."
>}}

## What the bypass capacitor failure looks like

{{< lfimg
  src="images/lessons/lesson-1-7/emitter-bypass-healthy-vs-failed.svg"
  alt="Emitter bypass capacitor healthy versus failed"
  caption="Emitter bypass capacitor effect: when Ce fails open or high-ESR, emitter AC swing increases and stage gain drops."
>}}

When Ce fails, the emitter voltage begins to follow the signal, increasing negative feedback and reducing the effective base–emitter voltage swing — so gain collapses while linearity remains.

---

## Measurement with intent (what to do first)

**Goal:** test “lost emitter bypass” directly.

**Best first measurement:**
- Measure **AC amplitude at the emitter** (relative to the local reference/ground) while applying a known tone.

**Expected behaviour:**
- Healthy bypass: emitter AC swing stays relatively **small**.
- Failed bypass: emitter AC swing becomes **larger** (emitter resistor dominates AC feedback → gain drops).

**Note:**
- A DC bias check at the base can be useful, but it does **not** directly confirm loss of AC gain.

---

## Definitions introduced

- **Node:** a single electrical connection point where two or more component leads join; all points on the same node are (ideally) at the same voltage at a given moment.
- **DC bias:** the steady (no-audio) voltages and currents that set the operating point so an AC signal can be handled linearly.
- **Coupling capacitor:** a capacitor placed **in series** with the signal to pass AC while blocking DC between stages.
- **Bypass capacitor:** a capacitor that provides a low-impedance path for **AC** around a component that should remain effective for **DC** (e.g., bypassing an emitter resistor for AC gain).

---

## Corrected clarification (important)

> A capacitor in series blocks **DC** and passes **AC** (above a frequency set by the surrounding circuit).

(This corrects the earlier AC/DC slip in discussion.)

---

## Common misread → correct read

- Misread: “Low gain ⇒ transistor bad.”  
  Correct: “Low but clean ⇒ suspect loss of AC gain path first (often bypass capacitor).”

- Misread: “Following the signal means tracing component-by-component.”  
  Correct: “Classify the cluster’s job first, then choose a boundary measurement.”

---

## Questions & Clarifications (from this session)

1. **What exactly is DC bias?**  
   DC bias sets the steady operating point so the transistor can amplify an AC signal without clipping.

2. **If the bypass capacitor goes open, wouldn’t the signal stop?**  
   No. It reduces gain by increasing AC feedback; signal can still pass cleanly.

3. **What does a capacitor in series do?**  
   It blocks DC.
