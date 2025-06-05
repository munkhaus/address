// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_suggestion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddressSuggestion {
  String get displayName => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get addressType => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get osmId => throw _privateConstructorUsedError;
  String get osmType => throw _privateConstructorUsedError;
  double get importance => throw _privateConstructorUsedError;

  /// Create a copy of AddressSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressSuggestionCopyWith<AddressSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressSuggestionCopyWith<$Res> {
  factory $AddressSuggestionCopyWith(
    AddressSuggestion value,
    $Res Function(AddressSuggestion) then,
  ) = _$AddressSuggestionCopyWithImpl<$Res, AddressSuggestion>;
  @useResult
  $Res call({
    String displayName,
    double latitude,
    double longitude,
    String addressType,
    String category,
    String osmId,
    String osmType,
    double importance,
  });
}

/// @nodoc
class _$AddressSuggestionCopyWithImpl<$Res, $Val extends AddressSuggestion>
    implements $AddressSuggestionCopyWith<$Res> {
  _$AddressSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressType = null,
    Object? category = null,
    Object? osmId = null,
    Object? osmType = null,
    Object? importance = null,
  }) {
    return _then(
      _value.copyWith(
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            addressType: null == addressType
                ? _value.addressType
                : addressType // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            osmId: null == osmId
                ? _value.osmId
                : osmId // ignore: cast_nullable_to_non_nullable
                      as String,
            osmType: null == osmType
                ? _value.osmType
                : osmType // ignore: cast_nullable_to_non_nullable
                      as String,
            importance: null == importance
                ? _value.importance
                : importance // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressSuggestionImplCopyWith<$Res>
    implements $AddressSuggestionCopyWith<$Res> {
  factory _$$AddressSuggestionImplCopyWith(
    _$AddressSuggestionImpl value,
    $Res Function(_$AddressSuggestionImpl) then,
  ) = __$$AddressSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String displayName,
    double latitude,
    double longitude,
    String addressType,
    String category,
    String osmId,
    String osmType,
    double importance,
  });
}

/// @nodoc
class __$$AddressSuggestionImplCopyWithImpl<$Res>
    extends _$AddressSuggestionCopyWithImpl<$Res, _$AddressSuggestionImpl>
    implements _$$AddressSuggestionImplCopyWith<$Res> {
  __$$AddressSuggestionImplCopyWithImpl(
    _$AddressSuggestionImpl _value,
    $Res Function(_$AddressSuggestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? addressType = null,
    Object? category = null,
    Object? osmId = null,
    Object? osmType = null,
    Object? importance = null,
  }) {
    return _then(
      _$AddressSuggestionImpl(
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        addressType: null == addressType
            ? _value.addressType
            : addressType // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        osmId: null == osmId
            ? _value.osmId
            : osmId // ignore: cast_nullable_to_non_nullable
                  as String,
        osmType: null == osmType
            ? _value.osmType
            : osmType // ignore: cast_nullable_to_non_nullable
                  as String,
        importance: null == importance
            ? _value.importance
            : importance // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$AddressSuggestionImpl implements _AddressSuggestion {
  const _$AddressSuggestionImpl({
    this.displayName = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.addressType = '',
    this.category = '',
    this.osmId = '',
    this.osmType = '',
    this.importance = 0.0,
  });

  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  @JsonKey()
  final String addressType;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String osmId;
  @override
  @JsonKey()
  final String osmType;
  @override
  @JsonKey()
  final double importance;

  @override
  String toString() {
    return 'AddressSuggestion(displayName: $displayName, latitude: $latitude, longitude: $longitude, addressType: $addressType, category: $category, osmId: $osmId, osmType: $osmType, importance: $importance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressSuggestionImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.osmId, osmId) || other.osmId == osmId) &&
            (identical(other.osmType, osmType) || other.osmType == osmType) &&
            (identical(other.importance, importance) ||
                other.importance == importance));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    displayName,
    latitude,
    longitude,
    addressType,
    category,
    osmId,
    osmType,
    importance,
  );

  /// Create a copy of AddressSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressSuggestionImplCopyWith<_$AddressSuggestionImpl> get copyWith =>
      __$$AddressSuggestionImplCopyWithImpl<_$AddressSuggestionImpl>(
        this,
        _$identity,
      );
}

abstract class _AddressSuggestion implements AddressSuggestion {
  const factory _AddressSuggestion({
    final String displayName,
    final double latitude,
    final double longitude,
    final String addressType,
    final String category,
    final String osmId,
    final String osmType,
    final double importance,
  }) = _$AddressSuggestionImpl;

  @override
  String get displayName;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get addressType;
  @override
  String get category;
  @override
  String get osmId;
  @override
  String get osmType;
  @override
  double get importance;

  /// Create a copy of AddressSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressSuggestionImplCopyWith<_$AddressSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
