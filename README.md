# MetaDetect 🩺🎗️  
**Privacy-First Breast Cancer Risk Screening App**

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-success)
![Offline](https://img.shields.io/badge/Offline-100%25-brightgreen)
![License](https://img.shields.io/badge/License-Academic%20%2F%20Research-blue)

---

##  About MetaDetect
**MetaDetect** is an **offline, privacy-first breast cancer risk screening and education mobile application** designed for underserved and low-resource communities.

The app provides **clinical-grade risk assessment** using evidence-based guidelines from:
- **WHO**
- **NCCN**
- **American Cancer Society**
- **USPSTF**

>  MetaDetect is a **screening tool**, not a diagnostic system.

---

##  Key Features

###  Privacy & Security
- 100% **offline** — no internet required
- **No data collection** or cloud storage
- All data remains **on the user's device**

---

###  Clinical Screening
- Multi-step clinical risk assessment
- Personalized risk scoring (**0–100**)
- Risk stratification with urgency timelines
- Actionable, guideline-based recommendations
- Breast cancer awareness & education module

---

###  User-Centric Design
- Designed for **diverse & underserved populations**
- Simple, guided workflow
- Accessibility-focused UI
- Multilingual-ready architecture

---

##  Tech Stack

| Layer | Technology |
|------|-----------|
| Framework | Flutter (Material Design 3) |
| Language | Dart |
| State Management | Provider |
| Architecture | Offline-first |
| Platforms | Android & iOS |

---

## Project Structure
```text
lib/
├── main.dart
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── login_screen.dart
│   ├── welcome_screen.dart
│   ├── educational_screen.dart
│   └── screening_screen.dart
├── models/
│   ├── user_profile.dart
│   └── risk_result.dart
└── utils/
    └── clinical_engine.dart
