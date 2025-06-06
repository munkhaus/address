// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MapState {
  DataState<LatLng> get locationState => throw _privateConstructorUsedError;
  List<Marker> get markers => throw _privateConstructorUsedError;
  bool get isLoadingTiles => throw _privateConstructorUsedError;
  LatLng? get selectedLocation => throw _privateConstructorUsedError;
  DataState<RouteModel> get routeState => throw _privateConstructorUsedError;
  LatLng? get routeStartPoint => throw _privateConstructorUsedError;
  LatLng? get routeEndPoint => throw _privateConstructorUsedError;
  List<Polyline> get routeLines => throw _privateConstructorUsedError;
  bool get isStartPointCurrentLocation => throw _privateConstructorUsedError;
  bool get isEndPointCurrentLocation => throw _privateConstructorUsedError;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapStateCopyWith<MapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) then) =
      _$MapStateCopyWithImpl<$Res, MapState>;
  @useResult
  $Res call({
    DataState<LatLng> locationState,
    List<Marker> markers,
    bool isLoadingTiles,
    LatLng? selectedLocation,
    DataState<RouteModel> routeState,
    LatLng? routeStartPoint,
    LatLng? routeEndPoint,
    List<Polyline> routeLines,
    bool isStartPointCurrentLocation,
    bool isEndPointCurrentLocation,
  });

  $DataStateCopyWith<LatLng, $Res> get locationState;
  $DataStateCopyWith<RouteModel, $Res> get routeState;
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res, $Val extends MapState>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationState = null,
    Object? markers = null,
    Object? isLoadingTiles = null,
    Object? selectedLocation = freezed,
    Object? routeState = null,
    Object? routeStartPoint = freezed,
    Object? routeEndPoint = freezed,
    Object? routeLines = null,
    Object? isStartPointCurrentLocation = null,
    Object? isEndPointCurrentLocation = null,
  }) {
    return _then(
      _value.copyWith(
            locationState: null == locationState
                ? _value.locationState
                : locationState // ignore: cast_nullable_to_non_nullable
                      as DataState<LatLng>,
            markers: null == markers
                ? _value.markers
                : markers // ignore: cast_nullable_to_non_nullable
                      as List<Marker>,
            isLoadingTiles: null == isLoadingTiles
                ? _value.isLoadingTiles
                : isLoadingTiles // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedLocation: freezed == selectedLocation
                ? _value.selectedLocation
                : selectedLocation // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            routeState: null == routeState
                ? _value.routeState
                : routeState // ignore: cast_nullable_to_non_nullable
                      as DataState<RouteModel>,
            routeStartPoint: freezed == routeStartPoint
                ? _value.routeStartPoint
                : routeStartPoint // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            routeEndPoint: freezed == routeEndPoint
                ? _value.routeEndPoint
                : routeEndPoint // ignore: cast_nullable_to_non_nullable
                      as LatLng?,
            routeLines: null == routeLines
                ? _value.routeLines
                : routeLines // ignore: cast_nullable_to_non_nullable
                      as List<Polyline>,
            isStartPointCurrentLocation: null == isStartPointCurrentLocation
                ? _value.isStartPointCurrentLocation
                : isStartPointCurrentLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
            isEndPointCurrentLocation: null == isEndPointCurrentLocation
                ? _value.isEndPointCurrentLocation
                : isEndPointCurrentLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataStateCopyWith<LatLng, $Res> get locationState {
    return $DataStateCopyWith<LatLng, $Res>(_value.locationState, (value) {
      return _then(_value.copyWith(locationState: value) as $Val);
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataStateCopyWith<RouteModel, $Res> get routeState {
    return $DataStateCopyWith<RouteModel, $Res>(_value.routeState, (value) {
      return _then(_value.copyWith(routeState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MapStateImplCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$$MapStateImplCopyWith(
    _$MapStateImpl value,
    $Res Function(_$MapStateImpl) then,
  ) = __$$MapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DataState<LatLng> locationState,
    List<Marker> markers,
    bool isLoadingTiles,
    LatLng? selectedLocation,
    DataState<RouteModel> routeState,
    LatLng? routeStartPoint,
    LatLng? routeEndPoint,
    List<Polyline> routeLines,
    bool isStartPointCurrentLocation,
    bool isEndPointCurrentLocation,
  });

  @override
  $DataStateCopyWith<LatLng, $Res> get locationState;
  @override
  $DataStateCopyWith<RouteModel, $Res> get routeState;
}

/// @nodoc
class __$$MapStateImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$MapStateImpl>
    implements _$$MapStateImplCopyWith<$Res> {
  __$$MapStateImplCopyWithImpl(
    _$MapStateImpl _value,
    $Res Function(_$MapStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationState = null,
    Object? markers = null,
    Object? isLoadingTiles = null,
    Object? selectedLocation = freezed,
    Object? routeState = null,
    Object? routeStartPoint = freezed,
    Object? routeEndPoint = freezed,
    Object? routeLines = null,
    Object? isStartPointCurrentLocation = null,
    Object? isEndPointCurrentLocation = null,
  }) {
    return _then(
      _$MapStateImpl(
        locationState: null == locationState
            ? _value.locationState
            : locationState // ignore: cast_nullable_to_non_nullable
                  as DataState<LatLng>,
        markers: null == markers
            ? _value._markers
            : markers // ignore: cast_nullable_to_non_nullable
                  as List<Marker>,
        isLoadingTiles: null == isLoadingTiles
            ? _value.isLoadingTiles
            : isLoadingTiles // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedLocation: freezed == selectedLocation
            ? _value.selectedLocation
            : selectedLocation // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        routeState: null == routeState
            ? _value.routeState
            : routeState // ignore: cast_nullable_to_non_nullable
                  as DataState<RouteModel>,
        routeStartPoint: freezed == routeStartPoint
            ? _value.routeStartPoint
            : routeStartPoint // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        routeEndPoint: freezed == routeEndPoint
            ? _value.routeEndPoint
            : routeEndPoint // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        routeLines: null == routeLines
            ? _value._routeLines
            : routeLines // ignore: cast_nullable_to_non_nullable
                  as List<Polyline>,
        isStartPointCurrentLocation: null == isStartPointCurrentLocation
            ? _value.isStartPointCurrentLocation
            : isStartPointCurrentLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        isEndPointCurrentLocation: null == isEndPointCurrentLocation
            ? _value.isEndPointCurrentLocation
            : isEndPointCurrentLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MapStateImpl extends _MapState {
  const _$MapStateImpl({
    this.locationState = const DataState.idle(),
    final List<Marker> markers = const [],
    this.isLoadingTiles = false,
    this.selectedLocation,
    this.routeState = const DataState.idle(),
    this.routeStartPoint,
    this.routeEndPoint,
    final List<Polyline> routeLines = const [],
    this.isStartPointCurrentLocation = false,
    this.isEndPointCurrentLocation = false,
  }) : _markers = markers,
       _routeLines = routeLines,
       super._();

  @override
  @JsonKey()
  final DataState<LatLng> locationState;
  final List<Marker> _markers;
  @override
  @JsonKey()
  List<Marker> get markers {
    if (_markers is EqualUnmodifiableListView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_markers);
  }

  @override
  @JsonKey()
  final bool isLoadingTiles;
  @override
  final LatLng? selectedLocation;
  @override
  @JsonKey()
  final DataState<RouteModel> routeState;
  @override
  final LatLng? routeStartPoint;
  @override
  final LatLng? routeEndPoint;
  final List<Polyline> _routeLines;
  @override
  @JsonKey()
  List<Polyline> get routeLines {
    if (_routeLines is EqualUnmodifiableListView) return _routeLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routeLines);
  }

  @override
  @JsonKey()
  final bool isStartPointCurrentLocation;
  @override
  @JsonKey()
  final bool isEndPointCurrentLocation;

  @override
  String toString() {
    return 'MapState(locationState: $locationState, markers: $markers, isLoadingTiles: $isLoadingTiles, selectedLocation: $selectedLocation, routeState: $routeState, routeStartPoint: $routeStartPoint, routeEndPoint: $routeEndPoint, routeLines: $routeLines, isStartPointCurrentLocation: $isStartPointCurrentLocation, isEndPointCurrentLocation: $isEndPointCurrentLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStateImpl &&
            (identical(other.locationState, locationState) ||
                other.locationState == locationState) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            (identical(other.isLoadingTiles, isLoadingTiles) ||
                other.isLoadingTiles == isLoadingTiles) &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation) &&
            (identical(other.routeState, routeState) ||
                other.routeState == routeState) &&
            (identical(other.routeStartPoint, routeStartPoint) ||
                other.routeStartPoint == routeStartPoint) &&
            (identical(other.routeEndPoint, routeEndPoint) ||
                other.routeEndPoint == routeEndPoint) &&
            const DeepCollectionEquality().equals(
              other._routeLines,
              _routeLines,
            ) &&
            (identical(
                  other.isStartPointCurrentLocation,
                  isStartPointCurrentLocation,
                ) ||
                other.isStartPointCurrentLocation ==
                    isStartPointCurrentLocation) &&
            (identical(
                  other.isEndPointCurrentLocation,
                  isEndPointCurrentLocation,
                ) ||
                other.isEndPointCurrentLocation == isEndPointCurrentLocation));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    locationState,
    const DeepCollectionEquality().hash(_markers),
    isLoadingTiles,
    selectedLocation,
    routeState,
    routeStartPoint,
    routeEndPoint,
    const DeepCollectionEquality().hash(_routeLines),
    isStartPointCurrentLocation,
    isEndPointCurrentLocation,
  );

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      __$$MapStateImplCopyWithImpl<_$MapStateImpl>(this, _$identity);
}

abstract class _MapState extends MapState {
  const factory _MapState({
    final DataState<LatLng> locationState,
    final List<Marker> markers,
    final bool isLoadingTiles,
    final LatLng? selectedLocation,
    final DataState<RouteModel> routeState,
    final LatLng? routeStartPoint,
    final LatLng? routeEndPoint,
    final List<Polyline> routeLines,
    final bool isStartPointCurrentLocation,
    final bool isEndPointCurrentLocation,
  }) = _$MapStateImpl;
  const _MapState._() : super._();

  @override
  DataState<LatLng> get locationState;
  @override
  List<Marker> get markers;
  @override
  bool get isLoadingTiles;
  @override
  LatLng? get selectedLocation;
  @override
  DataState<RouteModel> get routeState;
  @override
  LatLng? get routeStartPoint;
  @override
  LatLng? get routeEndPoint;
  @override
  List<Polyline> get routeLines;
  @override
  bool get isStartPointCurrentLocation;
  @override
  bool get isEndPointCurrentLocation;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
