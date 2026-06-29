# pola_editorial

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Uruchamianie aplikacji

Aplikacja wykorzystuje klucz API, który musi zostać przekazany w czasie uruchamiania / budowania z wykorzystaniem `--dart-define`.

Aby uruchomić aplikację w trybie deweloperskim z podanym kluczem API, wykonaj polecenie w terminalu:

```bash
flutter run --dart-define=POLA_API_KEY=TWOJ_KLUCZ_API
```

### Budowanie aplikacji (APK)

Aby wygenerować plik instalacyjny APK z poprawnie wstrzykniętym kluczem API (np. do przetestowania na fizycznym telefonie), użyj poniższego polecenia:

```bash
flutter build apk --dart-define=POLA_API_KEY=TWOJ_KLUCZ_API
```

Po zakończeniu procesu budowania, gotowy plik APK znajdziesz w ścieżce:
`build/app/outputs/flutter-apk/app-release.apk`
