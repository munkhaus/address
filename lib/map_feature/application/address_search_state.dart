import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/data_state.dart';
import '../domain/address_suggestion_model.dart';

part 'address_search_state.freezed.dart';

@freezed
class AddressSearchState with _$AddressSearchState {
  const AddressSearchState._();

  const factory AddressSearchState({
    @Default(DataState.idle()) DataState<List<AddressSuggestion>> searchState,
    @Default('') String currentQuery,
    @Default(false) bool showSuggestions,
    AddressSuggestion? selectedSuggestion,
  }) = _AddressSearchState;

  // Helper getters for derived states
  bool get isSearching => searchState.isLoading;
  bool get hasSearchError => searchState.hasError;
  bool get hasSearchResults => searchState.isSuccess;
  bool get hasSuggestions => searchState.data?.isNotEmpty == true;
  bool get shouldShowSuggestions => showSuggestions && (isSearching || hasSuggestions);
  
  List<AddressSuggestion> get suggestions => searchState.data ?? [];
  String? get searchErrorMessage => searchState.errorMessage;

  factory AddressSearchState.initial() => const AddressSearchState();
} 