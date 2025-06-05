# Compliance and Privacy Report

## Overview

This report provides a high-level assessment of compliance and privacy aspects related to the application's functionality, focusing on location consent, Data Subject Rights (DSR), and interactions with third-party services (Nominatim).

## Location Consent

*   **Mechanism:** The application utilizes the `geolocator` plugin to access device location. This plugin, in turn, relies on the standard operating system (Android and iOS) mechanisms for requesting user permission to access location services. Users are presented with OS-level dialogs to grant or deny location access.
*   **iOS Configuration:** A critical finding (detailed in the `platform_specific_security_report.md`) is the absence of the `NSLocationWhenInUseUsageDescription` (and/or related keys) in the `ios/Runner/Info.plist` file. This description is mandatory on iOS to inform the user why the app is requesting location permission. Without it, the permission request may not function correctly or may lead to app rejection.
*   **Assessment:** The core mechanism for consent (OS-level dialogs) is standard. However, the missing `Info.plist` entry for iOS is a compliance and functional gap that needs to be addressed for proper consent transparency.

## Data Subject Rights (DSR)

*   **Data Storage by the Application:** The application itself does not store any persistent user-specific data, such as search history, saved locations, user accounts, or profiles. Data like the current map view, current location, and current search results are handled in-memory and are session-specific.
*   **Applicability of DSR:**
    *   **Data Access/Portability:** Since the app doesn't store historical personal data, requests for "access to my stored data" are largely not applicable to data held by this specific app.
    *   **Data Deletion:** Similarly, requests for "deletion of my data" are not applicable to data stored by this app, as it doesn't persist it beyond the active session.
*   **Third-Party Data:** Any data logged or retained by the Nominatim service (e.g., IP addresses, search queries) would be subject to Nominatim's own privacy policy and DSR procedures. The application developer does not control this data.
*   **Assessment:** For data directly managed and stored by this application, DSR features like data access and deletion are not currently relevant due to its stateless nature regarding user history. Users should be directed to Nominatim's privacy policy for data handled by their service.

## Third-Party Interactions (Nominatim API)

*   **Data Transmitted to Nominatim:**
    *   Search queries (text strings).
    *   Latitude and longitude coordinates (for reverse geocoding).
    *   User's IP address (inherent in any HTTP request).
    *   User-Agent string: `FlutterOSMAddressFinder/1.0 (flutter.app@example.com)`.
*   **Nominatim's Usage Policy:** Nominatim is a public service provided by OpenStreetMap. Its usage policy requires applications to provide a valid User-Agent string, including a way to contact the application developer (e.g., an email address). This is for operational reasons, such as addressing problematic usage.
*   **Current User-Agent:** The User-Agent string currently uses a placeholder email (`flutter.app@example.com`).
*   **App's Role:** The application acts as a client to the Nominatim API. It does not share user-identifiable information with Nominatim beyond what is inherent in the queries (which could be addresses) and the IP address.
*   **Assessment:**
    *   The interaction with Nominatim is for core app functionality.
    *   **Compliance Gap:** The placeholder email in the User-Agent string should be updated to a real contact email address for the app developer/maintainer to comply with Nominatim's usage policy if the app is to be distributed.
    *   It would be good practice to inform users (e.g., in a privacy policy document, if the app had one) that address searches are processed by Nominatim and are subject to their policies.

## Privacy Policy Document

*   **Finding:** The application does not currently include or reference a privacy policy document.
*   **Assessment:** While the app collects minimal data (session-based location, search queries sent to a third party), providing a privacy policy is a best practice, especially for apps distributed through app stores. Such a policy would:
    *   Explain what data is collected (even if ephemeral or sent to third parties).
    *   Describe how location data is used.
    *   Clarify the interaction with Nominatim and link to Nominatim's own privacy policy.
    *   Provide contact information for the developer.

## Summary and Recommendations

*   Ensure `Info.plist` on iOS includes appropriate location usage descriptions for transparent consent.
*   Update the User-Agent string for Nominatim API calls with a valid developer contact email.
*   Consider creating a simple privacy policy if the app is to be distributed, explaining data handling practices and third-party (Nominatim) interactions.
*   DSR features for data access/deletion are not directly applicable to data stored by this app due to its stateless nature regarding user history.

Specific actionable items will be updated in `actionable_security_recommendations.md`.
