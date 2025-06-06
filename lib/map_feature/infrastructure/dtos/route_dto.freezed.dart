// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RouteDto _$RouteDtoFromJson(Map<String, dynamic> json) {
  return _RouteDto.fromJson(json);
}

/// @nodoc
mixin _$RouteDto {
  List<RouteSegmentDto> get routes => throw _privateConstructorUsedError;

  /// Serializes this RouteDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteDtoCopyWith<RouteDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteDtoCopyWith<$Res> {
  factory $RouteDtoCopyWith(RouteDto value, $Res Function(RouteDto) then) =
      _$RouteDtoCopyWithImpl<$Res, RouteDto>;
  @useResult
  $Res call({List<RouteSegmentDto> routes});
}

/// @nodoc
class _$RouteDtoCopyWithImpl<$Res, $Val extends RouteDto>
    implements $RouteDtoCopyWith<$Res> {
  _$RouteDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? routes = null}) {
    return _then(
      _value.copyWith(
            routes: null == routes
                ? _value.routes
                : routes // ignore: cast_nullable_to_non_nullable
                      as List<RouteSegmentDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteDtoImplCopyWith<$Res>
    implements $RouteDtoCopyWith<$Res> {
  factory _$$RouteDtoImplCopyWith(
    _$RouteDtoImpl value,
    $Res Function(_$RouteDtoImpl) then,
  ) = __$$RouteDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RouteSegmentDto> routes});
}

/// @nodoc
class __$$RouteDtoImplCopyWithImpl<$Res>
    extends _$RouteDtoCopyWithImpl<$Res, _$RouteDtoImpl>
    implements _$$RouteDtoImplCopyWith<$Res> {
  __$$RouteDtoImplCopyWithImpl(
    _$RouteDtoImpl _value,
    $Res Function(_$RouteDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? routes = null}) {
    return _then(
      _$RouteDtoImpl(
        routes: null == routes
            ? _value._routes
            : routes // ignore: cast_nullable_to_non_nullable
                  as List<RouteSegmentDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteDtoImpl extends _RouteDto {
  const _$RouteDtoImpl({final List<RouteSegmentDto> routes = const []})
    : _routes = routes,
      super._();

  factory _$RouteDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteDtoImplFromJson(json);

  final List<RouteSegmentDto> _routes;
  @override
  @JsonKey()
  List<RouteSegmentDto> get routes {
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  @override
  String toString() {
    return 'RouteDto(routes: $routes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteDtoImpl &&
            const DeepCollectionEquality().equals(other._routes, _routes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_routes));

  /// Create a copy of RouteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteDtoImplCopyWith<_$RouteDtoImpl> get copyWith =>
      __$$RouteDtoImplCopyWithImpl<_$RouteDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteDtoImplToJson(this);
  }
}

abstract class _RouteDto extends RouteDto {
  const factory _RouteDto({final List<RouteSegmentDto> routes}) =
      _$RouteDtoImpl;
  const _RouteDto._() : super._();

  factory _RouteDto.fromJson(Map<String, dynamic> json) =
      _$RouteDtoImpl.fromJson;

  @override
  List<RouteSegmentDto> get routes;

  /// Create a copy of RouteDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteDtoImplCopyWith<_$RouteDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteSegmentDto _$RouteSegmentDtoFromJson(Map<String, dynamic> json) {
  return _RouteSegmentDto.fromJson(json);
}

/// @nodoc
mixin _$RouteSegmentDto {
  RouteSummaryDto get summary => throw _privateConstructorUsedError;
  RouteGeometryDto get geometry => throw _privateConstructorUsedError;

  /// Serializes this RouteSegmentDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteSegmentDtoCopyWith<RouteSegmentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteSegmentDtoCopyWith<$Res> {
  factory $RouteSegmentDtoCopyWith(
    RouteSegmentDto value,
    $Res Function(RouteSegmentDto) then,
  ) = _$RouteSegmentDtoCopyWithImpl<$Res, RouteSegmentDto>;
  @useResult
  $Res call({RouteSummaryDto summary, RouteGeometryDto geometry});

  $RouteSummaryDtoCopyWith<$Res> get summary;
  $RouteGeometryDtoCopyWith<$Res> get geometry;
}

/// @nodoc
class _$RouteSegmentDtoCopyWithImpl<$Res, $Val extends RouteSegmentDto>
    implements $RouteSegmentDtoCopyWith<$Res> {
  _$RouteSegmentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? geometry = null}) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as RouteSummaryDto,
            geometry: null == geometry
                ? _value.geometry
                : geometry // ignore: cast_nullable_to_non_nullable
                      as RouteGeometryDto,
          )
          as $Val,
    );
  }

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteSummaryDtoCopyWith<$Res> get summary {
    return $RouteSummaryDtoCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteGeometryDtoCopyWith<$Res> get geometry {
    return $RouteGeometryDtoCopyWith<$Res>(_value.geometry, (value) {
      return _then(_value.copyWith(geometry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteSegmentDtoImplCopyWith<$Res>
    implements $RouteSegmentDtoCopyWith<$Res> {
  factory _$$RouteSegmentDtoImplCopyWith(
    _$RouteSegmentDtoImpl value,
    $Res Function(_$RouteSegmentDtoImpl) then,
  ) = __$$RouteSegmentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RouteSummaryDto summary, RouteGeometryDto geometry});

  @override
  $RouteSummaryDtoCopyWith<$Res> get summary;
  @override
  $RouteGeometryDtoCopyWith<$Res> get geometry;
}

/// @nodoc
class __$$RouteSegmentDtoImplCopyWithImpl<$Res>
    extends _$RouteSegmentDtoCopyWithImpl<$Res, _$RouteSegmentDtoImpl>
    implements _$$RouteSegmentDtoImplCopyWith<$Res> {
  __$$RouteSegmentDtoImplCopyWithImpl(
    _$RouteSegmentDtoImpl _value,
    $Res Function(_$RouteSegmentDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? geometry = null}) {
    return _then(
      _$RouteSegmentDtoImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as RouteSummaryDto,
        geometry: null == geometry
            ? _value.geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as RouteGeometryDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteSegmentDtoImpl extends _RouteSegmentDto {
  const _$RouteSegmentDtoImpl({
    this.summary = const RouteSummaryDto(),
    this.geometry = const RouteGeometryDto(),
  }) : super._();

  factory _$RouteSegmentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteSegmentDtoImplFromJson(json);

  @override
  @JsonKey()
  final RouteSummaryDto summary;
  @override
  @JsonKey()
  final RouteGeometryDto geometry;

  @override
  String toString() {
    return 'RouteSegmentDto(summary: $summary, geometry: $geometry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteSegmentDtoImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, summary, geometry);

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteSegmentDtoImplCopyWith<_$RouteSegmentDtoImpl> get copyWith =>
      __$$RouteSegmentDtoImplCopyWithImpl<_$RouteSegmentDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteSegmentDtoImplToJson(this);
  }
}

abstract class _RouteSegmentDto extends RouteSegmentDto {
  const factory _RouteSegmentDto({
    final RouteSummaryDto summary,
    final RouteGeometryDto geometry,
  }) = _$RouteSegmentDtoImpl;
  const _RouteSegmentDto._() : super._();

  factory _RouteSegmentDto.fromJson(Map<String, dynamic> json) =
      _$RouteSegmentDtoImpl.fromJson;

  @override
  RouteSummaryDto get summary;
  @override
  RouteGeometryDto get geometry;

  /// Create a copy of RouteSegmentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteSegmentDtoImplCopyWith<_$RouteSegmentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteSummaryDto _$RouteSummaryDtoFromJson(Map<String, dynamic> json) {
  return _RouteSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$RouteSummaryDto {
  double get distance => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;

  /// Serializes this RouteSummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteSummaryDtoCopyWith<RouteSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteSummaryDtoCopyWith<$Res> {
  factory $RouteSummaryDtoCopyWith(
    RouteSummaryDto value,
    $Res Function(RouteSummaryDto) then,
  ) = _$RouteSummaryDtoCopyWithImpl<$Res, RouteSummaryDto>;
  @useResult
  $Res call({double distance, double duration});
}

/// @nodoc
class _$RouteSummaryDtoCopyWithImpl<$Res, $Val extends RouteSummaryDto>
    implements $RouteSummaryDtoCopyWith<$Res> {
  _$RouteSummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? distance = null, Object? duration = null}) {
    return _then(
      _value.copyWith(
            distance: null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteSummaryDtoImplCopyWith<$Res>
    implements $RouteSummaryDtoCopyWith<$Res> {
  factory _$$RouteSummaryDtoImplCopyWith(
    _$RouteSummaryDtoImpl value,
    $Res Function(_$RouteSummaryDtoImpl) then,
  ) = __$$RouteSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double distance, double duration});
}

/// @nodoc
class __$$RouteSummaryDtoImplCopyWithImpl<$Res>
    extends _$RouteSummaryDtoCopyWithImpl<$Res, _$RouteSummaryDtoImpl>
    implements _$$RouteSummaryDtoImplCopyWith<$Res> {
  __$$RouteSummaryDtoImplCopyWithImpl(
    _$RouteSummaryDtoImpl _value,
    $Res Function(_$RouteSummaryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? distance = null, Object? duration = null}) {
    return _then(
      _$RouteSummaryDtoImpl(
        distance: null == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteSummaryDtoImpl implements _RouteSummaryDto {
  const _$RouteSummaryDtoImpl({this.distance = 0.0, this.duration = 0.0});

  factory _$RouteSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteSummaryDtoImplFromJson(json);

  @override
  @JsonKey()
  final double distance;
  @override
  @JsonKey()
  final double duration;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteSummaryDtoImpl &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, distance, duration);

  /// Create a copy of RouteSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteSummaryDtoImplCopyWith<_$RouteSummaryDtoImpl> get copyWith =>
      __$$RouteSummaryDtoImplCopyWithImpl<_$RouteSummaryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteSummaryDtoImplToJson(this);
  }
}

abstract class _RouteSummaryDto implements RouteSummaryDto {
  const factory _RouteSummaryDto({
    final double distance,
    final double duration,
  }) = _$RouteSummaryDtoImpl;

  factory _RouteSummaryDto.fromJson(Map<String, dynamic> json) =
      _$RouteSummaryDtoImpl.fromJson;

  @override
  double get distance;
  @override
  double get duration;

  /// Create a copy of RouteSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteSummaryDtoImplCopyWith<_$RouteSummaryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteGeometryDto _$RouteGeometryDtoFromJson(Map<String, dynamic> json) {
  return _RouteGeometryDto.fromJson(json);
}

/// @nodoc
mixin _$RouteGeometryDto {
  String get type => throw _privateConstructorUsedError;
  List<List<double>> get coordinates => throw _privateConstructorUsedError;

  /// Serializes this RouteGeometryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteGeometryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteGeometryDtoCopyWith<RouteGeometryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteGeometryDtoCopyWith<$Res> {
  factory $RouteGeometryDtoCopyWith(
    RouteGeometryDto value,
    $Res Function(RouteGeometryDto) then,
  ) = _$RouteGeometryDtoCopyWithImpl<$Res, RouteGeometryDto>;
  @useResult
  $Res call({String type, List<List<double>> coordinates});
}

/// @nodoc
class _$RouteGeometryDtoCopyWithImpl<$Res, $Val extends RouteGeometryDto>
    implements $RouteGeometryDtoCopyWith<$Res> {
  _$RouteGeometryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteGeometryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? coordinates = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            coordinates: null == coordinates
                ? _value.coordinates
                : coordinates // ignore: cast_nullable_to_non_nullable
                      as List<List<double>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteGeometryDtoImplCopyWith<$Res>
    implements $RouteGeometryDtoCopyWith<$Res> {
  factory _$$RouteGeometryDtoImplCopyWith(
    _$RouteGeometryDtoImpl value,
    $Res Function(_$RouteGeometryDtoImpl) then,
  ) = __$$RouteGeometryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, List<List<double>> coordinates});
}

/// @nodoc
class __$$RouteGeometryDtoImplCopyWithImpl<$Res>
    extends _$RouteGeometryDtoCopyWithImpl<$Res, _$RouteGeometryDtoImpl>
    implements _$$RouteGeometryDtoImplCopyWith<$Res> {
  __$$RouteGeometryDtoImplCopyWithImpl(
    _$RouteGeometryDtoImpl _value,
    $Res Function(_$RouteGeometryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteGeometryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? coordinates = null}) {
    return _then(
      _$RouteGeometryDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        coordinates: null == coordinates
            ? _value._coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as List<List<double>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteGeometryDtoImpl implements _RouteGeometryDto {
  const _$RouteGeometryDtoImpl({
    this.type = 'LineString',
    final List<List<double>> coordinates = const [],
  }) : _coordinates = coordinates;

  factory _$RouteGeometryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteGeometryDtoImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  final List<List<double>> _coordinates;
  @override
  @JsonKey()
  List<List<double>> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  String toString() {
    return 'RouteGeometryDto(type: $type, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteGeometryDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._coordinates,
              _coordinates,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_coordinates),
  );

  /// Create a copy of RouteGeometryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteGeometryDtoImplCopyWith<_$RouteGeometryDtoImpl> get copyWith =>
      __$$RouteGeometryDtoImplCopyWithImpl<_$RouteGeometryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteGeometryDtoImplToJson(this);
  }
}

abstract class _RouteGeometryDto implements RouteGeometryDto {
  const factory _RouteGeometryDto({
    final String type,
    final List<List<double>> coordinates,
  }) = _$RouteGeometryDtoImpl;

  factory _RouteGeometryDto.fromJson(Map<String, dynamic> json) =
      _$RouteGeometryDtoImpl.fromJson;

  @override
  String get type;
  @override
  List<List<double>> get coordinates;

  /// Create a copy of RouteGeometryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteGeometryDtoImplCopyWith<_$RouteGeometryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
