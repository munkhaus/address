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
  Future<Result<List<AddressSuggestion>, ApiError>> searchAddresses(
    String query, {
    int limit = 8,
  }) async {
    // Validate query length
    if (query.trim().length < 3) {
      return const Result.failure(ApiError.searchQueryTooShort);
    }

    try {
      final url = NominatimApiKeys.searchUrl(query.trim(), limit: limit);
      
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
        
        if (data.isEmpty) {
          return const Result.failure(ApiError.noResultsFound);
        }

        final suggestions = data
            .map((json) => AddressSuggestionDto.fromJson(json).toDomain())
            .toList();
            
        return Result.success(suggestions);
      } else if (response.statusCode == 429) {
        return const Result.failure(ApiError.rateLimitExceeded);
      } else {
        return const Result.failure(ApiError.serverError);
      }
    } on TimeoutException {
      return const Result.failure(ApiError.networkError);
    } on FormatException {
      return const Result.failure(ApiError.serverError);
    } catch (e) {
      return const Result.failure(ApiError.networkError);
    }
  }

  @override
  Future<Result<AddressSuggestion, ApiError>> reverseGeocode(
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
          return const Result.failure(ApiError.noResultsFound);
        }

        final suggestion = AddressSuggestionDto.fromJson(data).toDomain();
        return Result.success(suggestion);
      } else if (response.statusCode == 429) {
        return const Result.failure(ApiError.rateLimitExceeded);
      } else {
        return const Result.failure(ApiError.serverError);
      }
    } on TimeoutException {
      return const Result.failure(ApiError.networkError);
    } on FormatException {
      return const Result.failure(ApiError.serverError);
    } catch (e) {
      return const Result.failure(ApiError.networkError);
    }
  }

  void dispose() {
    _httpClient.close();
  }
} 