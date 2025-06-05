import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/utils/service_locator.dart';
import '../domain/i_location_service.dart';
import '../../core/utils/data_state.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final ILocationService _locationService;
  late final MapController mapController;

  MapCubit({
    ILocationService? locationService,
  })  : _locationService = locationService ?? getdep<ILocationService>(),
        super(MapState.initial()) {
    mapController = MapController();
  }

  /// Initialize the map with user location or default location
  Future<void> initialize() async {
    emit(state.copyWith(
      locationState: const DataState.loading(),
    ));

    try {
      // Try to get user location
      final locationResult = await _locationService.getCurrentLocation();
      
      locationResult.when(
        success: (location) {
          emit(state.copyWith(
            locationState: DataState.success(location),
          ));
          _moveMapToLocation(location);
        },
        failure: (error) {
          // Failed to get location, use default (Denmark)
          final defaultLocation = LatLng(56.2639, 9.5018);
          emit(state.copyWith(
            locationState: DataState.success(defaultLocation),
          ));
          _moveMapToLocation(defaultLocation);
        },
      );
    } catch (e) {
      // Fallback to default location
      final defaultLocation = LatLng(56.2639, 9.5018);
      emit(state.copyWith(
        locationState: DataState.success(defaultLocation),
      ));
      _moveMapToLocation(defaultLocation);
    }
  }

  /// Move map to specific location
  void _moveMapToLocation(LatLng location, {double zoom = 10.0}) {
    try {
      mapController.move(location, zoom);
    } catch (e) {
      // Map controller might not be ready yet, ignore
    }
  }

  /// Navigate to a specific location with a marker
  void navigateToLocation(LatLng location, {double zoom = 16.0}) {
    // Move map to location
    _moveMapToLocation(location, zoom: zoom);
    
    // Create marker for the location
    final marker = Marker(
      point: location,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: _buildCustomMarker(),
    );

    emit(state.copyWith(
      markers: [marker],
      selectedLocation: location,
    ));
  }

  /// Clear all markers from the map
  void clearMarkers() {
    emit(state.copyWith(
      markers: [],
      selectedLocation: null,
    ));
  }

  /// Handle tile loading state
  void setTileLoadingState(bool isLoading) {
    emit(state.copyWith(isLoadingTiles: isLoading));
  }

  Widget _buildCustomMarker() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE53E3E), // Red color
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000), // Black with 25% opacity
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.location_pin,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }
} 