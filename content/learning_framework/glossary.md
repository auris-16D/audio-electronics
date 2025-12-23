---
title: "Glossary"
section: "Learning Framework"
status: "active"
weight: 5
summary: "Definitions of key concepts, terms, and component roles used throughout the lessons, with links to where each term appears."
---

## How to use this page

- Use this glossary when a lesson introduces a term you can’t confidently define in one sentence.
- Each entry includes links to pages where the term is used.

---

## AC (Alternating Current)

A quantity (voltage or current) that varies with time and reverses direction relative to a reference.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## AC coupling

A measurement or circuit mode that focuses on the changing (AC) part of a signal while ignoring a steady (DC) level.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-6-measuring-with-intent/

---

## Attenuation

A deliberate reduction in signal level (the opposite of gain).

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Bias (DC bias / bias point)

The steady (no-audio) voltages and currents that place a circuit stage into a defined operating state so it can handle an AC audio signal linearly.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Block (functional block)

A conceptual “stage-like” unit that accepts an input, has a responsibility, and produces an output—regardless of how it is implemented internally.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Boundary (stage boundary)

A handoff point between functional blocks where you can ask: “Is the signal present here or not?”

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/
- /learning_framework/phase-1/lesson-1-6-measuring-with-intent/

---

## Coupling

The deliberate transfer of AC information between stages while preventing DC operating conditions from propagating between them.

**Used in**
- /learning_framework/phase-1/lesson-1-3-coupling-and-blocking/
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/

---

## DC (Direct Current)

A steady (non-time-varying) level in a circuit. In audio electronics, DC primarily establishes operating conditions rather than carrying audio information.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-3-coupling-and-blocking/
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## Divide-and-conquer diagnosis

A strategy that narrows a fault by checking stage boundaries instead of following every connection.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Distortion

A symptom where the signal is present but altered undesirably (commonly due to incorrect operating conditions or limited headroom).

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Earth (safety earth)

A safety connection to mains earth. Often related to chassis connections, but not automatically identical to signal reference.

**Used in**
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## Functional pattern

A repeated arrangement of parts and connections that performs a recognisable job (e.g., amplification, buffering, filtering, protection). (Introduced conceptually as “pattern recognition”.)

**Used in**
- /learning_framework/phase-1/lesson-1-5-see-stages-not-components/

---

## Gain

An increase in signal level (amplitude) through a stage.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Ground (as a term)

A label used for a chosen reference point. Depending on context it may mean circuit reference, signal return, chassis, or earth—and these are not always the same thing.

**Used in**
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## Handoff point

Where one functional block passes the signal to the next. The place to test signal presence during diagnosis.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Headroom

The available “space” for the signal to swing cleanly before clipping or saturation occurs.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## Linearity

A condition where output changes proportionally with input (no distortion introduced by the stage).

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/

---

## Node

A single electrical connection point where two or more component leads join; all points on the same node are (ideally) at the same voltage at a given moment.

**Used in**
- /learning_framework/phase-1/lesson-1-6-measuring-with-intent/

---

## Operating point

Another name for the bias point: the DC condition around which the AC signal varies.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## Power rails

The supply voltage lines (positive/negative/ground references) that power stages. Not automatically where diagnosis should start.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/
- /learning_framework/phase-1/lesson-1-6-measuring-with-intent/

---

## Preamp (preamplifier)

An early stage that handles small signals, performs selection/tone shaping, and provides appropriate level for later stages.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Protection circuitry / protection relay

A circuit (often including a relay) that prevents unsafe conditions (e.g., DC at outputs) from reaching speakers.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/

---

## Reference (reference point)

The defined “zero” point relative to which a signal’s up/down variation has meaning. Signals and measurements are meaningless without a reference.

**Used in**
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/
- /learning_framework/phase-1/lesson-1-6-measuring-with-intent/

---

## Return (signal return)

The path that completes the circuit for signal currents. Often associated with “ground” in schematics, but conceptually distinct from earth.

**Used in**
- /learning_framework/phase-1/lesson-1-4-reference-ground-for-signal/

---

## Signal (audio signal)

Time-varying information (music/speech) represented as small variations of voltage and current relative to a reference.

**Used in**
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Signal flow

The ordered path through functional blocks where the audio information should be present, stage by stage.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Stage

A group of components that accepts a signal, does one deliberate thing to it, and hands it off. Defined by function, not by part count.

**Used in**
- /learning_framework/phase-1/lesson-1-5-see-stages-not-components/
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## Stage interface contract

A behavioural requirement between stages: each stage owns its DC conditions; stages exchange AC information only.

**Used in**
- /learning_framework/phase-1/lesson-1-3-coupling-and-blocking/
- /learning_framework/phase-1/lesson-1-2-ac-vs-dc/

---

## Strategic test point

A deliberately chosen point (often at a stage boundary) where a single measurement answers a high-value diagnostic question.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/
- /learning_framework/phase-1/lesson-1-6-measuring-with-intent/

---

## Tone stage

A stage that shapes frequency response (e.g., bass/treble controls), altering some frequencies more than others.

**Used in**
- /learning_framework/phase-1/lesson-1-1-signal-flow/

---

## 0 Hz

A useful mental bridge: DC can be viewed as AC at 0 Hz.

**Used in**
- /learning_framework/phase-1/lesson-1-3-coupling-and-blocking/
