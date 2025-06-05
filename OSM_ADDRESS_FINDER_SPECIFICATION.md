# OpenStreetMap Address Finder - Technical Implementation Specification

## Project Overview
**Goal**: Implement an intuitive address finder feature using OpenStreetMap data, interactive map, and text search capabilities in Flutter.

**Target User**: App users who need to specify geographic locations through map interaction or address search.

## Technology Stack

### Core Dependencies
```yaml
dependencies:
  flutter_map: ^6.1.0
  latlong2: ^0.8.1
  http: ^1.1.0
  geolocator: ^10.1.0
  permission_handler: ^11.0.1
  result_type: ^0.0.1
  freezed_annotation: ^2.4.1
  
dev_dependencies:
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  build_runner: ^2.4.7
```

### Key Technical Components
- **Map Display**: flutter_map with OpenStreetMap tiles
- **Geocoding**: Nominatim API (OpenStreetMap's official service)
- **State Management**: Cubit/BLoC pattern
- **Debouncing**: Timer-based search optimization
- **Location Services**: geolocator for user position

## Implementation Phases

## Phase 1: Basic Map Display

### Objectives
- Display interactive OSM map
- Handle loading states and tile errors
- Implement basic map interactions (pan, zoom)
- Set appropriate initial position

### Technical Requirements

#### 1. Map Widget Structure
```dart
// File: lib/map_feature/presentation/widgets/osm_map_widget.dart
class OsmMapWidget extends StatefulWidget {
  final LatLng? initialCenter;
  final double initialZoom;
  final List<Marker> markers;
  final Function(LatLng)? onMapTap;
  final Function(LatLng)? onMapLongPress;
}
```

#### 2. Map Controller Setup
```dart
// Initialize MapController for programmatic control
late MapController mapController;

// Map options configuration
MapOptions(
  initialCenter: initialCenter ?? LatLng(56.2639, 9.5018), // Denmark default
  initialZoom: 10.0,
  minZoom: 3.0,
  maxZoom: 18.0,
  interactionOptions: InteractionOptions(
    flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
  ),
)
```

#### 3. Tile Layer Configuration
```dart
TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.yourapp.name', // CRITICAL: Must be set
  maxZoom: 18,
  errorTileCallback: (tile, error, stackTrace) {
    // Handle tile loading errors
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.error_outline),
    );
  },
)
```

#### 4. Loading State Management
```dart
// File: lib/map_feature/application/map_state.dart
@freezed
class MapState with _$MapState {
  const factory MapState({
    @Default(DataState.idle()) DataState<LatLng> locationState,
    @Default([]) List<Marker> markers,
    @Default(false) bool isLoadingTiles,
  }) = _MapState;
}
```

#### 5. Location Permission Handling
```dart
// File: lib/map_feature/infrastructure/location_service.dart
class LocationService {
  Future<Result<LatLng, LocationError>> getCurrentLocation() async {
    // Check and request permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    
    // Handle permission denied cases
    // Get current position with timeout
    // Return Result.success or Result.failure
  }
}
```

### Definition of Done - Phase 1
- [ ] OSM map renders correctly on dedicated screen
- [ ] Map responds smoothly to zoom and pan gestures
- [ ] Loading placeholder shows during initialization
- [ ] Error handling for failed tile loads (graceful degradation)
- [ ] User location permission handling (with fallback to Denmark)
- [ ] No crashes when internet connection is unavailable

---

## Phase 2: Address Search with Text Input

### Objectives
- Implement debounced text search
- Integrate Nominatim API for address suggestions
- Display searchable suggestion list
- Handle API errors and empty states

### Technical Requirements

#### 1. Search Input Widget
```dart
// File: lib/map_feature/presentation/widgets/address_search_widget.dart
class AddressSearchWidget extends StatefulWidget {
  final Function(AddressSuggestion) onAddressSelected;
  final TextEditingController? controller;
}

// Search field with clear button and loading indicator
TextField(
  controller: searchController,
  decoration: InputDecoration(
    hintText: 'Søg adresse...',
    prefixIcon: Icon(Icons.search),
    suffixIcon: _buildSuffixIcon(), // Clear button or loading indicator
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onChanged: _onSearchChanged,
)
```

#### 2. Debounce Implementation
```dart
Timer? _debounce;

void _onSearchChanged(String query) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    if (query.length >= 3) {
      context.read<AddressSearchCubit>().searchAddresses(query);
    } else {
      context.read<AddressSearchCubit>().clearSuggestions();
    }
  });
}
```

#### 3. Nominatim API Integration
```dart
// File: lib/map_feature/infrastructure/nominatim_service.dart
class NominatimService implements IAddressService {
  static const String baseUrl = 'https://nominatim.openstreetmap.org';
  static const String userAgent = 'YourAppName/1.0 (your.email@example.com)';
  
  @override
  Future<Result<List<AddressSuggestion>, ApiError>> searchAddresses(
    String query,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search?q=$query&format=json&addressdetails=1&limit=8'),
        headers: {'User-Agent': userAgent}, // CRITICAL for Nominatim
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final suggestions = data.map((json) => 
          AddressSuggestion.fromNominatimJson(json)
        ).toList();
        return Result.success(suggestions);
      }
      return Result.failure(ApiError.serverError);
    } catch (e) {
      return Result.failure(ApiError.networkError);
    }
  }
}
```

#### 4. Address Suggestion Model
```dart
// File: lib/map_feature/domain/address_suggestion_model.dart
@freezed
class AddressSuggestion with _$AddressSuggestion {
  const factory AddressSuggestion({
    @Default('') String displayName,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default('') String addressType,
    @Default('') String category,
  }) = _AddressSuggestion;
  
  factory AddressSuggestion.fromNominatimJson(Map<String, dynamic> json) {
    return AddressSuggestion(
      displayName: json['display_name'] ?? '',
      latitude: double.tryParse(json['lat']?.toString() ?? '0') ?? 0.0,
      longitude: double.tryParse(json['lon']?.toString() ?? '0') ?? 0.0,
      addressType: json['type'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
```

#### 5. Search State Management
```dart
// File: lib/map_feature/application/address_search_cubit.dart
class AddressSearchCubit extends Cubit<AddressSearchState> {
  final IAddressService addressService;
  
  AddressSearchCubit({IAddressService? service})
      : addressService = service ?? GetIt.instance<IAddressService>(),
        super(AddressSearchState.initial());
  
  Future<void> searchAddresses(String query) async {
    emit(state.copyWith(searchState: const DataState.loading()));
    
    final result = await addressService.searchAddresses(query);
    result.when(
      success: (suggestions) => emit(state.copyWith(
        searchState: DataState.success(suggestions),
      )),
      failure: (error) => emit(state.copyWith(
        searchState: const DataState.error(),
      )),
    );
  }
}
```

#### 6. Suggestions List Widget
```dart
// File: lib/map_feature/presentation/widgets/suggestions_list_widget.dart
class SuggestionsListWidget extends StatelessWidget {
  final List<AddressSuggestion> suggestions;
  final Function(AddressSuggestion) onSuggestionTap;
  
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: Card(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text(_getDisplayTitle(suggestion)),
              subtitle: Text(_getDisplaySubtitle(suggestion)),
              onTap: () => onSuggestionTap(suggestion),
            );
          },
        ),
      ),
    );
  }
}
```

### Definition of Done - Phase 2
- [ ] Text input with debounced search (500ms delay)
- [ ] API integration with Nominatim (proper User-Agent header)
- [ ] Suggestion list displays correctly formatted addresses
- [ ] Loading indicator during API calls
- [ ] Error handling for network issues and empty results
- [ ] Clear button functionality in search field
- [ ] Rate limiting compliance (max 1 request/second to Nominatim)

---

## Phase 3: Display Selected Address on Map

### Objectives
- Center map on selected address coordinates
- Place marker at selected location
- Implement smooth map transitions
- Show address info popup

### Technical Requirements

#### 1. Map Navigation
```dart
// File: lib/map_feature/application/map_cubit.dart
class MapCubit extends Cubit<MapState> {
  final MapController mapController;
  
  void navigateToAddress(AddressSuggestion suggestion) {
    final latLng = LatLng(suggestion.latitude, suggestion.longitude);
    
    // Animate to new position
    mapController.move(latLng, 16.0); // Zoom level for address
    
    // Add marker
    emit(state.copyWith(
      markers: [
        Marker(
          point: latLng,
          width: 40,
          height: 40,
          child: _buildCustomMarker(),
          alignment: Alignment.bottomCenter,
        ),
      ],
      selectedAddress: suggestion,
    ));
  }
}
```

#### 2. Custom Marker Widget
```dart
Widget _buildCustomMarker() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Icon(
      Icons.location_pin,
      color: Colors.white,
      size: 24,
    ),
  );
}
```

#### 3. Address Info Popup
```dart
// File: lib/map_feature/presentation/widgets/address_info_popup.dart
class AddressInfoPopup extends StatelessWidget {
  final AddressSuggestion address;
  final VoidCallback? onClose;
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 16,
      right: 16,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: onClose,
                  ),
                ],
              ),
              Text(
                address.displayName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text(
                'Koordinater: ${address.latitude.toStringAsFixed(6)}, ${address.longitude.toStringAsFixed(6)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

#### 4. Smooth Animations
```dart
// File: lib/map_feature/presentation/widgets/animated_suggestions_list.dart
class AnimatedSuggestionsList extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: isVisible ? child : SizedBox.shrink(),
    );
  }
}
```

### Definition of Done - Phase 3
- [ ] Map smoothly animates to selected address location
- [ ] Marker appears correctly positioned at address coordinates
- [ ] Suggestion list closes automatically after selection
- [ ] Address info popup displays with complete address details
- [ ] Marker alignment is precise (bottom-center anchoring)
- [ ] Smooth transitions between different address selections

---

## Phase 4: Interactive Map Search (Future Enhancement)

### Objectives
- Enable location selection via map tap/long press
- Implement reverse geocoding
- Display found address in search field

### Technical Requirements

#### 1. Map Interaction Handling
```dart
FlutterMap(
  options: MapOptions(
    onLongPress: (tapPosition, latLng) {
      context.read<MapCubit>().handleMapLongPress(latLng);
    },
  ),
)
```

#### 2. Reverse Geocoding Service
```dart
// File: lib/map_feature/infrastructure/reverse_geocoding_service.dart
Future<Result<AddressSuggestion, ApiError>> reverseGeocode(
  double latitude,
  double longitude,
) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/reverse?lat=$latitude&lon=$longitude&format=json&addressdetails=1'),
      headers: {'User-Agent': userAgent},
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Result.success(AddressSuggestion.fromNominatimJson(data));
    }
    return Result.failure(ApiError.serverError);
  } catch (e) {
    return Result.failure(ApiError.networkError);
  }
}
```

### Definition of Done - Phase 4
- [ ] Long press on map places temporary marker
- [ ] Reverse geocoding finds nearest address
- [ ] Search field updates with found address
- [ ] Loading indicator during reverse geocoding
- [ ] Graceful handling of locations without specific addresses

---

## Architecture Guidelines

### Project Structure
```
lib/
├── core/
│   ├── constants/
│   │   └── k_sizes.dart
│   └── network/
│       └── api_client.dart
└── map_feature/
    ├── application/
    │   ├── map_cubit.dart
    │   ├── map_state.dart
    │   ├── address_search_cubit.dart
    │   └── address_search_state.dart
    ├── domain/
    │   ├── i_address_service.dart
    │   ├── i_location_service.dart
    │   ├── address_suggestion_model.dart
    │   └── map_errors.dart
    ├── infrastructure/
    │   ├── nominatim_service.dart
    │   └── location_service.dart
    └── presentation/
        ├── map_page.dart
        └── widgets/
            ├── osm_map_widget.dart
            ├── address_search_widget.dart
            ├── suggestions_list_widget.dart
            └── address_info_popup.dart
