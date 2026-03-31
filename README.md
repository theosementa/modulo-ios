# Modulo

[![Quality Phase](https://github.com/theosementa/modulo-ios/actions/workflows/quality.yml/badge.svg)](https://github.com/theosementa/modulo-ios/actions/workflows/quality.yml)
![Swift](https://img.shields.io/badge/Swift-6.1-F05138?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-17%2B-000000?logo=apple&logoColor=white)
[![Roadmap](https://img.shields.io/badge/Roadmap-GitHub%20Projects-0D96F6?logo=github)](https://github.com/theosementa/modulo-ios/projects)
![App Store](https://img.shields.io/badge/App%20Store-Coming%20Soon-0D96F6?logo=app-store&logoColor=white)
[![Figma](https://img.shields.io/badge/Figma-Design-F24E1E?logo=figma&logoColor=white)](https://www.figma.com/design/uTGmdDAvUopqBAdL5VSC8o/Modulo-v2?node-id=1-5&t=QwxXDSNasY1lKJvw-1)
![SonarQube](https://img.shields.io/badge/SonarQube-Analyzed-4E9BCD?logo=sonarqube&logoColor=white)
[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey)](./LICENSE)

> A clean, focused savings tracker for iOS — set goals, log contributions, and watch your progress over time.

---

## Features

- **Multi-goal tracking** — Create as many savings goals as you need, each with a target amount and optional deadline
- **Contributions** — Log deposits and withdrawals per goal, with an optional label and date
- **Charts** — Visualize your monthly net contributions over time with an interactive line chart
- **iCloud Sync** — Your data syncs automatically across your devices via CloudKit
- **Customization** — Choose your accent theme color and toggle haptic feedback
- **🤖 Local AI** *(coming soon)* — On-device AI integration to give you insights on your savings

---

## Screenshots

<img width="1920" height="1440" alt="394_1x_shots_so" src="https://github.com/user-attachments/assets/ab077052-239d-419e-8ba2-079b23889bc6" />

---

## Tech Stack

| | |
|---|---|
| **Language** | Swift 6.1 |
| **UI** | SwiftUI |
| **Persistence** | SwiftData + CloudKit |
| **Architecture** | Clean Architecture — modular Swift packages (Domain / Repository / Store / Provider) |
| **Navigation** | [NavigationKit](https://github.com/theosementa/NavigationKit) |
| **Code Quality** | SwiftLint · SonarQube · MobSF |

---

## Architecture

The project is split into 11 local Swift packages under `Modules/`, with a strict unidirectional dependency graph:

```
Utilities → Models → Persistence → Repositories → Stores → Providers → DesignSystem → Features
```

Each feature follows a layered pattern: `View → ViewModel → Provider → Store → Repository → SwiftData`.

See [CLAUDE.md](./CLAUDE.md) for a detailed breakdown of conventions and file placement.

---

## Getting Started

**Requirements:** Xcode 16+, iOS 17+ simulator or device.

```bash
git clone https://github.com/theosementa/modulo-ios.git
cd modulo-ios
open Modulo.xcodeproj
```

Select the `Modulo` scheme, choose a simulator, and hit **Run**. No additional setup required.

---

## Roadmap

Upcoming features and improvements are tracked on the [GitHub Project board](https://github.com/theosementa/modulo-ios/projects).

Feature requests and suggestions are welcome — feel free to [open an issue](https://github.com/theosementa/modulo-ios/issues/new).

---

## Contributing

Contributions are welcome! Feel free to open an issue to report a bug, suggest a feature, or discuss the architecture. Pull requests are appreciated.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes
4. Open a pull request against `develop`

---

## Author & Contributors

| Role | Person |
|---|---|
| Architect & Developer | [**Theo Sementa**](https://x.com/theosementa) |
| App Icons Design | **Zoé Cridel** |
| AI Developer | **Claude** (Anthropic) |
