import '../../core/utils/result.dart';
import 'address_suggestion_model.dart';
import 'map_errors.dart';

abstract class IAddressService {
  /// Searches for addresses using the provided query.
  /// 
  /// Returns [Result.failure] with [AddressError.networkError] if network fails.
  /// Returns [Result.failure] with [AddressError.searchQueryTooShort] if query is too short.
  /// Returns [Result.failure] with [AddressError.noResultsFound] if no results are found.
  Future<Result<List<AddressSuggestion>, AddressError>> searchAddresses(
    String query, {
    int limit = 8,
  });

  /// Performs reverse geocoding for the given coordinates.
  /// 
  /// Returns [Result.failure] with [AddressError.networkError] if network fails.
  /// Returns [Result.failure] with [AddressError.noResultsFound] if no address found.
  Future<Result<AddressSuggestion, AddressError>> reverseGeocode(
    double latitude,
    double longitude,
  );
} 