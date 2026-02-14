# Flutter Movie App – Project Instructions

## Author: Expert Flutter Engineer

---

## Project Goals
- Migrate a native Android movie app to Flutter
- Use Clean Architecture and SOLID principles
- Leverage modern Flutter best practices
- Ensure maintainability, testability, and scalability

---

## Dependencies
Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  json_annotation: ^4.8.1
  cached_network_image: ^3.3.1
  floor: ^1.4.2
  sqflite: ^2.3.2
  path_provider: ^2.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
  floor_generator: ^1.4.2
  mockito: ^5.4.4
  integration_test:
    sdk: flutter
  flutter_lints: ^3.0.1
```

---

## Project Structure

```
lib/
  core/
    constants.dart
    theme.dart
    utils.dart
  data/
    datasources/
      local/
        movie_local_data_source.dart
        movie_json_parser.dart
        movie_database.dart
    models/
      movie_model.dart
    repositories/
      movie_repository_impl.dart
    mappers/
      movie_mapper.dart
  domain/
    entities/
      movie.dart
    repositories/
      movie_repository.dart
    usecases/
      get_movies.dart
      search_movies.dart
      manage_favorites.dart
  presentation/
    screens/
      home_screen.dart
      search_screen.dart
      favorites_screen.dart
      movie_detail_screen.dart
    widgets/
      movie_card.dart
      search_bar.dart
    providers/
      movie_provider.dart
      favorites_provider.dart
main.dart
assets/
  movies.json
  images/
test/
  (mirrors lib/ structure)
```

---

## Architecture & Principles

- **Clean Architecture:**
  - Separate UI, domain, and data layers
  - Use dependency inversion: UI depends on abstractions, not implementations
- **SOLID Principles:**
  - Single Responsibility: Each class/file has one responsibility
  - Open/Closed: Classes are open for extension, closed for modification
  - Liskov Substitution: Use interfaces/abstract classes for flexibility
  - Interface Segregation: Prefer small, focused interfaces
  - Dependency Inversion: Rely on abstractions, inject dependencies via Riverpod
- **Riverpod:**
  - Use Riverpod for all state management and dependency injection
  - Define providers for repositories, use cases, and UI state
- **Testing:**
  - Write unit, widget, and integration tests
  - Use `mockito` for mocking dependencies
  - Mirror `lib/` structure in `test/`
- **Code Generation:**
  - Use `json_serializable` for model serialization
  - Use `floor` and `floor_generator` for database codegen
- **Assets:**
  - Store bundled JSON and images in `assets/`
  - Register assets in `pubspec.yaml`
- **UI:**
  - Use Material 3 widgets and theming
  - Use `cached_network_image` for image loading
  - Support dark mode and accessibility

---

## Best Practices
- Use `ProviderScope` at the root of your app
- Keep widgets small and composable
- Use immutable data models
- Prefer stateless widgets and pure functions
- Document public APIs and complex logic
- Use lints and format code consistently
- Review and update dependencies regularly

---

## Getting Started
1. Install dependencies: `flutter pub get`
2. Generate code: `flutter pub run build_runner build --delete-conflicting-outputs`
3. Run the app: `flutter run`
4. Run tests: `flutter test`

---

## Contribution
- Follow this structure and these conventions for all new code
- Write tests for all new features and bug fixes
- Use pull requests and code reviews to maintain quality

---

## License
This project is licensed under the MIT License.

