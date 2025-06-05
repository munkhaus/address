import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/service_locator.dart';
import '../../core/utils/data_state.dart';
import '../domain/i_address_service.dart';
import '../domain/address_suggestion_model.dart';
import '../domain/map_errors.dart';
import 'address_search_state.dart';

class AddressSearchCubit extends Cubit<AddressSearchState> {
  final IAddressService _addressService;
  Timer? _debounceTimer;

  AddressSearchCubit({
    IAddressService? addressService,
  })  : _addressService = addressService ?? getdep<IAddressService>(),
        super(AddressSearchState.initial());

  /// Search for addresses with debouncing
  void searchAddresses(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Update current query and show suggestions panel
    emit(state.copyWith(
      currentQuery: query,
      showSuggestions: query.isNotEmpty,
    ));

    // Clear suggestions if query is empty
    if (query.trim().isEmpty) {
      emit(state.copyWith(
        searchState: const DataState.idle(),
        showSuggestions: false,
      ));
      return;
    }

    // Set debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query.trim());
    });
  }

  /// Clear search results and hide suggestions
  void clearSearch() {
    _debounceTimer?.cancel();
    emit(state.copyWith(
      currentQuery: '',
      searchState: const DataState.idle(),
      showSuggestions: false,
      selectedSuggestion: null,
    ));
  }

  /// Hide suggestions without clearing the search
  void hideSuggestions() {
    emit(state.copyWith(showSuggestions: false));
  }

  /// Show suggestions panel
  void showSuggestions() {
    if (state.currentQuery.isNotEmpty) {
      emit(state.copyWith(showSuggestions: true));
    }
  }

  /// Select a suggestion from the list
  void selectSuggestion(AddressSuggestion suggestion) {
    emit(state.copyWith(
      selectedSuggestion: suggestion,
      currentQuery: suggestion.shortDisplayName,
      showSuggestions: false,
    ));
  }

  /// Perform the actual search
  Future<void> _performSearch(String query) async {
    if (query.length < 3) {
      emit(state.copyWith(
        searchState: const DataState.error('Search query too short'),
      ));
      return;
    }

    emit(state.copyWith(
      searchState: const DataState.loading(),
    ));

    final result = await _addressService.searchAddresses(query);
    
    result.when(
      success: (suggestions) {
        emit(state.copyWith(
          searchState: DataState.success(suggestions),
        ));
      },
      failure: (error) {
        String errorMessage;
        switch (error) {
          case ApiError.searchQueryTooShort:
            errorMessage = 'Search query is too short';
            break;
          case ApiError.noResultsFound:
            errorMessage = 'No addresses found';
            break;
          case ApiError.networkError:
            errorMessage = 'Network error. Please check your connection.';
            break;
          case ApiError.rateLimitExceeded:
            errorMessage = 'Too many requests. Please wait a moment.';
            break;
          default:
            errorMessage = 'Search failed. Please try again.';
        }
        
        emit(state.copyWith(
          searchState: DataState.error(errorMessage),
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
} 