import '../../core/utils/result.dart';
import 'address_suggestion_model.dart';
import 'map_errors.dart';

abstract class IAddressService {
  /// Searches for addresses using the provided query.
  /// 
  /// Returns [Result.failure] with [ApiError.networkError] if network fails.
  /// Returns [Result.failure] with [ApiError.searchQueryTooShort] if query is too short.
  /// Returns [Result.failure] with [ApiError.noResultsFound] if no results are found.
  Future<Result<List<AddressSuggestion>, ApiError>> searchAddresses(
    String query, {
    int limit = 8,
  });

  /// Performs reverse geocoding for the given coordinates.
  /// 
  /// Returns [Result.failure] with [ApiError.networkError] if network fails.
  /// Returns [Result.failure] with [ApiError.noResultsFound] if no address found.
  Future<Result<AddressSuggestion, ApiError>> reverseGeocode(
    double latitude,
    double longitude,
  );
} 