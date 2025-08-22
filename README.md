# CalisFun Mobile Repository Documentation

---

## 📃 Table of Contents
- [⚙️ Technology Stack](#-technology-stack)
- [🧩 Core Features](#-core-features)
- [🚀 Live Demo](#-live-demo)
- [🏗️ Architecture Pattern](#-architecture-pattern)
- [📈 Design Pattern](#-design-pattern)
- [🧑‍💻 Clean Code](#-clean-code)
- [🔒 Security](#-test-coverage)
- [📝 CI/CD](#-ci/cd)
- [🧪 Test Coverage](#-test-coverage)
- [🤵 Demo Account Information](#-admin-account)
- [🔐 .env Configuration](#-env-configuration)
- [🧰 Getting Started Locally](#-getting-started-locally)
- [🧭 Website Preview](#-website-preview)
- [👥 Owner](#-owner)
- [📬 Contact](#-contact)

---

## ⚙️ Technology Stack

<div align="center">
<kbd><img src="https://raw.githubusercontent.com/marwin1991/profile-technology-icons/refs/heads/main/icons/flutter.png" height="60" /></kbd>
<kbd><img src="https://raw.githubusercontent.com/marwin1991/profile-technology-icons/refs/heads/main/icons/dart.png" height="60" /></kbd>
<kbd><img width="60" height="60" alt="image" src="https://github.com/user-attachments/assets/c8f92fa3-6e71-40c2-8b8d-3301c6c1f996" /></kbd>
<kbd><img width="60" height="60" alt="image" src="https://github.com/user-attachments/assets/a1d7fbb5-a3f7-415d-8d69-3625e930f38e" /></kbd>

</div>

<div align="center">
<h4>Flutter | Dart | Dio | Riverpod</h4>
</div>

---

## 🧩 Core Features

### 🔐 Authentication & User Roles
- **Role-Based Access:** Secure authentication system that separates **Parent** and **Child** accounts.  
- **Parent Role:** Full access to progress reports and child management.  
- **Child Role:** Access  to learning and gamified activities.  
- **Secure Login:** Email & password with JWT for parents.  
- **Seamless Switch:** Parents can easily switch between multiple child profiles.

### 🎮 Interactive Learning
- **Handwriting Practice:** Kids can learn to write letters and numbers interactively.  
- **Reading Practice:** Fun mini-games to improve vocabulary and spelling.  
- **Counting & Math:** Basic arithmetic exercises designed for children.  
- **Gamification:** Rewards (xp) to boost motivation and engagement.

### 📊 Progress Tracking
- **Individual Reports:** Each child’s learning progress is recorded.  
- **Daily & Weekly Insights:** Parents can monitor consistency and improvement over time.  

### 👨‍👩‍👧 Parent Control
- **Child Account Management:** Parents can create and manage multiple child profiles.  
- **Safe Environment:** Ad-free and secure learning experience for children.

---

## 🚀 Live Demo

👉 [https://calis-fun.vercel.app](https://calis-fun.vercel.app/)

---

## 🏗️ Architecture Pattern

### Repository Structure
```
├── android/ # Android native project files
├── assets/ # Application assets (images, fonts, JSON, etc.)
├── ios/ # iOS native project files
├── lib/ # Main application code (Clean Architecture)
│ ├── generated/
│ ├── src/
│ │ ├── constants/ # Enums, themes, app constants
│ │ ├── core/ # Application, data, domain, presentation
│ │ ├── network/ # API client, Dio config
│ │ ├── routes/ # App navigation
│ │ ├── shared/ # Utils, extensions
│ │ └── widgets/ # Shared UI components
│ └── main.dart # Application entry point
├── linux/ # Linux desktop support
├── macos/ # macOS desktop support
├── test/ # Unit & widget tests
├── web/ # Web support
├── windows/ # Windows desktop support
│
├── .env.development # Environment variables (development)
├── .env.example # Example environment template
├── .env.production # Environment variables (production)
├── .gitignore # Git ignore rules
├── .metadata # Flutter metadata
├── README.md # Project documentation
├── analysis_options.yaml# Linting & code analysis rules
├── pubspec.yaml # Project dependencies
├── pubspec.lock # Dependency lock file
```

### **Architecture Principles**

The architecture for the **CalisFun Mobile (Flutter)** follows a **Layered Architecture (Clean Architecture flavor)** with emphasis on **scalability, reusability, and maintainability**.

1. **Layered Architecture Pattern**

   * **Presentation Layer (UI):** `lib/src/core/presentation`, `lib/src/widgets`, `lib/src/routes`
   * **Application Layer (State & Orchestration):** `lib/src/core/application`
   * **Domain Layer (Business Rules):** `lib/src/core/domain`
   * **Infrastructure/Data Layer:** `lib/src/core/data`, `lib/src/network`
   * **Cross‑cutting:** `lib/src/constants`, `lib/src/shared`

2. **Widget‑First & Feature‑Oriented**

   * `widgets/` holds reusable UI building blocks (buttons, cards, inputs).
   * `core/presentation/` contains screens/views and their feature-specific widgets.
   * `routes/` defines typed navigation, guards, and initial routes.

3. **Separation of Concerns**

   * `core/domain/` → entities, value objects, failures, and **abstract repositories/use cases**.
   * `core/data/` → DTOs, mappers, concrete repository implementations, local (storage) & remote (API) data sources.
   * `core/application/` → **Riverpod** providers/notifiers, state classes, and use‑case orchestration.
   * `network/` → **Dio** client, interceptors (auth header, logging, retry), base endpoints.
   * `constants/` → enums, themes, design tokens, app‑wide constants.
   * `shared/` → utilities, extensions, result/either types, form validators.

4. **Scalability in Mind**

   * Clear contracts in `domain/` allow swapping data sources without touching UI.
   * Riverpod encapsulates side effects and exposes immutable states to UI.
   * Reusable widgets + centralized themes keep UI consistent and easy to evolve.
   * Testing targets:
     - **Domain** (pure business rules, 0 Flutter deps),
     - **Data** (mappings & repos with mocked I/O),
     - **Application** (providers/notifiers),
     - **Widget** tests for key screens.
   * Environment configs (`.env.development`, `.env.production`) keep endpoints/keys isolated.

5. **Flutter + Dart Setup**

   * `main.dart` → bootstraps app, sets up **ProviderScope** (Riverpod), themes, and initial route.
   * `routes/` → central navigation (Navigator 1.0/2.0) + middlewares/guards (e.g., role checks).
   * `network/dio_client.dart` → base Dio instance + interceptors (auth token, retry on 401).
   * `core/application/auth/` → auth state (sign‑in/out, token refresh) & role handling.
   * **Role‑Based Access (Parent / Child):**
     - Role stored in auth/session state (Riverpod).
     - UI composition uses guards/providers to show Parent features (reports, settings) vs Child features (learning modules).

---

## 👥 Owner

This Repository is created by Team 1
<ul>
<li>Stanley Nathanael Wijaya - Fullstack Developer</li>
<li>Haikal Iman F - Mobile Developer</li>
<li>Muhammad Favian Jiwani - Mobile Developer</li>
<li>Raditya Ramadhan - Backend Developer</li>
<li>Muhammad Ridho Ananda - Mentor</li>
</ul>
As Final Project for SEA Academy Compfest 17

---

