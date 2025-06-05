import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/address_suggestion_model.dart';

part 'address_suggestion_dto.freezed.dart';

@freezed
class AddressSuggestionDto with _$AddressSuggestionDto {
  const factory AddressSuggestionDto({
    @Default('') String displayName,
    @Default('0') String lat,
    @Default('0') String lon,
    @Default('') String type,
    @Default('') String category,
    @Default('') String osmId,
    @Default('') String osmType,
    @Default('0') String importance,
  }) = _AddressSuggestionDto;

  factory AddressSuggestionDto.fromJson(Map<String, dynamic> json) {
    return AddressSuggestionDto(
      displayName: json['display_name'] ?? '',
      lat: json['lat']?.toString() ?? '0',
      lon: json['lon']?.toString() ?? '0',
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      osmId: json['osm_id']?.toString() ?? '',
      osmType: json['osm_type']?.toString() ?? '',
      importance: json['importance']?.toString() ?? '0',
    );
  }
}

extension AddressSuggestionDtoExtension on AddressSuggestionDto {
  /// Convert DTO to domain model
  AddressSuggestion toDomain() {
    return AddressSuggestion(
      displayName: displayName,
      latitude: double.tryParse(lat) ?? 0.0,
      longitude: double.tryParse(lon) ?? 0.0,
      addressType: type,
      category: category,
      osmId: osmId,
      osmType: osmType,
      importance: double.tryParse(importance) ?? 0.0,
    );
  }
} 