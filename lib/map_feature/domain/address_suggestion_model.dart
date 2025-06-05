import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'address_suggestion_model.freezed.dart';

@freezed
class AddressSuggestion with _$AddressSuggestion {
  const factory AddressSuggestion({
    @Default('') String displayName,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default('') String addressType,
    @Default('') String category,
    @Default('') String osmId,
    @Default('') String osmType,
    @Default(0.0) double importance,
  }) = _AddressSuggestion;
}

extension AddressSuggestionExtension on AddressSuggestion {
  LatLng get coordinates => LatLng(latitude, longitude);
  
  String get shortDisplayName {
    final parts = displayName.split(',');
    if (parts.length >= 2) {
      return '${parts[0].trim()}, ${parts[1].trim()}';
    }
    return displayName;
  }
  
  String get subtitle {
    final parts = displayName.split(',');
    if (parts.length > 2) {
      return parts.skip(2).map((e) => e.trim()).join(', ');
    }
    return addressType.isNotEmpty ? addressType : category;
  }
} 