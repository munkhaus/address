import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import '../../core/utils/result.dart';
import '../domain/i_route_service.dart';
import '../domain/route_model.dart';
import '../domain/map_errors.dart';

class SimpleRouteService implements IRouteService {
  static const Distance _distance = Distance();
  
  // Average speeds in km/h for different transport modes
  static const Map<String, double> _averageSpeeds = {
    'driving': 50.0,
    'walking': 5.0,
    'cycling': 15.0,
  };

  @override
  Future<Result<RouteModel, RouteError>> calculateRoute(
    LatLng startPoint,
    LatLng endPoint, {
    String routeType = 'driving',
  }) async {
    try {
      // Validate coordinates
      if (!_isValidCoordinate(startPoint) || !_isValidCoordinate(endPoint)) {
        return const Result.failure(RouteError.invalidPoints);
      }

      // Calculate straight-line distance in meters
      final distanceMeters = _distance.as(LengthUnit.Meter, startPoint, endPoint);
      final distanceKm = distanceMeters / 1000;

      // Estimate travel time based on route type
      final averageSpeed = _averageSpeeds[routeType.toLowerCase()] ?? 50.0;
      final estimatedHours = distanceKm / averageSpeed;
      final estimatedMinutes = (estimatedHours * 60).round();

      // Create simple route with start and end points
      final route = RouteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        waypoints: [startPoint, endPoint],
        distanceKm: distanceKm,
        durationMinutes: estimatedMinutes,
        routeType: routeType,
        instructions: _generateInstructions(startPoint, endPoint, distanceKm, estimatedMinutes),
      );

      return Result.success(route);
    } catch (e) {
      return const Result.failure(RouteError.unknown);
    }
  }

  @override
  Future<Result<RouteModel, RouteError>> calculateRouteWithWaypoints(
    List<LatLng> waypoints, {
    String routeType = 'driving',
  }) async {
    try {
      // Validate waypoints
      if (waypoints.length < 2) {
        return const Result.failure(RouteError.invalidPoints);
      }

      for (final waypoint in waypoints) {
        if (!_isValidCoordinate(waypoint)) {
          return const Result.failure(RouteError.invalidPoints);
        }
      }

      // Calculate total distance by summing segments
      double totalDistanceKm = 0;
      for (int i = 0; i < waypoints.length - 1; i++) {
        final segmentDistance = _distance.as(
          LengthUnit.Meter,
          waypoints[i],
          waypoints[i + 1],
        );
        totalDistanceKm += segmentDistance / 1000;
      }

      // Estimate travel time based on route type
      final averageSpeed = _averageSpeeds[routeType.toLowerCase()] ?? 50.0;
      final estimatedHours = totalDistanceKm / averageSpeed;
      final estimatedMinutes = (estimatedHours * 60).round();

      // Create route with all waypoints
      final route = RouteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        waypoints: waypoints,
        distanceKm: totalDistanceKm,
        durationMinutes: estimatedMinutes,
        routeType: routeType,
        instructions: _generateMultiWaypointInstructions(
          waypoints,
          totalDistanceKm,
          estimatedMinutes,
        ),
      );

      return Result.success(route);
    } catch (e) {
      return const Result.failure(RouteError.unknown);
    }
  }

  bool _isValidCoordinate(LatLng coordinate) {
    return coordinate.latitude >= -90 &&
        coordinate.latitude <= 90 &&
        coordinate.longitude >= -180 &&
        coordinate.longitude <= 180;
  }

  String _generateInstructions(
    LatLng start,
    LatLng end,
    double distanceKm,
    int durationMinutes,
  ) {
    final bearing = _calculateBearing(start, end);
    final direction = _getDirection(bearing);
    
    return 'Head $direction for ${distanceKm.toStringAsFixed(1)} km '
        'to reach destination (estimated ${durationMinutes} minutes)';
  }

  String _generateMultiWaypointInstructions(
    List<LatLng> waypoints,
    double totalDistanceKm,
    int totalMinutes,
  ) {
    return 'Route through ${waypoints.length} points, '
        'total distance: ${totalDistanceKm.toStringAsFixed(1)} km '
        '(estimated ${totalMinutes} minutes)';
  }

  double _calculateBearing(LatLng start, LatLng end) {
    final lat1 = start.latitudeInRad;
    final lat2 = end.latitudeInRad;
    final deltaLng = end.longitudeInRad - start.longitudeInRad;

    final y = math.sin(deltaLng) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) - 
              math.sin(lat1) * math.cos(lat2) * math.cos(deltaLng);

    final bearing = math.atan2(y, x);
    return (bearing * 180 / math.pi + 360) % 360;
  }

  String _getDirection(double bearing) {
    const directions = [
      'north', 'northeast', 'east', 'southeast',
      'south', 'southwest', 'west', 'northwest'
    ];
    
    final index = ((bearing + 22.5) / 45) % 8;
    return directions[index.floor()];
  }
} 