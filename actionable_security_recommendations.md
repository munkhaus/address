# Actionable Security Recommendations

This document lists actionable security recommendations based on the codebase analysis, prioritized by perceived importance for this application.

## Critical

### 1. Add Location Permission Usage Description on iOS

*   **Priority:** Critical
*   **File:** `ios/Runner/Info.plist`
*   **Issue:** The `Info.plist` file is missing the required `NSLocationWhenInUseUsageDescription` (and/or `NSLocationAlwaysUsageDescription`, `NSLocationAlwaysAndWhenInUseUsageDescription`) key. This will prevent the app from correctly requesting and using location services on iOS, or may lead to app rejection by Apple.
*   **Recommendation:** Add the appropriate location usage description key(s) to `Info.plist` to inform users why the app is requesting location permissions and ensure basic functionality.
*   **Implementation:**
    ```xml
    <!-- Add this within the main <dict> tag in Info.plist -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We need your location to display it on the map and find nearby addresses.</string>
    <!-- Optionally, if you require background location or more precise descriptions: -->
    <!--
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This app needs your location to show your position on the map and search for addresses, even when the app is in the background.</string>
    <key>NSLocationUsageDescription</key>
    <string>This app needs your location to show your position on the map and search for addresses.</string>
    -->
    ```

## High

### 1. Implement `FLAG_SECURE` on Android (Screen Capture and Recents Privacy)

*   **Priority:** High
*   **File:** `android/app/src/main/kotlin/com/example/flutter_application_9/MainActivity.kt`
*   **Issue:** The application does not currently prevent screenshots, screen recording, or its content being visible in the recent apps switcher on Android. This is a privacy concern when displaying location or search information.
*   **Recommendation:** Add `FLAG_SECURE` to the main activity window to enhance privacy.
*   **Implementation:**
    ```kotlin
    package com.example.flutter_application_9

    import io.flutter.embedding.android.FlutterActivity
    import android.view.WindowManager.LayoutParams // Import LayoutParams
    import android.os.Bundle // Import Bundle

    class MainActivity : FlutterActivity() {
        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                window.addFlags(LayoutParams.FLAG_SECURE)
            }
        }
    }
    ```

### 2. Implement Background Snapshot Protection on iOS (App Switcher Privacy)

*   **Priority:** High
*   **File:** `ios/Runner/AppDelegate.swift`
*   **Issue:** The application does not currently obscure its content when backgrounded on iOS, meaning a snapshot of its last state is visible in the app switcher. This is a privacy concern.
*   **Recommendation:** Add a privacy overlay or blur the screen when the application enters the background.
*   **Implementation Sketch (Conceptual):**
    ```swift
    // ... (Fuller example in the detailed report)
    override func applicationWillResignActive(_ application: UIApplication) {
        // Logic to add a covering view or blur effect
    }
    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Logic to remove the covering view or blur effect
    }
    ```
    *(Refer to `data_security_practices_report.md` or `platform_specific_security_report.md` for a more complete conceptual example)*

## Medium

### 1. Update User-Agent Email for Nominatim API

*   **Priority:** Medium
*   **File:** `lib/map_feature/infrastructure/constants/nominatim_api_keys.dart`
*   **Issue:** The User-Agent string sent to the Nominatim API currently contains a placeholder email. Nominatim's usage policy requires a valid contact email.
*   **Recommendation:** Change the placeholder email to a real contact email address for policy compliance and operational communication.
*   **Implementation:**
    ```dart
    // static const String userAgent = 'FlutterOSMAddressFinder/1.0 (flutter.app@example.com)';
    static const String userAgent = 'FlutterOSMAddressFinder/1.0 (your-actual-email@example.com)'; // Replace
    ```

### 2. Implement Security-Focused Unit and Integration Tests

*   **Priority:** Medium
*   **Context:** The current test suite lacks security-specific tests.
*   **Issue:** Absence of tests for security logic can lead to regressions or missed vulnerabilities.
*   **Recommendation:** Develop unit/integration tests for input validation (services, cubits), error handling paths (API, permissions), and permission logic.
*   **Example (Conceptual - Input Validation Test):**
    ```dart
    test('searchAddresses emits error for query less than 3 chars', () {
      // ... setup ...
      cubit.searchAddresses('ab');
      expect(cubit.state.searchState, isA<DataStateError>()); // Simplified check
      // ...
    });
    ```
    *(Refer to `testing_strategy_report.md` for more context)*

## Consider / Low Priority

### 1. Consider Android Overlay Protection (Tapjacking Mitigation)

*   **Priority:** Consider/Low
*   **File:** `android/app/src/main/AndroidManifest.xml`
*   **Issue:** No protection against tapjacking/overlay attacks.
*   **Recommendation:** Enable `filterTouchesWhenObscured` for the main activity for proactive defense, especially if input sensitivity increases in the future.
*   **Implementation:**
    ```xml
    <activity android:filterTouchesWhenObscured="true"> <!-- Add to MainActivity tag -->
        <!-- ... -->
    </activity>
    ```

### 2. Consider iOS Screen Capture Detection (Notification)

*   **Priority:** Consider/Low
*   **File:** `ios/Runner/AppDelegate.swift` (or relevant ViewControllers)
*   **Issue:** App doesn't detect or react to screen capture.
*   **Recommendation:** If displayed information is deemed sensitive enough, consider implementing detection for screen capture events (e.g., `UIApplication.userDidTakeScreenshotNotification`). Full prevention is difficult.
*   **Implementation (Conceptual):**
    ```swift
    NotificationCenter.default.addObserver(
        forName: UIApplication.userDidTakeScreenshotNotification, /* ... */ ) { /* ... */ }
    ```

### 3. Consider Certificate Pinning

*   **Priority:** Consider/Low
*   **Context:** Communication with `https://nominatim.openstreetmap.org`.
*   **Issue:** Relies on standard CA-based TLS validation.
*   **Recommendation:** Evaluate implementing certificate pinning for enhanced MITM protection. Weigh against maintenance overhead and current risk profile.
*   **Implementation (Conceptual):** Use packages like `http_certificate_pinning` or native APIs.

---

*This list should be reviewed and acted upon based on development capacity and risk assessment.*
