import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'route_model.freezed.dart';

@freezed
class RouteModel with _$RouteModel {
  const RouteModel._();

  const factory RouteModel({
    @Default('') String id,
    @Default([]) List<LatLng> waypoints,
    @Default(0.0) double distanceKm,
    @Default(0) int durationMinutes,
    @Default('') String routeType,
    @Default('') String instructions,
  }) = _RouteModel;

  // Computed properties
  bool get isValid => waypoints.isNotEmpty && waypoints.length >= 2;
  LatLng? get startPoint => waypoints.isNotEmpty ? waypoints.first : null;
  LatLng? get endPoint => waypoints.length >= 2 ? waypoints.last : null;
  
  String get formattedDistance {
    if (distanceKm >= 1.0) {
      return '${distanceKm.toStringAsFixed(1)} km';
    } else {
      return '${(distanceKm * 1000).round()} m';
    }
  }
  
  String get formattedDuration {
    if (durationMinutes < 60) {
      return '${durationMinutes} min';
    } else {
      final hours = durationMinutes ~/ 60;
      final minutes = durationMinutes % 60;
      return '${hours}h ${minutes}min';
    }
  }

  factory RouteModel.initial() => const RouteModel();
} 