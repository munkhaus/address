import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OsmMapWidget extends StatefulWidget {
  final LatLng? initialCenter;
  final double initialZoom;
  final List<Marker> markers;
  final Function(LatLng)? onMapTap;
  final Function(LatLng)? onMapLongPress;
  final MapController? mapController;

  const OsmMapWidget({
    super.key,
    this.initialCenter,
    this.initialZoom = 10.0,
    this.markers = const [],
    this.onMapTap,
    this.onMapLongPress,
    this.mapController,
  });

  @override
  State<OsmMapWidget> createState() => _OsmMapWidgetState();
}

class _OsmMapWidgetState extends State<OsmMapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        initialCenter: widget.initialCenter ?? LatLng(56.2639, 9.5018), // Denmark default
        initialZoom: widget.initialZoom,
        minZoom: 3.0,
        maxZoom: 18.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | 
                 InteractiveFlag.drag | 
                 InteractiveFlag.doubleTapZoom,
        ),
        onTap: widget.onMapTap != null 
            ? (tapPosition, point) => widget.onMapTap!(point)
            : null,
        onLongPress: widget.onMapLongPress != null
            ? (tapPosition, point) => widget.onMapLongPress!(point)
            : null,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.flutter_application_9',
          maxZoom: 18,
          errorTileCallback: (tile, error, stackTrace) {
            // Log tile error - this callback is for error handling, not UI
            debugPrint('Tile loading error: $error');
          },
        ),
        if (widget.markers.isNotEmpty)
          MarkerLayer(
            markers: widget.markers,
          ),
      ],
    );
  }
} 