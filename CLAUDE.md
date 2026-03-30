# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Modulo is an iOS savings tracking app. Users define financial goals and record contributions (deposits/withdrawals) toward those goals.

Built with SwiftUI + SwiftData, targeting iOS 17+, Swift 6.2.

## Building & Running

```bash
# Build from CLI (simulator)
xcodebuild -project Modulo.xcodeproj -scheme Modulo -destination 'platform=iOS Simulator,name=iPhone 16' build

# Build a package standalone (e.g. Models)
cd Modules/Models && swift build
```

Open `Modulo.xcodeproj` in Xcode and run the `Modulo` scheme. No other build scripts exist.

## Module Graph

The project is split into 11 local Swift Packages under `Modules/`. Dependencies flow strictly bottom-up:

```
Utilities
  └── Models
        └── Persistence
              └── Repositories
                    └── Stores
                          └── Providers
                                └── DesignSystem ← Core, Navigation
                                      └── Features (Contribution, FinancialGoal, Settings)
```

External packages: `NavigationKit` (theosementa), `ToastBannerKit` (theosementa), `MCEmojiPicker` (izyumkin).

**Rule:** `Models` must never import UIKit/SwiftUI. `Features` is the only layer that imports everything.

## Architecture

### Full Stack for One Feature

1. **View** (`Features/`) — `@State private var viewModel: ViewModel`, calls methods on ViewModel, reads computed properties.
2. **ViewModel** (`Screen+ViewModel.swift`) — `@Observable @MainActor`, extends `BaseViewModel` (provides `router`). Injects a `Provider` via constructor (default = shared singleton).
3. **Provider** (`Providers/`) — Protocol + `Default` implementation. Holds a `Store` reference, exposes sorted/filtered arrays of Domain types.
4. **Store** (`Stores/`) — Protocol + `Default` + `Mock` implementations. `@Observable`, holds `[DomainType]` state, owns a `Repository`. Extension methods on the protocol provide the shared business logic (create, delete, fetch…).
5. **Repository** (`Repositories/`) — Extends `GenericRepository<Entity>`. SwiftData queries via `FetchDescriptor`. Never called directly by the UI.
6. **Persistence** — `GenericRepository<T: PersistentModel>` backed by `SwiftDataContextManager.shared` (single `ModelContainer`).

### Model Tiers

| Tier | Location | Purpose |
|------|----------|---------|
| Entity | `Models/Sources/Entities/` | `@Model` SwiftData class, persistence only |
| Domain | `Models/Sources/Domain/` | Pure Swift struct, business logic & state |
| UIModel | `Models/Sources/UIModel/` | Formatted strings ready for display (`toUIModel()`) |

Conversion chain: `Entity.toDomain()` → `Domain.toUIModel()`. Entities also have `toDetailed()` which produces a `DetailedDomain` wrapping related data.

### SwiftData Rules

- `ContributionEntity.financialGoal` is **optional** (`FinancialGoalEntity?`) to allow cascade delete from the goal side without crash.
- `FinancialGoalEntity.contributions` uses `@Relationship(deleteRule: .cascade, inverse: \ContributionEntity.financialGoal)`.
- Always add new `@Model` classes to the `ModelContainer` in `SwiftDataContextManager`.
- Paginated fetches use `FetchDescriptor.fetchOffset` + `fetchLimit`. Chart data uses per-month `FetchDescriptor` queries (never load all contributions at once).

### Navigation

All navigation uses `NavigationKit`. Routes are defined as enums conforming to `DestinationItem`:
- `FinancialGoalDestination` — `.list`, `.create`, `.update(id:)`, `.details(id:)`
- `ContributionDestination` — `.add(goalId:)`
- `SettingsDestination`

Each feature module registers its routes in `NavigationRegistry+Extensions.swift`. ViewModels navigate via `router.push(...)` inherited from `BaseViewModel` → `AppRouterManager.shared`.

### Dependency Injection

- ViewModels receive providers in their `init` with default singletons:
  ```swift
  init(provider: FinancialGoalProvider = DefaultFinancialGoalProvider.shared)
  ```
- Use `MockFinancialGoalProvider` / `MockFinancialGoalStore` in Previews and tests.
- `MockFinancialGoalStore` overrides all protocol extension methods with in-memory implementations using `FinancialGoalDomain.mocks` and `ContributionDomain.mocks(for: goalId)`.

## Key Conventions

- **Screen + ViewModel split**: each screen has `ScreenName.swift` and `ScreenName+ViewModel.swift`. ViewModel is a nested `extension ScreenName { @Observable @MainActor final class ViewModel }`.
- **Subviews**: extracted as `fileprivate extension ScreenName` computed properties or functions (`var headerView: some View`, `func rowView(...) -> some View`).
- **Protocols avoid `mutating`** by constraining to `: AnyObject`.
- **`currentAmount`** on `FinancialGoalDomain` is computed at `toDomain()` time via a `reduce` over contributions — it is not stored in the entity.
- **Localization**: string keys use `"key".localized`. TODOs are marked `// TODO: TBL` for untranslated strings.
- **DesignSystem spacing**: use semantic spacing constants (`.small`, `.medium`, `.standard`, `.mediumLarge`) — never raw numbers.
- **Icons**: always use `ImageType` enum cases (in `Models/Sources/Enums/ImageType.swift`). Never use SF Symbols directly.

## File Placement

| What | Where |
|------|-------|
| New screen | `Modules/Features/Sources/<FeatureName>/Screens/<ScreenName>/` |
| New reusable component | `Modules/DesignSystem/Sources/Composants/` |
| New domain model | `Modules/Models/Sources/Domain/` |
| New SwiftData entity | `Modules/Models/Sources/Entities/` + register in `SwiftDataContextManager` |
| New store + mock | `Modules/Stores/Sources/<FeatureName>/` |
| New provider | `Modules/Providers/Sources/<FeatureName>/` |
| New navigation destination | `Modules/Navigation/Sources/Destinations/` |
| Route registration | `Modules/Features/Sources/<Feature>/Navigation/NavigationRegistry+Extensions.swift` |
| New icon | `Modules/DesignSystem/Sources/Resources/Icons.xcassets/` + add case to `ImageType` |
