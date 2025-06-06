// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RouteModel {
  String get id => throw _privateConstructorUsedError;
  List<LatLng> get waypoints => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String get routeType => throw _privateConstructorUsedError;
  String get instructions => throw _privateConstructorUsedError;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteModelCopyWith<RouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteModelCopyWith<$Res> {
  factory $RouteModelCopyWith(
    RouteModel value,
    $Res Function(RouteModel) then,
  ) = _$RouteModelCopyWithImpl<$Res, RouteModel>;
  @useResult
  $Res call({
    String id,
    List<LatLng> waypoints,
    double distanceKm,
    int durationMinutes,
    String routeType,
    String instructions,
  });
}

/// @nodoc
class _$RouteModelCopyWithImpl<$Res, $Val extends RouteModel>
    implements $RouteModelCopyWith<$Res> {
  _$RouteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? waypoints = null,
    Object? distanceKm = null,
    Object? durationMinutes = null,
    Object? routeType = null,
    Object? instructions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            waypoints: null == waypoints
                ? _value.waypoints
                : waypoints // ignore: cast_nullable_to_non_nullable
                      as List<LatLng>,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            routeType: null == routeType
                ? _value.routeType
                : routeType // ignore: cast_nullable_to_non_nullable
                      as String,
            instructions: null == instructions
                ? _value.instructions
                : instructions // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteModelImplCopyWith<$Res>
    implements $RouteModelCopyWith<$Res> {
  factory _$$RouteModelImplCopyWith(
    _$RouteModelImpl value,
    $Res Function(_$RouteModelImpl) then,
  ) = __$$RouteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<LatLng> waypoints,
    double distanceKm,
    int durationMinutes,
    String routeType,
    String instructions,
  });
}

/// @nodoc
class __$$RouteModelImplCopyWithImpl<$Res>
    extends _$RouteModelCopyWithImpl<$Res, _$RouteModelImpl>
    implements _$$RouteModelImplCopyWith<$Res> {
  __$$RouteModelImplCopyWithImpl(
    _$RouteModelImpl _value,
    $Res Function(_$RouteModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? waypoints = null,
    Object? distanceKm = null,
    Object? durationMinutes = null,
    Object? routeType = null,
    Object? instructions = null,
  }) {
    return _then(
      _$RouteModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        waypoints: null == waypoints
            ? _value._waypoints
            : waypoints // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        routeType: null == routeType
            ? _value.routeType
            : routeType // ignore: cast_nullable_to_non_nullable
                  as String,
        instructions: null == instructions
            ? _value.instructions
            : instructions // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RouteModelImpl extends _RouteModel {
  const _$RouteModelImpl({
    this.id = '',
    final List<LatLng> waypoints = const [],
    this.distanceKm = 0.0,
    this.durationMinutes = 0,
    this.routeType = '',
    this.instructions = '',
  }) : _waypoints = waypoints,
       super._();

  @override
  @JsonKey()
  final String id;
  final List<LatLng> _waypoints;
  @override
  @JsonKey()
  List<LatLng> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  @JsonKey()
  final double distanceKm;
  @override
  @JsonKey()
  final int durationMinutes;
  @override
  @JsonKey()
  final String routeType;
  @override
  @JsonKey()
  final String instructions;

  @override
  String toString() {
    return 'RouteModel(id: $id, waypoints: $waypoints, distanceKm: $distanceKm, durationMinutes: $durationMinutes, routeType: $routeType, instructions: $instructions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._waypoints,
              _waypoints,
            ) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.routeType, routeType) ||
                other.routeType == routeType) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_waypoints),
    distanceKm,
    durationMinutes,
    routeType,
    instructions,
  );

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteModelImplCopyWith<_$RouteModelImpl> get copyWith =>
      __$$RouteModelImplCopyWithImpl<_$RouteModelImpl>(this, _$identity);
}

abstract class _RouteModel extends RouteModel {
  const factory _RouteModel({
    final String id,
    final List<LatLng> waypoints,
    final double distanceKm,
    final int durationMinutes,
    final String routeType,
    final String instructions,
  }) = _$RouteModelImpl;
  const _RouteModel._() : super._();

  @override
  String get id;
  @override
  List<LatLng> get waypoints;
  @override
  double get distanceKm;
  @override
  int get durationMinutes;
  @override
  String get routeType;
  @override
  String get instructions;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteModelImplCopyWith<_$RouteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
