import 'package:latlong2/latlong.dart';
import '../../core/utils/result.dart';
import 'map_errors.dart';

abstract class ILocationService {
  /// Gets the current user location.
  /// 
  /// Returns [Result.failure] with [LocationError.permissionDenied] if permission is denied.
  /// Returns [Result.failure] with [LocationError.serviceDisabled] if location service is disabled.
  /// Returns [Result.failure] with [LocationError.timeout] if location request times out.
  Future<Result<LatLng, LocationError>> getCurrentLocation();

  /// Checks if location permission is granted.
  Future<bool> hasLocationPermission();

  /// Requests location permission from the user.
  Future<bool> requestLocationPermission();
} 