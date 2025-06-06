import 'package:latlong2/latlong.dart';
import '../../core/utils/result.dart';
import 'route_model.dart';
import 'map_errors.dart';

abstract class IRouteService {
  /// Calculates a route between two points.
  /// 
  /// Returns [Result.failure] with [RouteError.invalidPoints] if coordinates are invalid.
  /// Returns [Result.failure] with [RouteError.routeNotFound] if no route can be calculated.
  /// Returns [Result.failure] with [RouteError.networkError] if network issues occur.
  Future<Result<RouteModel, RouteError>> calculateRoute(
    LatLng startPoint,
    LatLng endPoint, {
    String routeType = 'driving',
  });

  /// Calculates a route through multiple waypoints.
  /// 
  /// Returns [Result.failure] with [RouteError.invalidPoints] if less than 2 points provided.
  /// Returns [Result.failure] with [RouteError.routeNotFound] if no route can be calculated.
  Future<Result<RouteModel, RouteError>> calculateRouteWithWaypoints(
    List<LatLng> waypoints, {
    String routeType = 'driving',
  });
} 