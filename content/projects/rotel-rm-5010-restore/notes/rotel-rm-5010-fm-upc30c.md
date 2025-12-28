---
title: "Rotel RM-5010 — uPC30C (Control / Muting Logic Interface)"
section: "Technical Notes"
category: "Audio Electronics"
tags:
  - Rotel RM-5010
  - FM tuner
  - muting
  - control logic
  - uPC30C
date: 2025-12-27
status: "draft"
summary: "uPC30C reference page built from the pin-connection diagram and spec table captured during RM-5010 work. Intended to support diagnosis of mute/gating behaviour that can suppress otherwise valid FM audio."
---

## Diagrams used in this RM-5010 work

### Spec table (operating conditions / characteristics)

{{< lfimg
    src="/images/technical-notes/rm-5010/fm/upc30c/upc30c-spec-table.png"
    caption="uPC30C spec table"
    width="1000"
>}}


### Pin connection diagram

{{< lfimg
    src="/images/technical-notes/rm-5010/fm/upc30c/upc30c-pin-connection-diagram.png"
    caption="uPC30C pin connection diagram"
    width="1000"
>}}

---

## What uPC30C does (RM-5010 diagnostic view)

In the RM-5010 fault-isolation approach, uPC30C is treated as part of the **control/muting interface** rather than a signal-carrying audio IC. Its practical relevance is that it can gate or suppress audio even when:
- HA1137 is delivering signal, and
- HA1156 input has MPX/audio content.

---

## Pinout (from the captured diagram)

From the pin connection diagram:

Left side pins (1–8):
- 1: Mix Input
- 2: Feedback
- 3: AGC Filter
- 4: RF Output
- 5: (+) B
- 6: Vcc to AGC Amp
- 7: Det Output
- 8: GND

Right side pins (9–16):
- 9: FM Input
- 10: AGC Amp Bias
- 11: Amplified AGC
- 12: RF Input
- 13: GND
- 14: Mix Output
- 15: Mixer GND
- 16: Mixer Bias

---

## Where this fits in the RM-5010 diagnostic chain

Use this page when:
- MPX is present at HA1156 pin 2, but audio is still being suppressed,
- or muting behaviour is inconsistent/intermittent,
- or you suspect control logic is asserting mute incorrectly.

(As RM-5010 evidence accumulates, add measured DC states here for the pins that connect into the mute network.)
