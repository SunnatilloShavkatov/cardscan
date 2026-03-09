# cardscan

`cardscan` is a Flutter plugin for on-device payment card scanning on Android and iOS.

It returns a small neutral result model:

- `cardNumber`
- `expiryMonth`
- `expiryYear`
- `cardholderName`
- `networkName`

## Install

```yaml
dependencies:
  cardscan: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:cardscan/cardscan.dart';

const scanner = Cardscan();

final supported = await scanner.isSupported();
if (!supported) {
  return;
}

final result = await scanner.scanCard(
  const CardScanOptions(
    enableExpiryExtraction: true,
    enableNameExtraction: false,
    enableEnterManually: true,
  ),
);
```

Example result:

```dart
CardScanResult(
  cardNumber: '8600123412341234',
  expiryMonth: '08',
  expiryYear: '28',
  cardholderName: null,
  networkName: 'Uzcard',
)
```

If the user cancels, `null` is returned.

## Permissions

### Android

Make sure your app has camera permission:

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

### iOS

Add a camera usage description to your app `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required to scan payment cards.</string>
```

## Features

- Native scanner UI on Android and iOS
- On-device card number detection
- Expiry extraction support
- No API key required
- Simple Flutter API with `isSupported()` and `scanCard()`

## Notes

- Android and iOS native implementations are bundled with this plugin.
- The native scanner code is based on modified MIT-licensed legacy CardScan implementations.
- Scan quality depends on camera focus, glare, lighting, and the card layout.

## Development verification

Validated locally with:

- `flutter test`
- `flutter analyze`
- `flutter build apk --debug` in `example/`
- `flutter build ios --simulator --no-codesign` in `example/`
