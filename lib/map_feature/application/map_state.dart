import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/utils/data_state.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const MapState._();

  const factory MapState({
    @Default(DataState.idle()) DataState<LatLng> locationState,
    @Default([]) List<Marker> markers,
    @Default(false) bool isLoadingTiles,
    LatLng? selectedLocation,
  }) = _MapState;

  // Helper getters for derived states
  bool get isLocationLoading => locationState.isLoading;
  bool get hasLocationError => locationState.hasError;
  bool get isLocationSuccess => locationState.isSuccess;
  bool get hasSelectedLocation => selectedLocation != null;
  
  LatLng? get currentLocation => locationState.data;
  String? get locationErrorMessage => locationState.errorMessage;

  factory MapState.initial() => const MapState();
} 