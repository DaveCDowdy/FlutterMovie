# Flutter Movie

A cross-platform movie app built with Flutter. Browse, search, and manage your favorite movies with a beautiful UI, custom icons, and splash screens for both iOS and Android.

## Features

- Browse a list of movies (offline-first)
- Search and filter by title, genre, and rating
- Mark and manage favorite movies
- Persistent favorites (local database)
- Custom splash screen and app icons
- Responsive UI for mobile and web
- Modern Flutter architecture (Riverpod, Clean Architecture)
- Unit tests for data and domain layers

## Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/DaveCDowdy/FlutterMovie.git
   cd FlutterMovie
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/` — Dart source code (data, domain, presentation layers)
- `assets/` — Images and JSON data
- `ios/` and `android/` — Platform-specific configuration and assets
- `test/` — Unit tests

## Requirements

- Flutter SDK (3.10.0 or newer recommended)
- Xcode (for iOS)
- Android Studio (for Android)

## Architecture

- **Clean Architecture**: Separation of data, domain, and presentation layers
- **State Management**: Riverpod
- **Persistence**: Floor (SQLite)
- **Testing**: Mockito, Flutter test

## License

MIT

---

Feel free to open issues or contribute!
