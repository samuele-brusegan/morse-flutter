# MORSE — Flutter

An app to learn and translate Morse code. Flutter port of
[morse-android](https://github.com/Sapoleone/morse-android).

## Features

- **Translate**
  - Text → Morse (live translation, long-press to copy)
  - Morse → Text (on-screen `.` `-` `/` keypad + CANC/ENTER)
- **Learn**
  - **Choose**: 4-answer quiz, letter ↔ morse prompts, +100 per correct
    answer, score resets on a mistake — compete against your high score
  - **∞ Choose**: same quiz, cumulative score (+100 / −50)
  - **Words**: decode morse-encoded words (Italian scout vocabulary)
  - **Type**: type the translation of a letter/morse prompt (+100 / −50)
  - Prompt filter for quiz modes: BOTH / Only MORSE / Only TEXT
- **Account**: local username and locally persisted scores
  (`shared_preferences`) — no backend required
- Italian and English localizations, light/dark Material 3 theme

## Build

```bash
flutter pub get
flutter gen-l10n
flutter run
```

## Release (Play Store)

Signing config is read from `android/key.properties` (gitignored):

```properties
storePassword=...
keyPassword=...
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

```bash
flutter build appbundle --release
# output: build/app/outputs/bundle/release/app-release.aab
```

If `key.properties` is missing the release build falls back to the debug
key — do **not** upload that artifact to the Play Console.

- Package: `it.brusegan.morse`
- minSdk 24, target: latest Flutter default
- No data collection: scores and username stay on-device

## License

MIT — see [LICENSE](LICENSE).
