## 0.0.4

* Fix: Removed vendored TensorFlow Lite `x86` and `x86_64` JNI slices from the Android package to avoid Google Play 16 KB page size warnings caused by the legacy desktop/emulator prebuilt.
* Docs: Clarified that Android emulator testing should use an ARM image or a physical device because the scanner runtime now ships only `armeabi-v7a` and `arm64-v8a`.

## 0.0.3

* Fix: Resolved Android release build issues caused by missing `Parcelize` runtime classes.
* Fix: Added a release-only `integration_test` Android stub so release APK/AAB builds complete reliably.
* Fix: Limited Android release builds to `armeabi-v7a` and `arm64-v8a` to avoid shipping non-compliant desktop/emulator native slices to Google Play.
* Docs: Updated installation version and Android release notes.

## 0.0.2

* Fix: Resolved crash on iOS due to module mismatch in storyboard.
* Fix: Adjusted 'Back' button position to respect Safe Area on iOS.
* Internal: Corrected bundle identifier in `CSBundle.swift` for proper resource loading.

## 0.0.1

* Add native card scanning support for Android and iOS.
* Add `isSupported()` and `scanCard()` Flutter API.
* Add on-device card number and expiry extraction support.
* Remove API key requirement from the Android flow.
* Bundle native platform implementations inside the Flutter package.
