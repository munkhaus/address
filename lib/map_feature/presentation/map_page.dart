import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/map_cubit.dart';
import '../application/map_state.dart';
import '../application/address_search_cubit.dart';
import '../domain/address_suggestion_model.dart';
import '../domain/route_model.dart';
import 'widgets/osm_map_widget.dart';
import 'widgets/address_search_widget.dart';
import 'widgets/route_planning_panel.dart';
import '../../core/constants/k_sizes.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapCubit()..initialize(),
        ),
        BlocProvider(
          create: (context) => AddressSearchCubit(),
        ),
      ],
      child: const MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adressefinder'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Main map widget
              OsmMapWidget(
                initialCenter: state.currentLocation,
                markers: state.markers,
                polylines: state.routeLines,
                mapController: context.read<MapCubit>().mapController,
                onMapTap: (latLng) {
                  // Hide suggestions when map is tapped
                  context.read<AddressSearchCubit>().hideSuggestions();
                },
                onMapLongPress: (latLng) {
                  // Long press to set route points
                  context.read<MapCubit>().setRouteEndPoint(latLng);
                },
              ),
              
              // Address search widget
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AddressSearchWidget(
                  onAddressSelected: (suggestion) {
                    _onAddressSelected(context, suggestion);
                  },
                ),
              ),
              
              // Loading overlay for location
              if (state.isLocationLoading)
                const _LocationLoadingOverlay(),
              
              // Error overlay for location
              if (state.hasLocationError)
                _LocationErrorOverlay(
                  errorMessage: state.locationErrorMessage ?? 'Location error',
                  onRetry: () => context.read<MapCubit>().initialize(),
                ),
              
              // Route planning panel
              const RoutePlanningPanel(),
              
              // Route loading overlay
              if (state.isRouteLoading)
                const _RouteLoadingOverlay(),
              
              // Route error overlay
              if (state.hasRouteError)
                _RouteErrorOverlay(
                  errorMessage: state.routeErrorMessage ?? 'Route error',
                  onRetry: () {
                    if (state.hasRoutePoints) {
                      context.read<MapCubit>().setRouteEndPoint(state.routeEndPoint!);
                    }
                  },
                ),
              
              // Map controls
              const _MapControls(),
            ],
          );
        },
      ),
    );
  }

  void _onAddressSelected(BuildContext context, AddressSuggestion suggestion) {
    // Navigate to selected address on map
    context.read<MapCubit>().navigateToLocation(
      suggestion.coordinates,
      zoom: 16.0,
    );
  }
}

class _LocationLoadingOverlay extends StatelessWidget {
  const _LocationLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(KSizes.margin4x),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: KSizes.margin2x),
                const Text('Getting your location...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationErrorOverlay extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _LocationErrorOverlay({
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(KSizes.margin4x),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_off,
                  size: KSizes.iconL,
                  color: Colors.orange,
                ),
                SizedBox(height: KSizes.margin2x),
                Text(
                  'Location Error',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: KSizes.margin1x),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: KSizes.margin4x),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Dismiss error overlay by retrying with default location
                        onRetry();
                      },
                      child: const Text('Use Default Location'),
                    ),
                    SizedBox(width: KSizes.margin2x),
                    ElevatedButton(
                      onPressed: onRetry,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MapControls extends StatelessWidget {
  const _MapControls();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: KSizes.margin4x,
      bottom: KSizes.margin4x,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Zoom in button
          FloatingActionButton.small(
            heroTag: 'zoom_in',
            onPressed: () {
              final cubit = context.read<MapCubit>();
              final currentZoom = cubit.mapController.camera.zoom;
              cubit.mapController.move(
                cubit.mapController.camera.center,
                currentZoom + 1,
              );
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(height: KSizes.margin1x),
          
          // Zoom out button
          FloatingActionButton.small(
            heroTag: 'zoom_out',
            onPressed: () {
              final cubit = context.read<MapCubit>();
              final currentZoom = cubit.mapController.camera.zoom;
              cubit.mapController.move(
                cubit.mapController.camera.center,
                currentZoom - 1,
              );
            },
            child: const Icon(Icons.remove),
          ),
          SizedBox(height: KSizes.margin2x),
          
          // Route planning button
          BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              return FloatingActionButton.small(
                heroTag: 'route_planning',
                backgroundColor: state.hasRouteStartPoint ? Colors.blue[400] : null,
                onPressed: () {
                  if (state.hasRoute || state.hasRouteStartPoint) {
                    context.read<MapCubit>().clearRoute();
                  } else {
                    // Start route planning with current location
                    _showRouteOptions(context);
                  }
                },
                child: state.hasRoute || state.hasRouteStartPoint
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.directions),
              );
            },
          ),
          SizedBox(height: KSizes.margin2x),
          
          // Current location button
          BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              return FloatingActionButton.small(
                heroTag: 'current_location',
                onPressed: state.isLocationLoading 
                    ? null 
                    : () => context.read<MapCubit>().initialize(),
                child: state.isLocationLoading
                    ? SizedBox(
                        width: KSizes.iconS,
                        height: KSizes.iconS,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showRouteOptions(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      builder: (BuildContext modalContext) {
        return Padding(
          padding: EdgeInsets.all(KSizes.margin4x),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Start Route Planning',
                style: Theme.of(modalContext).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: KSizes.margin4x),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(modalContext);
                  parentContext.read<MapCubit>().startRoutePlanningWithCurrentLocation();
                },
                icon: const Icon(Icons.my_location),
                label: const Text('Start from My Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: KSizes.margin3x),
                ),
              ),
              SizedBox(height: KSizes.margin2x),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(modalContext);
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    const SnackBar(
                      content: Text('Long press on map to set start point'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                icon: const Icon(Icons.touch_app),
                label: const Text('Tap on Map'),
              ),
              SizedBox(height: KSizes.margin2x),
            ],
          ),
        );
      },
    );
  }
}

class _RouteLoadingOverlay extends StatelessWidget {
  const _RouteLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: KSizes.margin12x,
      left: KSizes.margin4x,
      right: KSizes.margin4x,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(KSizes.margin4x),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              SizedBox(width: KSizes.margin4x),
              const Text('Calculating route...'),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteErrorOverlay extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _RouteErrorOverlay({
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: KSizes.margin12x,
      left: KSizes.margin4x,
      right: KSizes.margin4x,
      child: Card(
        color: Colors.red[50],
        child: Padding(
          padding: EdgeInsets.all(KSizes.margin4x),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: KSizes.margin2x),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: KSizes.margin2x),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<MapCubit>().clearRoute();
                    },
                    child: const Text('Cancel'),
                  ),
                  SizedBox(width: KSizes.margin2x),
                  ElevatedButton(
                    onPressed: onRetry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 