# Suwariyomi

Suwariyomi means to sit and read. Opposite of Tachiyomi which is to stand and read.

## Getting Started

1. Install [Android Studio](https://developer.android.com/studio) (or any IDE you prefer) and [Flutter](https://docs.flutter.dev/get-started/install).
2. Clone the repo with `git clone https://github.com/wooneusean/suwariyomi.git`
3. Run `flutter pub get` to retrieve dependencies.
4. Connect to Firebase*
5. Use your phone or connect your IDE to an emulator
6. Start making some changes

\* You can use the emulator or create your own Firebase project but make sure to put the API keys and whatnot into .env.example and rename it to .env.

## Building

### Development Build
The development build will be installed into your phone automatically when you start debugging.

### Release Build
You can install the development version of the app onto your phone through USB. Run this command in a terminal in your project location.
```
flutter clean
flutter build apk --release
flutter install
```

## Contributing
Create a pull request with your changes linked to an issue or enhancement.