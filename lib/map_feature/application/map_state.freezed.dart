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
  });

  $DataStateCopyWith<LatLng, $Res> get locationState;
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
  });

  @override
  $DataStateCopyWith<LatLng, $Res> get locationState;
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
  }) : _markers = markers,
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
  String toString() {
    return 'MapState(locationState: $locationState, markers: $markers, isLoadingTiles: $isLoadingTiles, selectedLocation: $selectedLocation)';
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
                other.selectedLocation == selectedLocation));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    locationState,
    const DeepCollectionEquality().hash(_markers),
    isLoadingTiles,
    selectedLocation,
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

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
