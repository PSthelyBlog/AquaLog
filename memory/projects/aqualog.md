# AquaLog

## Overview
iOS hydration tracker. Users tap a button to log each glass of water and see progress as an animated ring chart toward a daily goal of 8 glasses.

## Key Decisions
- **iOS 17+** minimum (required for SwiftData)
- **Fixed goal of 8 glasses** for MVP (customizable in v1.1)
- **Individual timestamps** per log entry (not daily counts) to support future history view
- **No accounts, no cloud sync** — local-only for MVP
- **Single-screen SwiftUI app** — no navigation for v1

## Documents
- `AquaLog-PRD.docx` — full product requirements document
- `AquaLog-Roadmap.xlsx` — Now/Next/Later roadmap with effort estimates

## Timeline
- MVP: 2 weekends (~13 hrs estimated for P0 items)
- v1.1: March–April (customizable goal, history, undo, haptics)
- v2.0+: Later (Apple Watch, HealthKit, widget, reminders)
