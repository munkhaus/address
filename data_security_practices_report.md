# Data Security Practices Report

## Overview

This report assesses data security practices across the application's Dart, Android, and iOS codebases. It covers local data storage, in-memory data handling, platform-specific screen security features, clipboard usage, and overall data collection.

## Dart Code Analysis

### 1. Local Data Storage (SharedPreferences, Files)

*   **Finding:** No evidence of `SharedPreferences` usage or direct file system I/O for storing sensitive application-specific data (like credentials or API keys) was found in the Dart codebase. The application primarily relies on in-memory state management for session data.
*   **Assessment:** Secure. No sensitive data is persisted locally by the Dart code.

### 2. Hardcoded Encryption Keys

*   **Finding:** No hardcoded encryption keys, cryptographic libraries, or custom encryption logic was identified within the Dart code.
*   **Assessment:** Secure. No risk of compromised encryption due to hardcoded keys.

### 3. In-Memory Data Handling

*   **Data Handled:**
    *   User's current geographical location (`LatLng`).
    *   Address search queries (strings).
    *   Lists of address suggestions (`AddressSuggestion` models).
    *   Map markers.
*   **Handling:** This data is stored in BLoC/Cubit states (`MapState`, `AddressSearchState`) during an active user session. It is essential for the application's core functionality (displaying maps, search results, markers). Data is cleared or reset when searches are cleared, new searches are performed, or the app is re-initialized.
*   **Assessment:** Appropriate. The in-memory data is session-specific, necessary for functionality, and not persisted. Standard good practice for mobile app state management.

### 4. Clipboard Writing

*   **Finding:** No programmatic writing of data to the system clipboard was observed in the Dart code.
*   **Assessment:** Secure. No risk of sensitive data being inadvertently exposed via the clipboard.

## Android Native Code Analysis (`MainActivity.kt`)

### `FLAG_SECURE` Implementation

*   **Finding:** The `MainActivity.kt` file does not implement `getWindow().addFlags(LayoutParams.FLAG_SECURE)`.
*   **Impact:** This means the Android system can take screenshots of the app, the app's content can be recorded by screen recording apps, and a preview of the app's screen may be visible in the recent apps switcher. For an app displaying potentially private location information or search history, this could be a privacy concern.
*   **Assessment:** Needs Improvement.

## iOS Native Code Analysis (`AppDelegate.swift`)

### Background Snapshot Protection

*   **Finding:** The `AppDelegate.swift` file does not implement measures to protect against background snapshotting (e.g., by adding an overlay or blurring the screen in `applicationWillResignActive` or `applicationDidEnterBackground`).
*   **Impact:** A snapshot of the app's last active screen will be visible in the iOS app switcher. Similar to Android, this could expose private location information or search history.
*   **Assessment:** Needs Improvement.

## Data Collection Practices

*   **Data Collected:**
    *   User's current location (latitude, longitude) upon request or for initial map centering.
    *   User-entered search queries for addresses.
*   **Usage:** This data is fundamental to the application's purpose of finding addresses and displaying them on a map. The Nominatim API (a public service) is used for address lookups, and its usage is subject to its own privacy policy.
*   **Assessment:** Minimal and Justified. The data collected is essential for the app's core functionality. No unnecessary data collection was observed.

## Summary & Recommendations

*   **Dart code data handling (local storage, in-memory, clipboard) is generally secure and follows good practices.**
*   **Native platform protections for screen content are missing on both Android and iOS.**
    *   **Android:** Implement `FLAG_SECURE` in `MainActivity.kt`.
    *   **iOS:** Implement background snapshot protection in `AppDelegate.swift`.
*   **Data collection is minimal and justified for the app's purpose.**

These recommendations will be added to `actionable_security_recommendations.md`.
