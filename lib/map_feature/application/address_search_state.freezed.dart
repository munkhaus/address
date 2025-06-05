// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddressSearchState {
  DataState<List<AddressSuggestion>> get searchState =>
      throw _privateConstructorUsedError;
  String get currentQuery => throw _privateConstructorUsedError;
  bool get showSuggestions => throw _privateConstructorUsedError;
  AddressSuggestion? get selectedSuggestion =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressSearchStateCopyWith<AddressSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressSearchStateCopyWith<$Res> {
  factory $AddressSearchStateCopyWith(
    AddressSearchState value,
    $Res Function(AddressSearchState) then,
  ) = _$AddressSearchStateCopyWithImpl<$Res, AddressSearchState>;
  @useResult
  $Res call({
    DataState<List<AddressSuggestion>> searchState,
    String currentQuery,
    bool showSuggestions,
    AddressSuggestion? selectedSuggestion,
  });

  $DataStateCopyWith<List<AddressSuggestion>, $Res> get searchState;
  $AddressSuggestionCopyWith<$Res>? get selectedSuggestion;
}

/// @nodoc
class _$AddressSearchStateCopyWithImpl<$Res, $Val extends AddressSearchState>
    implements $AddressSearchStateCopyWith<$Res> {
  _$AddressSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchState = null,
    Object? currentQuery = null,
    Object? showSuggestions = null,
    Object? selectedSuggestion = freezed,
  }) {
    return _then(
      _value.copyWith(
            searchState: null == searchState
                ? _value.searchState
                : searchState // ignore: cast_nullable_to_non_nullable
                      as DataState<List<AddressSuggestion>>,
            currentQuery: null == currentQuery
                ? _value.currentQuery
                : currentQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            showSuggestions: null == showSuggestions
                ? _value.showSuggestions
                : showSuggestions // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedSuggestion: freezed == selectedSuggestion
                ? _value.selectedSuggestion
                : selectedSuggestion // ignore: cast_nullable_to_non_nullable
                      as AddressSuggestion?,
          )
          as $Val,
    );
  }

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataStateCopyWith<List<AddressSuggestion>, $Res> get searchState {
    return $DataStateCopyWith<List<AddressSuggestion>, $Res>(
      _value.searchState,
      (value) {
        return _then(_value.copyWith(searchState: value) as $Val);
      },
    );
  }

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressSuggestionCopyWith<$Res>? get selectedSuggestion {
    if (_value.selectedSuggestion == null) {
      return null;
    }

    return $AddressSuggestionCopyWith<$Res>(_value.selectedSuggestion!, (
      value,
    ) {
      return _then(_value.copyWith(selectedSuggestion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressSearchStateImplCopyWith<$Res>
    implements $AddressSearchStateCopyWith<$Res> {
  factory _$$AddressSearchStateImplCopyWith(
    _$AddressSearchStateImpl value,
    $Res Function(_$AddressSearchStateImpl) then,
  ) = __$$AddressSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DataState<List<AddressSuggestion>> searchState,
    String currentQuery,
    bool showSuggestions,
    AddressSuggestion? selectedSuggestion,
  });

  @override
  $DataStateCopyWith<List<AddressSuggestion>, $Res> get searchState;
  @override
  $AddressSuggestionCopyWith<$Res>? get selectedSuggestion;
}

/// @nodoc
class __$$AddressSearchStateImplCopyWithImpl<$Res>
    extends _$AddressSearchStateCopyWithImpl<$Res, _$AddressSearchStateImpl>
    implements _$$AddressSearchStateImplCopyWith<$Res> {
  __$$AddressSearchStateImplCopyWithImpl(
    _$AddressSearchStateImpl _value,
    $Res Function(_$AddressSearchStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchState = null,
    Object? currentQuery = null,
    Object? showSuggestions = null,
    Object? selectedSuggestion = freezed,
  }) {
    return _then(
      _$AddressSearchStateImpl(
        searchState: null == searchState
            ? _value.searchState
            : searchState // ignore: cast_nullable_to_non_nullable
                  as DataState<List<AddressSuggestion>>,
        currentQuery: null == currentQuery
            ? _value.currentQuery
            : currentQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        showSuggestions: null == showSuggestions
            ? _value.showSuggestions
            : showSuggestions // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedSuggestion: freezed == selectedSuggestion
            ? _value.selectedSuggestion
            : selectedSuggestion // ignore: cast_nullable_to_non_nullable
                  as AddressSuggestion?,
      ),
    );
  }
}

/// @nodoc

class _$AddressSearchStateImpl extends _AddressSearchState {
  const _$AddressSearchStateImpl({
    this.searchState = const DataState.idle(),
    this.currentQuery = '',
    this.showSuggestions = false,
    this.selectedSuggestion,
  }) : super._();

  @override
  @JsonKey()
  final DataState<List<AddressSuggestion>> searchState;
  @override
  @JsonKey()
  final String currentQuery;
  @override
  @JsonKey()
  final bool showSuggestions;
  @override
  final AddressSuggestion? selectedSuggestion;

  @override
  String toString() {
    return 'AddressSearchState(searchState: $searchState, currentQuery: $currentQuery, showSuggestions: $showSuggestions, selectedSuggestion: $selectedSuggestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressSearchStateImpl &&
            (identical(other.searchState, searchState) ||
                other.searchState == searchState) &&
            (identical(other.currentQuery, currentQuery) ||
                other.currentQuery == currentQuery) &&
            (identical(other.showSuggestions, showSuggestions) ||
                other.showSuggestions == showSuggestions) &&
            (identical(other.selectedSuggestion, selectedSuggestion) ||
                other.selectedSuggestion == selectedSuggestion));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    searchState,
    currentQuery,
    showSuggestions,
    selectedSuggestion,
  );

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressSearchStateImplCopyWith<_$AddressSearchStateImpl> get copyWith =>
      __$$AddressSearchStateImplCopyWithImpl<_$AddressSearchStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AddressSearchState extends AddressSearchState {
  const factory _AddressSearchState({
    final DataState<List<AddressSuggestion>> searchState,
    final String currentQuery,
    final bool showSuggestions,
    final AddressSuggestion? selectedSuggestion,
  }) = _$AddressSearchStateImpl;
  const _AddressSearchState._() : super._();

  @override
  DataState<List<AddressSuggestion>> get searchState;
  @override
  String get currentQuery;
  @override
  bool get showSuggestions;
  @override
  AddressSuggestion? get selectedSuggestion;

  /// Create a copy of AddressSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressSearchStateImplCopyWith<_$AddressSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
