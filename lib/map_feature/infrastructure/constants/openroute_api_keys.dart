abstract class OpenRouteApiKeys {
  static const String baseUrl = 'https://api.openrouteservice.org';
  static const String userAgent = 'FlutterOSMAddressFinder/1.0 (flutter.app@example.com)';
  
  // Directions endpoint
  static const String directionsEndpoint = '/v2/directions';
  
  // Route profiles
  static const String drivingProfile = 'driving-car';
  static const String walkingProfile = 'foot-walking';
  static const String cyclingProfile = 'cycling-regular';
  
  // Request settings
  static const int requestTimeoutSeconds = 15;
  static const String geometryFormat = 'geojson';
  
  /// Builds the complete directions URL for a specific profile
  static String directionsUrl(String profile) {
    return '$baseUrl$directionsEndpoint/$profile';
  }
  
  /// Standard headers for all requests
  static Map<String, String> get headers => {
    'User-Agent': userAgent,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  /// Get profile name from route type
  static String getProfile(String routeType) {
    switch (routeType.toLowerCase()) {
      case 'walking':
        return walkingProfile;
      case 'cycling':
        return cyclingProfile;
      case 'driving':
      default:
        return drivingProfile;
    }
  }
} 