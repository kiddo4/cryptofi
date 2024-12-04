# CryptoFi - Crypto Trading App

A modern and beautiful cryptocurrency trading app built with Flutter, following clean architecture principles and using Riverpod for state management.

## Features

- 🎨 Modern and minimal black & white UI design
- 📊 Real-time cryptocurrency price charts using TradingView
- 💼 Portfolio tracking and management
- 🔄 Live trading functionality
- 🔐 Secure authentication with Firebase
- 📱 Responsive and mobile-first design

## Setup Instructions

1. Install Flutter:
   - Follow the official Flutter installation guide: https://flutter.dev/docs/get-started/install
   - Add Flutter to your PATH

2. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/cryptofi.git
   cd cryptofi
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Setup Firebase:
   - Create a new Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and add the configuration files (google-services.json and GoogleService-Info.plist)
   - Enable Authentication and Firestore in Firebase Console

5. Run the app:
   ```bash
   flutter run
   ```

## Architecture

The app follows clean architecture principles with the following layers:
- Presentation: UI components and state management
- Domain: Business logic and entities
- Data: Repository implementations and data sources

## Technologies Used

- Flutter & Dart
- Riverpod for state management
- Firebase for backend services
- TradingView for charts
- Go Router for navigation

## Contributing

Feel free to submit issues and enhancement requests!
