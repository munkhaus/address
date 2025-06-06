import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/utils/service_locator.dart';
import '../domain/i_location_service.dart';
import '../domain/i_route_service.dart';
import '../domain/route_model.dart';
import '../../core/utils/data_state.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final ILocationService _locationService;
  final IRouteService _routeService;
  late final MapController mapController;

  MapCubit({
    ILocationService? locationService,
    IRouteService? routeService,
  })  : _locationService = locationService ?? getdep<ILocationService>(),
        _routeService = routeService ?? getdep<IRouteService>(),
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

  /// Set route start point
  void setRouteStartPoint(LatLng point) {
    final startMarker = Marker(
      point: point,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: _buildRouteMarker(Colors.green, Icons.play_arrow),
    );

    emit(state.copyWith(
      routeStartPoint: point,
      markers: [startMarker],
      routeState: const DataState.idle(),
      routeLines: [],
      isStartPointCurrentLocation: false,
    ));
  }

  /// Set address as route start point
  void setAddressAsStartPoint(LatLng coordinates) {
    final startMarker = Marker(
      point: coordinates,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: _buildRouteMarker(Colors.green, Icons.play_arrow),
    );

    emit(state.copyWith(
      routeStartPoint: coordinates,
      markers: [startMarker],
      routeState: const DataState.idle(),
      routeLines: [],
      isStartPointCurrentLocation: false,
    ));

    // Center map on the address
    _moveMapToLocation(coordinates, zoom: 16.0);
  }

  /// Set address as route end point and calculate route
  Future<void> setAddressAsEndPoint(LatLng coordinates) async {
    if (state.routeStartPoint == null) {
      // If no start point, set this address as start instead
      setAddressAsStartPoint(coordinates);
      return;
    }

    final endMarker = Marker(
      point: coordinates,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: _buildRouteMarker(Colors.red, Icons.stop),
    );

    // Update markers with both start and end
    final startMarker = Marker(
      point: state.routeStartPoint!,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: state.isStartPointCurrentLocation 
          ? _buildCurrentLocationMarker()
          : _buildRouteMarker(Colors.green, Icons.play_arrow),
    );

    emit(state.copyWith(
      routeEndPoint: coordinates,
      markers: [startMarker, endMarker],
      routeState: const DataState.loading(),
      isEndPointCurrentLocation: false,
    ));

    await _calculateRoute();
  }

  /// Set current location as route start point
  Future<void> setCurrentLocationAsStart() async {
    emit(state.copyWith(
      routeState: const DataState.loading(),
    ));

    try {
      final locationResult = await _locationService.getCurrentLocation();
      
      locationResult.when(
        success: (location) {
          final startMarker = Marker(
            point: location,
            width: 40,
            height: 40,
            alignment: Alignment.bottomCenter,
            child: _buildCurrentLocationMarker(),
          );

          emit(state.copyWith(
            routeStartPoint: location,
            markers: [startMarker],
            routeState: const DataState.idle(),
            routeLines: [],
            isStartPointCurrentLocation: true,
          ));
          // Center map on current location
          _moveMapToLocation(location, zoom: 16.0);
        },
        failure: (error) {
          emit(state.copyWith(
            routeState: DataState.error('Could not get current location: $error'),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        routeState: DataState.error('Location error: $e'),
      ));
    }
  }

  /// Start route planning with automatic current location detection
  Future<void> startRoutePlanningWithCurrentLocation() async {
    emit(state.copyWith(
      routeState: const DataState.loading(),
    ));

    try {
      final locationResult = await _locationService.getCurrentLocation();
      
              locationResult.when(
          success: (location) {
            final startMarker = Marker(
              point: location,
              width: 40,
              height: 40,
              alignment: Alignment.bottomCenter,
              child: _buildCurrentLocationMarker(),
            );

            emit(state.copyWith(
              routeStartPoint: location,
              markers: [startMarker],
              routeState: const DataState.idle(),
              routeLines: [],
              isStartPointCurrentLocation: true,
            ));
            // Center map on current location
            _moveMapToLocation(location, zoom: 16.0);
          },
        failure: (error) {
          emit(state.copyWith(
            routeState: DataState.error('Could not detect your location. Please set manually or check location permissions.'),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        routeState: DataState.error('Location detection failed. Please try again or set location manually.'),
      ));
    }
  }

  /// Set current location as route end point
  Future<void> setCurrentLocationAsEnd() async {
    if (state.routeStartPoint == null) {
      // If no start point, set current location as start instead
      await setCurrentLocationAsStart();
      return;
    }

    emit(state.copyWith(
      routeState: const DataState.loading(),
    ));

    try {
      final locationResult = await _locationService.getCurrentLocation();
      
      locationResult.when(
        success: (location) async {
          final endMarker = Marker(
            point: location,
            width: 40,
            height: 40,
            alignment: Alignment.bottomCenter,
            child: _buildCurrentLocationMarker(),
          );

          // Update markers with both start and end
          final startMarker = Marker(
            point: state.routeStartPoint!,
            width: 40,
            height: 40,
            alignment: Alignment.bottomCenter,
            child: state.isStartPointCurrentLocation 
                ? _buildCurrentLocationMarker()
                : _buildRouteMarker(Colors.green, Icons.play_arrow),
          );

          emit(state.copyWith(
            routeEndPoint: location,
            markers: [startMarker, endMarker],
            routeState: const DataState.loading(),
            isEndPointCurrentLocation: true,
          ));

          await _calculateRoute();
        },
        failure: (error) {
          emit(state.copyWith(
            routeState: DataState.error('Could not get current location: $error'),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        routeState: DataState.error('Location error: $e'),
      ));
    }
  }

  /// Set route end point and calculate route
  Future<void> setRouteEndPoint(LatLng point) async {
    if (state.routeStartPoint == null) {
      // If no start point, set this as start point
      setRouteStartPoint(point);
      return;
    }

    final endMarker = Marker(
      point: point,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: _buildRouteMarker(Colors.red, Icons.stop),
    );

    // Update markers with both start and end
    final startMarker = Marker(
      point: state.routeStartPoint!,
      width: 40,
      height: 40,
      alignment: Alignment.bottomCenter,
      child: _buildRouteMarker(Colors.green, Icons.play_arrow),
    );

    emit(state.copyWith(
      routeEndPoint: point,
      markers: [startMarker, endMarker],
      routeState: const DataState.loading(),
    ));

    await _calculateRoute();
  }

  /// Calculate route between start and end points
  Future<void> _calculateRoute() async {
    final startPoint = state.routeStartPoint;
    final endPoint = state.routeEndPoint;

    if (startPoint == null || endPoint == null) {
      emit(state.copyWith(
        routeState: const DataState.error('Missing start or end point'),
      ));
      return;
    }

    try {
      final result = await _routeService.calculateRoute(startPoint, endPoint);
      
      result.when(
        success: (route) {
          final routeLine = _createRouteLine(route);
          emit(state.copyWith(
            routeState: DataState.success(route),
            routeLines: [routeLine],
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            routeState: DataState.error('Failed to calculate route: $error'),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        routeState: DataState.error('Route calculation error: $e'),
      ));
    }
  }

  /// Clear route and reset markers
  void clearRoute() {
    emit(state.copyWith(
      routeStartPoint: null,
      routeEndPoint: null,
      routeState: const DataState.idle(),
      routeLines: [],
      markers: [],
      isStartPointCurrentLocation: false,
      isEndPointCurrentLocation: false,
    ));
  }

  /// Create polyline for route visualization
  Polyline _createRouteLine(RouteModel route) {
    return Polyline(
      points: route.waypoints,
      strokeWidth: 4.0,
      color: Colors.blue,
      borderStrokeWidth: 6.0,
      borderColor: Colors.blue.withOpacity(0.5),
    );
  }

  Widget _buildRouteMarker(Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildCurrentLocationMarker() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(
        Icons.my_location,
        color: Colors.white,
        size: 20,
      ),
    );
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