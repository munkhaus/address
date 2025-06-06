// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteDtoImpl _$$RouteDtoImplFromJson(Map<String, dynamic> json) =>
    _$RouteDtoImpl(
      routes:
          (json['routes'] as List<dynamic>?)
              ?.map((e) => RouteSegmentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RouteDtoImplToJson(_$RouteDtoImpl instance) =>
    <String, dynamic>{'routes': instance.routes};

_$RouteSegmentDtoImpl _$$RouteSegmentDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RouteSegmentDtoImpl(
  summary: json['summary'] == null
      ? const RouteSummaryDto()
      : RouteSummaryDto.fromJson(json['summary'] as Map<String, dynamic>),
  geometry: json['geometry'] == null
      ? const RouteGeometryDto()
      : RouteGeometryDto.fromJson(json['geometry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$RouteSegmentDtoImplToJson(
  _$RouteSegmentDtoImpl instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'geometry': instance.geometry,
};

_$RouteSummaryDtoImpl _$$RouteSummaryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RouteSummaryDtoImpl(
  distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
  duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$RouteSummaryDtoImplToJson(
  _$RouteSummaryDtoImpl instance,
) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
};

_$RouteGeometryDtoImpl _$$RouteGeometryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RouteGeometryDtoImpl(
  type: json['type'] as String? ?? 'LineString',
  coordinates:
      (json['coordinates'] as List<dynamic>?)
          ?.map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RouteGeometryDtoImplToJson(
  _$RouteGeometryDtoImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'coordinates': instance.coordinates,
};
