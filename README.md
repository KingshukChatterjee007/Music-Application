# 🎵 Vibe Music Player

**A modern, local music player built with Flutter, BLoC architecture, and a stunning Neumorphic design.**
<br />

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter" alt="Flutter Version" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart" alt="Dart Version" />
  <img src="https://img.shields.io/badge/State%20Management-BLoC-blueviolet" alt="State Management" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-A4C639?logo=android" alt="Platform" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License" />
</div>

## 📖 About

Vibe Music Player is not just another tutorial app; it's a robust, fully functional music player designed to scan, organize, and play local audio files on your device.

It features a clean **Neumorphic UI** for the home screen and a dedicated **Dark Mode** for the immersive player view. Under the hood, it uses the **BLoC (Business Logic Component)** pattern to separate UI from logic, ensuring scalability and testability.

## ✨ Key Features

* **🎧 Local Audio Scanning**: Automatically fetches all MP3 and audio files from device storage using `on_audio_query`.
* **🧠 BLoC State Management**: Professional-grade state management for predictable app behavior.
* **🎨 Dynamic UI**:
    * **Home:** Clean, light-themed Neumorphic design.
    * **Player:** Immersive, dark-themed "Now Playing" screen.
* **🖼️ Random Artwork Generation**: Automatically assigns aesthetic cover art to tracks from a local asset pool.
* **🔐 Android 13+ Ready**: Fully compliant with the latest Android permission models (`READ_MEDIA_AUDIO`).
* **💾 Favorites System**: Persist your favorite tracks using a local SQLite database (`sqflite`).
* **🚀 Smooth Onboarding**: Intro tutorial screens to guide new users.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) & [`equatable`](https://pub.dev/packages/equatable)
* **Audio Engine:** [`just_audio`](https://pub.dev/packages/just_audio)
* **Device Querying:** [`on_audio_query`](https://pub.dev/packages/on_audio_query)
* **Permissions:** [`permission_handler`](https://pub.dev/packages/permission_handler)
* **Local Database:** [`sqflite`](https://pub.dev/packages/sqflite)
* **UI Extras:** [`shimmer_effect`](https://pub.dev/packages/shimmer_effect), [`layout_pro`](https://pub.dev/packages/layout_pro)

## 📂 Project Structure

```text
lib/
├── bloc/                  # Business Logic Components (State Management)
│   ├── album_bloc/        # Logic for Album organization
│   ├── boarding_bloc/     # Logic for Onboarding flow
│   ├── home_bloc/         # Logic for Home screen & Song fetching
│   └── player_bloc/       # Logic for Audio Playback control
├── db_helper/             # SQLite Database helpers
├── model/                 # Data models (Song, AudioFile)
├── res/                   # Resources (Colors, Images, Strings)
├── view/                  # UI Screens
│   ├── home/              # Home Screen (Song List)
│   ├── on_boarding/       # Intro Tutorial Screens
│   ├── player/            # Now Playing Screen
│   └── splash/            # Splash Screen
└── main.dart              # Entry point & Theme config
