# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Modulo is an iOS savings tracking app. Users can define financial goals and record contributions (deposits/withdrawals) toward those goals.

Built with SwiftUI + SwiftData, targeting iOS 17+, using Swift 6.2.

## Building & Running

Open `Modulo.xcodeproj` in Xcode and run the `Modulo` scheme on a simulator or device. There is no CLI build script — use Xcode or `xcodebuild`.

```bash
# Build from CLI (simulator)
xcodebuild -project Modulo.xcodeproj -scheme Modulo -destination 'platform=iOS Simulator,name=iPhone 16' build

# Build the Models package standalone
cd Modules/Models && swift build
```

## Architecture

### Modular Structure

The project is split into:
- **Modulo/** — SwiftUI app (entry point, screens, views)
- **Modules/Models/** — local Swift Package with domain models and SwiftData entities

### Layers within the Models package

| Layer | Location | Purpose |
|-------|----------|---------|
| Domain | `Sources/Domain/` | Pure Swift structs for the app's business logic (e.g., `FinancialGoalDomain`) |
| Entities | `Sources/Entities/` | `@Model` classes for SwiftData persistence (e.g., `FinancialGoalEntity`, `ContributionEntity`) |
| Enums | `Sources/Enums/` | Shared enumerations (e.g., `ContributionType`: `.add` / `.remove`) |

Domain types and entities are kept separate — entities are only for persistence, domain types are what the UI works with.

### Data Model

- A `FinancialGoalEntity` has a name, emoji, goal amount, optional goal date, and a one-to-many relationship to `ContributionEntity` (cascade delete).
- A `ContributionEntity` records a single contribution: amount, type (add/remove), date, and optional name.

### App Capabilities

CloudKit + remote notifications are configured (entitlements set for development). SwiftData is used for local persistence.

## Key Conventions

- New screens go in `Modulo/` alongside existing screens (e.g., `RootScreen.swift`).
- New domain types go in `Modules/Models/Sources/Domain/`.
- New SwiftData models go in `Modules/Models/Sources/Entities/` and must be added to the `ModelContainer`.
- The Models package is a `library` product — keep it free of UIKit/SwiftUI imports.
