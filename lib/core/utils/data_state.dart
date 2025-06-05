import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState<T> {
  const DataState._();

  const factory DataState.idle() = _Idle<T>;
  const factory DataState.loading() = _Loading<T>;
  const factory DataState.success(T data) = _Success<T>;
  const factory DataState.error([String? message]) = _Error<T>;

  bool get isIdle => this is _Idle<T>;
  bool get isLoading => this is _Loading<T>;
  bool get isSuccess => this is _Success<T>;
  bool get hasError => this is _Error<T>;
  
  T? get data => whenOrNull(success: (data) => data);
  String? get errorMessage => whenOrNull(error: (message) => message);
} 