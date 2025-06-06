import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/map_cubit.dart';
import '../../application/map_state.dart';
import 'route_address_search_dialog.dart';
import '../../../core/constants/k_sizes.dart';

class RoutePlanningPanel extends StatelessWidget {
  const RoutePlanningPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (!_shouldShowPanel(state)) {
          return const SizedBox.shrink();
        }

        return Positioned(
          top: KSizes.margin8x,
          left: KSizes.margin4x,
          right: KSizes.margin4x,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(KSizes.margin4x),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, state),
                  SizedBox(height: KSizes.margin4x),
                  _buildLocationControls(context, state),
                  if (state.hasRoute) ...[
                    SizedBox(height: KSizes.margin4x),
                    _buildRouteInfo(context, state),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _shouldShowPanel(MapState state) {
    return state.hasRouteStartPoint || state.hasRoute || state.isRouteLoading;
  }

  Widget _buildHeader(BuildContext context, MapState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Route Planning',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<MapCubit>().clearRoute();
          },
        ),
      ],
    );
  }

  Widget _buildLocationControls(BuildContext context, MapState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Start location controls
        _buildLocationRow(
          context,
          label: 'From:',
          hasLocation: state.hasRouteStartPoint,
          locationText: state.hasRouteStartPoint 
              ? state.isStartPointCurrentLocation 
                  ? '📍 Current Location'
                  : _formatLocation(state.routeStartPoint!)
              : 'Search or tap to set start point',
          onCurrentLocation: () {
            context.read<MapCubit>().setCurrentLocationAsStart();
          },
          onClear: state.hasRouteStartPoint 
              ? () => context.read<MapCubit>().clearRoute()
              : null,
          onSearchAddress: () => _showAddressSearch(context, isStartPoint: true),
          icon: Icons.play_arrow,
          color: Colors.green,
        ),
        
        SizedBox(height: KSizes.margin2x),
        
        // End location controls
        _buildLocationRow(
          context,
          label: 'To:',
          hasLocation: state.hasRouteEndPoint,
          locationText: state.hasRouteEndPoint 
              ? state.isEndPointCurrentLocation 
                  ? '📍 Current Location'
                  : _formatLocation(state.routeEndPoint!)
              : state.hasRouteStartPoint 
                  ? 'Search or tap to set destination'
                  : 'Set start point first',
          onCurrentLocation: state.hasRouteStartPoint 
              ? () => context.read<MapCubit>().setCurrentLocationAsEnd()
              : null,
          onClear: state.hasRouteEndPoint 
              ? () {
                  // Clear only end point, keep start
                  final cubit = context.read<MapCubit>();
                  final startPoint = state.routeStartPoint;
                  final isStartCurrent = state.isStartPointCurrentLocation;
                  cubit.clearRoute();
                  if (startPoint != null) {
                    if (isStartCurrent) {
                      cubit.setCurrentLocationAsStart();
                    } else {
                      cubit.setRouteStartPoint(startPoint);
                    }
                  }
                }
              : null,
          onSearchAddress: state.hasRouteStartPoint 
              ? () => _showAddressSearch(context, isStartPoint: false)
              : null,
          icon: Icons.stop,
          color: Colors.red,
        ),
        
        if (!state.hasRouteStartPoint) ...[
          SizedBox(height: KSizes.margin4x),
          Container(
            padding: EdgeInsets.all(KSizes.margin3x),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(KSizes.radiusDefault),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600], size: KSizes.iconS),
                SizedBox(width: KSizes.margin2x),
                Expanded(
                  child: Text(
                    'Use current location, search for an address, or long press on map',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLocationRow(
    BuildContext context, {
    required String label,
    required bool hasLocation,
    required String locationText,
    required VoidCallback? onCurrentLocation,
    required VoidCallback? onClear,
    required VoidCallback? onSearchAddress,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: KSizes.iconM,
          height: KSizes.iconM,
          decoration: BoxDecoration(
            color: hasLocation ? color : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: KSizes.iconS,
          ),
        ),
        SizedBox(width: KSizes.margin2x),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                locationText,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Search address button
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchAddress,
          tooltip: 'Search address',
          iconSize: KSizes.iconS,
        ),
        // Current location button
        IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: onCurrentLocation,
          tooltip: 'Use current location',
          iconSize: KSizes.iconS,
        ),
        // Clear button
        if (onClear != null)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: onClear,
            tooltip: 'Clear',
            iconSize: KSizes.iconS,
          ),
      ],
    );
  }

  Widget _buildRouteInfo(BuildContext context, MapState state) {
    final route = state.currentRoute!;
    
    return Container(
      padding: EdgeInsets.all(KSizes.margin3x),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(KSizes.radiusDefault),
      ),
      child: Row(
        children: [
          Icon(Icons.directions, color: Colors.blue[700]),
          SizedBox(width: KSizes.margin2x),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${route.formattedDistance} • ${route.formattedDuration}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (route.instructions.isNotEmpty)
                  Text(
                    route.instructions,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatLocation(dynamic location) {
    if (location == null) return 'Unknown location';
    return '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
  }

  void _showAddressSearch(BuildContext context, {required bool isStartPoint}) {
    showDialog(
      context: context,
      builder: (context) => RouteAddressSearchDialog(
        isStartPoint: isStartPoint,
      ),
    );
  }
} 