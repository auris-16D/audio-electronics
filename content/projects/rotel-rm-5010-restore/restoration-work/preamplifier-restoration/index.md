---

title: "Preamplifier Restoration"
section: "Technical Notes"
category: "Projects"
tags:

- Rotel RM-5010
- Preamplifier
- Restoration
- Fault Diagnosis
- Transistor Replacement
- Noise
- Recap
- KSC1845
- 2SC1222
date: 2026-01-09
status: "Complete"
summary: "Diagnosis and restoration of the Rotel RM-5010 preamplifier following recap-induced static noise, traced to intermittently noisy 2SC1222 transistors and resolved by replacement with KSC1845 devices."

---

## Scope of this page

This page documents the **complete diagnosis, reasoning, and corrective work** carried out on the Rotel RM-5010 preamplifier following a full electrolytic recap. The intent is to preserve not only the *fix*, but the *diagnostic logic* used to arrive at it, so similar faults can be recognised quickly in future restorations.

The behaviour described here initially appeared to implicate grounding, power amplifier instability, or recap errors. Careful isolation demonstrated the true cause to be **intermittently noisy small-signal transistors** in the preamp signal path.

---

## Initial condition

* **All electrolytic capacitors on the preamplifier PCB were replaced** as part of a full recap.
* Replacement capacitors were selected to match original capacitance values and meet or exceed voltage ratings.
* Polarity was carefully observed on all polarized capacitors.
* Soldering work was performed methodically, one component at a time.
* After completion, the PCB was thoroughly cleaned using flux remover to eliminate solder flux residue.

### Post‑recap verification steps

* Capacitor values and polarity were **triple‑checked visually** against the original layout.
* Pads, vias, and surrounding traces were inspected for lifting or damage.
* The board was cleaned again after initial fault symptoms appeared, to rule out contamination or leakage paths.

### Symptom after power‑up

* Very loud static from speakers
* Noise present even with volume at minimum
* Static present on AUX, Phono, and FM paths
* Noise severe enough to trigger DBT brightness

---

## First isolation steps

### Preamp vs power amp separation

* Preamp disconnected from power amp → **silence**
* Preamp output scoped directly → **clean audio, no static**
* Static only present when preamp connected to power amp

This strongly suggested either:

* a floating / unstable reference at the power amp input, or
* noise being injected from the preamp via signal or ground

---

## Power amp input testing

The following decisive tests were performed at the **power amplifier input**:

* Input hot shorted to signal ground → static disappeared
* Input hot disconnected entirely → silence
* Ground-only connection between boards → silence

This ruled out the power amplifier itself and narrowed the issue to **preamp-originated noise**.

---

## Channel isolation

* Left channel hot connected alone → clean
* Right channel hot connected alone → immediate static

At this point the fault was confirmed to be:

> **Right-channel only, preamp-local, independent of DC bias correctness**

---

## DC verification

* Right preamp output DC: ~0 V
* Left preamp output DC: ~5 mV

Normal DC conditions ruled out coupling capacitor polarity or bias failure.

---

## Behavioural clues

Additional symptoms observed:

* Static often began after warm-up
* Large intermittent pops
* Sudden jumps in perceived gain
* Noise strongest at certain transistor collectors
* Cooling the unit restored correct operation for ~10 minutes

These behaviours are classic for **intermittent transistor burst / popcorn noise**.

---

## Preamp topology (functional interpretation)

Each channel uses **three small-signal NPN transistors**:

1. **Input buffer (emitter follower)**

   * High input impedance
   * No voltage gain

2. **Tone recovery / voltage gain stage (common emitter)**

   * Primary gain stage
   * Most noise-sensitive position

3. **Output buffer (emitter follower)**

   * Low output impedance
   * Drives CON-1 (power amp input)

Only the **voltage gain stage** has the authority to produce the observed symptoms.

---

## Key observation during probing

One transistor exhibited:

* Base and emitter with similar AC amplitude
* Collector with significantly lower AC level

This was determined to be **normal behaviour** for an emitter follower stage and **not a fault**.

The true fault was identified instead by:

* Collector noise bursts
* Thermal sensitivity
* Channel specificity

---

## Root cause

The original **2SC1222 (marked C1222)** transistors had developed **intermittent noise**.

Characteristics:

* DC parameters normal
* Gain appeared normal when cold
* Noise generated internally at junction level
* Noise strongest at collector of common-emitter stage

This failure mode is common in ageing Japanese small-signal audio transistors.

---

## Corrective action

### Transistor replacement

All six C1222 devices (three per channel) were replaced.

* Original: 2SC1222 (C1222)
* Replacement: **KSC1845FTA**
* Pinout compatibility: ECB → ECB (direct replacement)

Replacement was done one channel at a time initially, then completed symmetrically.

---

## Result after replacement

### Electrical

* All static noise eliminated
* No pops or gain jumps
* Stable operation from cold and warm

### Audible improvements

* Perfect left/right balance
* Higher effective gain at same volume setting
* Clearer, more defined sound
* Tighter, fuller bass
* Stronger vocal projection
* Noticeably improved soundstage focus

These improvements are consistent with:

* Lower noise floor
* Restored linear gain
* Improved channel matching

---

## Lessons learned

* Intermittent transistor noise can masquerade as grounding or power amp faults
* DC correctness does not imply AC/noise correctness
* High-impedance audio stages are extremely sensitive to aged devices
* Scope amplitude alone is insufficient without understanding topology
* Once one device fails, others of the same type are likely near end-of-life

---

## Photo documentation

The following images document the preamp PCB and transistor locations referenced in this work:

* Annotated preamp PCB showing TR1 / TR2 / TR3 (right channel)
* Overall preamp PCB after recap
* Post-replacement inspection

(Images stored alongside this page directory)

---

## Conclusion

The RM-5010 preamplifier restoration confirms that **small-signal transistor ageing** can have a profound impact on both reliability and sound quality. Replacing the C1222 devices with modern low-noise equivalents fully resolved the fault and materially improved performance.

This work is considered **complete and stable**.
