---
title: "Rotel RM-5010 — LED Dial / Panel Lighting Conversion"
date: 2025-12-20
draft: false
tags: ["rotel", "rm-5010", "led", "lighting", "pwm", "rectifier", "capacitors"]
summary: "Replacing 12 VAC dial lamps with LED assemblies using bridge rectification, smoothing capacitors, and PWM dimming."
---

## Outcome (agreed implementation)

Replace the original 12 VAC dial/panel lamps with **LED lighting** that is:

- Flicker-free
- Dimmable with a single external control
- Electrically safe and reliable
- Reversible
- Thermally efficient

The solution uses **bridge rectification**, **smoothing capacitors**, and a **PWM dimmer**.

---

## Electrical overview

- Original supply: **12 VAC lamp winding**
- Converted to DC using a bridge rectifier
- Smoothed using parallel electrolytic capacitors
- Brightness controlled using a PWM controller
- LEDs arranged as **three parallel branches**, each with its own current-limiting resistor

---

## Circuit diagram (LED supply and loads)

Legend:
- AC = transformer lamp winding
- BR = bridge rectifier
- C1–C3 = smoothing capacitors (parallel)
- PWM = DC PWM dimmer module
- R1–R3 = LED current-limiting resistors

LED DIAL / PANEL LIGHT SUPPLY (12 VAC → DC → PWM → LEDs)

![RM-5010 LED supply schematic](/diagrams/rm-5010-led-supply.svg)

## PWM dimmer placement

The PWM controller is inserted **after the smoothing capacitors** and **before the LED branches**.

+15V DC (smoothed) ----> PWM IN +      PWM OUT + ----> LED resistors
GND / 0V ------------- PWM IN -      PWM OUT - ----> LED returns

Notes:
- PWM controls **all LED branches together**
- Current-limiting resistors are **still required**
- PWM dimming avoids heat and provides smooth brightness control

---

## Component values (final)

### Fuse
- **T250 mA slow-blow**
- 5×20 mm
- Fitted on the **AC side** of the lamp winding

### Bridge rectifier
- ≥ 1 A
- ≥ 50 V
- Block or discrete diodes

### Smoothing capacitors (C1–C3)
- **3 × 1000 µF in parallel**
- **≥ 25 V** (35 V also fine)
- Total capacitance: **3000 µF**
- Optional: add **100 nF film capacitor** across DC rails

### LEDs
- Arranged as **pairs in series**
- Three branches in parallel

### LED resistors (R1–R3)
- **≈ 470 Ω**
- **0.5 W**
- One resistor per LED branch

### PWM controller
- DC PWM dimmer
- Rated **≥ 9–60 V DC**
- Current rating ≥ 1 A (your 20 A unit is fine)

---

## Wiring and layout rules (key points)

- Bridge rectifier, capacitors, and PWM **mounted close together**
- DC + and − wiring run **together** to minimise loop area
- LED branches wired **in parallel**
- Fuse placed on **AC side**, not DC side
- Capacitors connected **in parallel**, never in series

---

## Behaviour observations

- 1000 µF total → visible flicker at low brightness
- 2000 µF → improved but still noticeable
- **3000 µF → flicker eliminated**
- PWM dimming preferred over resistive dimming
- Voltage rating margin (≥25 V) improves capacitor longevity

---

## Implementation checklist

1. Identify 12 VAC lamp winding
2. Add T250 mA fuse on AC feed
3. Build bridge + capacitor bank on perf board
4. Add PWM controller after capacitor bank
5. Wire three LED branches with individual resistors
6. Keep wiring short and paired
7. Test for flicker at low brightness
8. Mount PWM knob for user access

---

### One-sentence summary

> A fused 12 VAC lamp supply is bridge-rectified, smoothed with ~3000 µF, PWM-dimmed on the DC side, and feeds three parallel LED branches, each with its own current-limiting resistor.
