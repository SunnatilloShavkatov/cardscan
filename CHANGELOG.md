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
