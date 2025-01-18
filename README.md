# Stroll: Voice-Initiated Dating App

## Overview

**Stroll** is a Flutter-based, voice-initiated dating app designed to make dating memorable and fun again. Our mission is to become one of the top 2 dating apps globally within the next 3 years by fostering sincere and meaningful connections.

This app includes unique features such as voice-initiated interactions, voice notes, and real-time translations to enhance communication between users, no matter their language or location.

---

## Features

- **Auth**: Secure user authentication using industry-standard practices.
- **Bonfire**: Engage in group voice chats to meet multiple potential matches in a lively and fun setting.
- **Chat**: Real-time messaging with text, voice notes, and automatic translations for seamless communication.
- **Match**: Intuitive matching system to connect users with shared interests and compatibility.
- **Profile**: Personalized profiles to showcase interests, preferences, and voice intros.

---

## Project Structure

The project is organized into feature-based modules for scalability and maintainability:

```
lib/
├── config/               # app configurations
├── features/             # Feature-based modules
│   ├── auth/             # User authentication
│   ├── bonfire/          # Group voice chat functionality
│   ├── chat/             # One-on-one and group chat features
│   ├── match/            # Matching logic and components
│   ├── profile/          # User profile and preferences
|── routers/               # App navigation
|── shared/               # shared utilities, constants, widgets
├── main.dart             # Entry point for the app
├── main_development.dart # Entry point for the development flavor
├── main_staging.dart     # Entry point for the staging flavor
├── main_production.dart  # Entry point for the production flavor
```

---

## Getting Started

### Prerequisites

Ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install): Version 3.x or above
- Dart: Version 3.x or above
- IDE: Visual Studio Code, Android Studio, or IntelliJ IDEA

### Installation

1. **Clone the repository**:
   ```bash
   https://github.com/Andhrah/stroll-mobile-task.git
   cd stroll
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure build flavors**:
   Follow the steps below to set up build flavors for development, staging, and production:
   - Open `android/app/build.gradle` and ensure flavor configurations are set.
   - For iOS, configure schemes and targets in Xcode (refer to the [Flutter Flavors Documentation](https://docs.flutter.dev/deployment/flavors)).

4. **Run the application**:
   - For development:
     ```bash
     flutter run --flavor development --target lib/main_development.dart
     ```
   - For staging:
     ```bash
     flutter run --flavor staging --target lib/main_staging.dart
     ```
   - For production:
     ```bash
     flutter run --flavor production --target lib/main_production.dart
     ```

---

## Testing

The project includes unit and widget tests to ensure feature reliability and UI integrity. To run tests:

```bash
flutter test
```

---

## Roadmap

- **Phase 1**: Build core features (auth, match, profile, chat).
- **Phase 2**: Integrate voice-based features and translation capabilities.
- **Phase 3**: Launch the app globally and refine the user experience based on feedback.

---

## License

This project is licensed under the [MIT License](LICENSE).

