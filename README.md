# MyPet 🐾  
Smart appointment & pet management for veterinary clinics

![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue?logo=flutter)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-lightgrey)

---

## Overview

**MyPet** is a cross-platform mobile application built with Flutter that helps **veterinary clinics** manage clients, pets, and appointments in a single, easy-to-use interface.  
The goal is to reduce time spent on manual paperwork and make it easier for vets and staff to keep track of visits, vaccines, and follow-up activities.

The app is designed to run on both **iOS and Android** devices and can be extended to desktop/web thanks to Flutter’s multi-platform support.

---

## Key Features

- 📅 **Appointment management**  
  Create, update, and cancel appointments for each client and pet in just a few taps.

- 🐶 **Pet profiles**  
  Store essential information for every pet (name, species, breed, notes, etc.) so that vets always have context during a visit.

- ⏰ **Reminders for important events**  
  Set reminders for visits, vaccinations, check-ups, and other key activities to reduce the risk of missed appointments.

- 👥 **Client–pet linkage**  
  Keep track of which owner is associated with which pet and all their upcoming appointments.

- 💼 **Built for small and medium clinics**  
  Focus on simplicity and speed over complex practice-management suites.

> **Status:** Personal project, actively evolving. Ideal as a base for a lightweight clinic management tool.

---

## Tech Stack

MyPet is implemented as a standard Flutter project with platform-specific support folders for Android, iOS, web, Windows, macOS, and Linux.

- **Framework:** Flutter  
- **Language:** Dart  
- **Targets:** Android, iOS (Flutter also generates scaffolding for web & desktop)  
- **Project structure:**  
  - `lib/` — application source code (UI, navigation, business logic)  
  - `assets/icons/` — custom icons and graphical assets  
  - `test/` — space for unit and widget tests  
  - Platform folders: `android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`

---

## Core User Flows

1. **Clinic staff opens the app** on a mobile device.
2. **Selects a client and pet** from the list or creates them if they don’t exist yet.
3. **Schedules a new appointment**, specifying date, time, and reason for the visit.
4. Optionally **adds a reminder** for vaccines or follow-up visits.
5. On the day of the visit, staff can quickly **review the pet’s profile** and upcoming appointments.

These flows are intentionally streamlined to minimise the number of taps needed during a busy workday.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android Studio or VS Code with Flutter/Dart plugins
- An Android emulator, iOS simulator, or physical device

### Clone the repository

```bash
git clone https://github.com/alfredocarta/MyPet.git
cd MyPet
