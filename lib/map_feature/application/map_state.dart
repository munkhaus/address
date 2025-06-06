import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/utils/data_state.dart';
import '../domain/route_model.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const MapState._();

  const factory MapState({
    @Default(DataState.idle()) DataState<LatLng> locationState,
    @Default([]) List<Marker> markers,
    @Default(false) bool isLoadingTiles,
    LatLng? selectedLocation,
    @Default(DataState.idle()) DataState<RouteModel> routeState,
    LatLng? routeStartPoint,
    LatLng? routeEndPoint,
    @Default([]) List<Polyline> routeLines,
    @Default(false) bool isStartPointCurrentLocation,
    @Default(false) bool isEndPointCurrentLocation,
  }) = _MapState;

  // Helper getters for derived states
  bool get isLocationLoading => locationState.isLoading;
  bool get hasLocationError => locationState.hasError;
  bool get isLocationSuccess => locationState.isSuccess;
  bool get hasSelectedLocation => selectedLocation != null;
  
  // Route state helpers
  bool get isRouteLoading => routeState.isLoading;
  bool get hasRouteError => routeState.hasError;
  bool get isRouteSuccess => routeState.isSuccess;
  bool get hasRoute => routeState.data != null;
  bool get hasRoutePoints => routeStartPoint != null && routeEndPoint != null;
  bool get hasRouteStartPoint => routeStartPoint != null;
  bool get hasRouteEndPoint => routeEndPoint != null;
  
  LatLng? get currentLocation => locationState.data;
  RouteModel? get currentRoute => routeState.data;
  String? get locationErrorMessage => locationState.errorMessage;
  String? get routeErrorMessage => routeState.errorMessage;

  factory MapState.initial() => const MapState();
} 