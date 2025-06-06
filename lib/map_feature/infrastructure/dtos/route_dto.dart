import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/route_model.dart';

part 'route_dto.freezed.dart';
part 'route_dto.g.dart';

@freezed
class RouteDto with _$RouteDto {
  const RouteDto._();

  const factory RouteDto({
    @Default([]) List<RouteSegmentDto> routes,
  }) = _RouteDto;

  factory RouteDto.fromJson(Map<String, dynamic> json) => 
      _$RouteDtoFromJson(json);

  RouteModel toDomain() {
    if (routes.isEmpty) {
      return RouteModel.initial();
    }

    final route = routes.first;
    return RouteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      waypoints: route.waypoints,
      distanceKm: route.summary.distance / 1000, // Convert meters to km
      durationMinutes: (route.summary.duration / 60).round(), // Convert seconds to minutes
      routeType: 'driving',
      instructions: route.summary.toString(),
    );
  }
}

@freezed
class RouteSegmentDto with _$RouteSegmentDto {
  const RouteSegmentDto._();

  const factory RouteSegmentDto({
    @Default(RouteSummaryDto()) RouteSummaryDto summary,
    @Default(RouteGeometryDto()) RouteGeometryDto geometry,
  }) = _RouteSegmentDto;

  factory RouteSegmentDto.fromJson(Map<String, dynamic> json) => 
      _$RouteSegmentDtoFromJson(json);

  List<LatLng> get waypoints {
    if (geometry.coordinates.isEmpty) return [];
    
    return geometry.coordinates.map((coord) {
      if (coord.length >= 2) {
        return LatLng(coord[1], coord[0]); // GeoJSON uses [lon, lat]
      }
      return LatLng(0, 0);
    }).toList();
  }
}

@freezed
class RouteSummaryDto with _$RouteSummaryDto {
  const factory RouteSummaryDto({
    @Default(0.0) double distance,
    @Default(0.0) double duration,
  }) = _RouteSummaryDto;

  factory RouteSummaryDto.fromJson(Map<String, dynamic> json) => 
      _$RouteSummaryDtoFromJson(json);

  @override
  String toString() {
    final distanceKm = distance / 1000;
    final durationMin = (duration / 60).round();
    
    final distanceStr = distanceKm >= 1.0 
        ? '${distanceKm.toStringAsFixed(1)} km'
        : '${distance.round()} m';
    
    final durationStr = durationMin < 60
        ? '${durationMin} min'
        : '${durationMin ~/ 60}h ${durationMin % 60}min';
    
    return '$distanceStr, $durationStr';
  }
}

@freezed
class RouteGeometryDto with _$RouteGeometryDto {
  const factory RouteGeometryDto({
    @Default('LineString') String type,
    @Default([]) List<List<double>> coordinates,
  }) = _RouteGeometryDto;

  factory RouteGeometryDto.fromJson(Map<String, dynamic> json) => 
      _$RouteGeometryDtoFromJson(json);
} 