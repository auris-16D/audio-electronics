#!/usr/bin/env bash
set -e

BASE_DIR="content/learning_framework"

create_phase() {
  local phase_dir="$1"
  local title="$2"
  local summary="$3"
  local purpose="$4"
  shift 4
  local concepts=("$@")

  local dir="$BASE_DIR/$phase_dir"
  local file="$dir/_index.md"

  mkdir -p "$dir"

  if [ -f "$file" ]; then
    echo "Skipped $file (already exists)"
    return
  fi

  cat > "$file" <<EOF
---
title: "$title"
section: "Learning Framework"
status: "planned"
summary: "$summary"
---

## Purpose

$purpose

## Covered Concepts
EOF

  for concept in "${concepts[@]}"; do
    echo "- $concept" >> "$file"
  done

  cat >> "$file" <<'EOF'

## Outcomes

After completing this phase, you should be able to:
- Reason confidently about the concepts introduced in this phase
- Apply them to audio-focused electronics problems
- Prepare for the next phase without conceptual gaps

## Notes

This phase is part of the Audio Electronics Learning Framework.
EOF

  echo "Created $file"
}

create_phase \
  "phase-1" \
  "Phase 1 — Signal-Centric Foundations" \
  "Build correct mental models of signals before introducing components or maths." \
  "Establish a signal-first way of thinking about electronics, using audio as the primary context." \
  "AC vs DC signals" \
  "Signal flow and block thinking" \
  "Reference, ground, and return" \
  "Gain and attenuation" \
  "Measurement as intent-driven reasoning"

create_phase \
  "phase-1-5" \
  "Phase 1.5 — Functional Patterns (Bridge Phase)" \
  "Learn to recognise stages and functional groupings on schematics." \
  "Bridge conceptual signal thinking to real component groupings seen on schematics." \
  "What defines a stage electrically" \
  "Common functional groupings" \
  "Separating signal path from support circuitry" \
  "Recognising boundaries on real schematics"

create_phase \
  "phase-2" \
  "Phase 2 — Passive Components in Context" \
  "Understand passive components as signal-shaping tools." \
  "Introduce passive components in service of signal behaviour and failure modes." \
  "Resistors: roles, noise, drift" \
  "Capacitors: coupling, bypassing, aging" \
  "Inductors and transformers" \
  "Passive networks as functional blocks"

create_phase \
  "phase-3" \
  "Phase 3 — Active Devices as Signal Controllers" \
  "Understand transistors by behaviour and role, not physics-first." \
  "Introduce active devices as controlled elements within signal paths." \
  "Amplification and buffering" \
  "Biasing as enabling AC operation" \
  "Typical transistor stages" \
  "Non-ideal behaviour relevant to audio"

create_phase \
  "phase-4" \
  "Phase 4 — Power, Reference, and Stability" \
  "Control the environment in which signals operate." \
  "Understand how power, grounding, and stability affect circuit behaviour." \
  "Linear power supplies and regulators" \
  "Grounding strategies and pitfalls" \
  "Decoupling and stability" \
  "Noise, hum, and oscillation" \
  "Protection circuits"

create_phase \
  "phase-5" \
  "Phase 5 — Measurement & Test Equipment (Integrated)" \
  "Use test equipment deliberately and correctly." \
  "Introduce tools only where they directly support reasoning and diagnosis." \
  "Multimeter usage and limits" \
  "Oscilloscope fundamentals" \
  "AC/DC coupling and reference selection" \
  "Signal generators and dummy loads" \
  "Safety and isolation tools"

create_phase \
  "phase-6" \
  "Phase 6 — System-Level Audio Circuits" \
  "Integrate concepts into complete audio systems." \
  "Apply all prior knowledge to full audio circuit designs." \
  "Preamplifiers" \
  "Tone control circuits" \
  "Power amplifiers" \
  "Feedback as a system tool" \
  "End-to-end signal integrity"

create_phase \
  "phase-7" \
  "Phase 7 — Guided Fault Diagnosis" \
  "Develop real diagnostic capability through practice." \
  "Apply structured reasoning to real fault scenarios without given diagnoses." \
  "Interactive fault scenarios" \
  "Measurement-driven diagnosis" \
  "Guided hints on request" \
  "Post-diagnosis analysis"

create_phase \
  "phase-8" \
  "Phase 8 — Vintage Reality & Failure Modes" \
  "Handle aging equipment and real-world constraints." \
  "Understand how time, wear, and prior repairs affect electronics." \
  "Component aging and drift" \
  "Mechanical failures" \
  "Previous repair artefacts" \
  "Risk-based repair decisions"

create_phase \
  "phase-9" \
  "Phase 9 — Generalisation Beyond Audio" \
  "Ensure skills transfer beyond audio electronics." \
  "Apply the same reasoning framework to non-audio electronic systems." \
  "Recognising familiar patterns in new domains" \
  "Knowing where audio intuition no longer applies"
