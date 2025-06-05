abstract class NominatimApiKeys {
  static const String baseUrl = 'https://nominatim.openstreetmap.org';
  static const String userAgent = 'FlutterOSMAddressFinder/1.0 (flutter.app@example.com)';
  
  // Search endpoint
  static const String searchEndpoint = '/search';
  
  // Reverse geocoding endpoint  
  static const String reverseEndpoint = '/reverse';
  
  // Common parameters
  static const String formatJson = 'json';
  static const String addressDetails = '1';
  static const int defaultLimit = 8;
  static const int requestTimeoutSeconds = 10;
  
  /// Builds the complete search URL with query parameters
  static String searchUrl(String query, {int limit = defaultLimit}) {
    final uri = Uri.parse('$baseUrl$searchEndpoint').replace(
      queryParameters: {
        'q': query,
        'format': formatJson,
        'addressdetails': addressDetails,
        'limit': limit.toString(),
      },
    );
    return uri.toString();
  }
  
  /// Builds the complete reverse geocoding URL with coordinates
  static String reverseUrl(double latitude, double longitude) {
    final uri = Uri.parse('$baseUrl$reverseEndpoint').replace(
      queryParameters: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'format': formatJson,
        'addressdetails': addressDetails,
      },
    );
    return uri.toString();
  }
  
  /// Standard headers for all requests
  static Map<String, String> get headers => {
    'User-Agent': userAgent,
    'Accept': 'application/json',
  };
} 