import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/utils/result.dart';
import '../domain/i_address_service.dart';
import '../domain/address_suggestion_model.dart';
import '../domain/map_errors.dart';
import 'constants/nominatim_api_keys.dart';
import 'dtos/address_suggestion_dto.dart';

class NominatimService implements IAddressService {
  final http.Client _httpClient;
  
  NominatimService({http.Client? httpClient}) 
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<Result<List<AddressSuggestion>, AddressError>> searchAddresses(
    String query, {
    int limit = 8,
  }) async {
    // Validate query length
    if (query.trim().length < 3) {
      return const Result.failure(AddressError.searchQueryTooShort);
    }

    try {
      // Try the original query first
      final result = await _performSearch(query.trim(), limit);
      
      // If no results and query contains comma, try fallback strategies
      if (result.isEmpty && query.contains(',')) {
        final fallbackResult = await _performFallbackSearch(query.trim(), limit);
        if (fallbackResult.isNotEmpty) {
          return Result.success(fallbackResult);
        }
      }
      
      if (result.isEmpty) {
        return const Result.failure(AddressError.noResultsFound);
      }

      return Result.success(result);
    } on TimeoutException {
      return const Result.failure(AddressError.networkError);
    } on FormatException {
      return const Result.failure(AddressError.serverError);
    } on AddressError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return const Result.failure(AddressError.networkError);
    }
  }

  /// Perform the actual search request
  Future<List<AddressSuggestion>> _performSearch(String query, int limit) async {
    final url = NominatimApiKeys.searchUrl(query, limit: limit);
    
    final response = await _httpClient
        .get(
          Uri.parse(url),
          headers: NominatimApiKeys.headers,
        )
        .timeout(
          Duration(seconds: NominatimApiKeys.requestTimeoutSeconds),
        );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => AddressSuggestionDto.fromJson(json).toDomain())
          .toList();
    } else if (response.statusCode == 429) {
      throw AddressError.rateLimitExceeded;
    } else {
      throw AddressError.serverError;
    }
  }

  /// Try alternative search strategies for complex queries
  Future<List<AddressSuggestion>> _performFallbackSearch(String query, int limit) async {
    final parts = query.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    
    // Strategy 1: Try without the first part (often building name)
    if (parts.length > 1) {
      final addressParts = parts.skip(1).join(', ');
      final result = await _performSearch(addressParts, limit);
      if (result.isNotEmpty) return result;
    }
    
    // Strategy 2: Try with just street and postal code
    if (parts.length >= 2) {
      // Look for postal code pattern (4 digits) and city
      for (int i = 0; i < parts.length; i++) {
        final part = parts[i];
        if (RegExp(r'\b\d{4}\b').hasMatch(part)) {
          // Found postal code, combine with previous part (likely street)
          if (i > 0) {
            final streetAndPostal = '${parts[i-1]}, $part';
            final result = await _performSearch(streetAndPostal, limit);
            if (result.isNotEmpty) return result;
          }
        }
      }
    }
    
    // Strategy 3: Try each significant part individually
    for (final part in parts) {
      if (part.length > 3 && !_isLikelyBuildingName(part)) {
        final result = await _performSearch(part, limit);
        if (result.isNotEmpty) return result;
      }
    }
    
    return [];
  }

  /// Check if a string is likely a building or place name
  bool _isLikelyBuildingName(String text) {
    // Common Danish building name patterns
    return text.toLowerCase().endsWith('gård') ||
           text.toLowerCase().endsWith('gården') ||
           text.toLowerCase().contains('center') ||
           text.toLowerCase().contains('centre') ||
           text.toLowerCase().contains('hus') ||
           text.toLowerCase().contains('villa');
  }

  @override
  Future<Result<AddressSuggestion, AddressError>> reverseGeocode(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = NominatimApiKeys.reverseUrl(latitude, longitude);
      
      final response = await _httpClient
          .get(
            Uri.parse(url),
            headers: NominatimApiKeys.headers,
          )
          .timeout(
            Duration(seconds: NominatimApiKeys.requestTimeoutSeconds),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data.isEmpty || data['error'] != null) {
          return const Result.failure(AddressError.noResultsFound);
        }

        final suggestion = AddressSuggestionDto.fromJson(data).toDomain();
        return Result.success(suggestion);
      } else if (response.statusCode == 429) {
        return const Result.failure(AddressError.rateLimitExceeded);
      } else {
        return const Result.failure(AddressError.serverError);
      }
    } on TimeoutException {
      return const Result.failure(AddressError.networkError);
    } on FormatException {
      return const Result.failure(AddressError.serverError);
    } catch (e) {
      return const Result.failure(AddressError.networkError);
    }
  }

  void dispose() {
    _httpClient.close();
  }
} 