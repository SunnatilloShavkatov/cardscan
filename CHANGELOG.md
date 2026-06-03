## 1.0.0

* **BREAKING:** Renamed Android package from `uz.shs.cardscan` to `uz.shs.shs_cardscan`. App developers consuming the plugin do not need changes; downstream Android code referencing the package must update imports.
* **BREAKING:** Renamed Flutter `MethodChannel` from `cardscan` to `shs_cardscan`. Affects only direct channel consumers; users of the public Dart API are unaffected.
* Feat: Added iOS Swift Package Manager (SPM) support alongside CocoaPods. New `ios/shs_cardscan/Package.swift` with a dedicated `CardScanObjC` target for the Objective-C model wrapper to satisfy SPM's mixed-language restriction.
* Feat: Added `defaultLocalization: "en"` and `Bundle.module` resource loading for SPM-based consumers.
* Chore: Bumped minimum Flutter to `3.44.0` and Dart SDK to `3.12.0`.
* Chore: Pinned Android Kotlin Gradle Plugin to `2.2.20` to match prebuilt vendored libraries; migration to Flutter's built-in Kotlin is deferred until Flutter ships a bundled KGP compatible with Kotlin 2.2 metadata.
* Chore: Added `flutter.android.skipBuildDependencyValidation=true` to the example `gradle.properties` to suppress the Kotlin-version validation warning while the bundled KGP catches up.

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