```

### State Management Pattern
```dart
// Use Cubit pattern with Result types for error handling
@freezed
class MapState with _$MapState {
  const factory MapState({
    @Default(DataState.idle()) DataState<LatLng> locationState,
    @Default([]) List<Marker> markers,
    AddressSuggestion? selectedAddress,
    @Default(false) bool showAddressInfo,
  }) = _MapState;

  factory MapState.initial() => const MapState();
}
```

### Error Handling Strategy
```dart
// File: lib/map_feature/domain/map_errors.dart
enum ApiError {
  networkError,
  serverError,
  locationPermissionDenied,
  locationServiceDisabled,
  searchQueryTooShort,
  noResultsFound,
}

// Use Result type for all async operations
Future<Result<T, ApiError>> performOperation();
```

## Testing Strategy

### Unit Tests
- [ ] Address search debouncing logic
- [ ] Nominatim API response parsing
- [ ] Map state transitions
- [ ] Error handling scenarios

### Widget Tests
- [ ] Search input and suggestions display
- [ ] Map widget rendering
- [ ] Marker placement accuracy
- [ ] Address info popup display

### Integration Tests
- [ ] Complete search-to-map-display flow
- [ ] Location permission handling
- [ ] Network error scenarios

## Performance Considerations

### API Rate Limiting
- Implement request throttling (max 1 request/second for Nominatim)
- Cache recent search results locally
- Use appropriate debounce timing (500ms)

### Map Performance
- Limit number of concurrent markers
- Optimize tile loading with appropriate zoom constraints
- Use efficient marker anchoring and sizing

### Memory Management
- Dispose of controllers and timers properly
- Limit stored search history
- Clear unused map tiles periodically

## Accessibility Requirements

### Screen Reader Support
- Provide semantic labels for map controls
- Announce address selection changes
- Ensure proper focus management

### Touch Accessibility
- Minimum 44x44dp touch targets for all interactive elements
- High contrast mode support
- Sufficient color contrast ratios

## Security Considerations

### API Usage
- Never store API keys in client code (Nominatim doesn't require keys)
- Implement proper User-Agent identification
- Respect rate limiting and usage policies

### User Privacy
- Request location permissions with clear explanations
- Allow app functionality without location access
- Clear data handling policies

## Deployment Checklist

### Pre-Launch
- [ ] Test on various device sizes and OS versions
- [ ] Verify Nominatim usage policy compliance
- [ ] Optimize build size and performance
- [ ] Complete accessibility testing
- [ ] Validate offline behavior

### Production Monitoring
- [ ] Track API response times and error rates
- [ ] Monitor user location permission acceptance rates
- [ ] Analyze search query patterns for optimization
- [ ] Track map interaction metrics

This specification provides a comprehensive foundation for implementing the OpenStreetMap address finder feature using Cursor AI and following Flutter best practices. 