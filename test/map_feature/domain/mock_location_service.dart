import 'package:flutter_application_9/core/utils/result.dart';
import 'package:flutter_application_9/map_feature/domain/i_location_service.dart';
import 'package:flutter_application_9/map_feature/domain/map_errors.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/mockito.dart';

// MockLocationService with default implementations for all methods
class MockLocationService extends Mock implements ILocationService {
  // Default LatLng for successful results if not overridden by 'when'
  final LatLng _defaultLatLng = const LatLng(0, 0);
  final LocationError _defaultError = LocationError.unknown;

  @override
  Future<Result<LatLng, LocationError>> getCurrentLocation() {
    return super.noSuchMethod(
      Invocation.method(#getCurrentLocation, []),
      returnValue: Future.value(Result<LatLng, LocationError>.success(_defaultLatLng)),
      returnValueForMissingStub: Future.value(Result<LatLng, LocationError>.failure(_defaultError)),
    ) as Future<Result<LatLng, LocationError>>;
  }

  @override
  Future<bool> hasLocationPermission() {
    return super.noSuchMethod(
      Invocation.method(#hasLocationPermission, []),
      returnValue: Future.value(false),
      returnValueForMissingStub: Future.value(false),
    ) as Future<bool>;
  }

  @override
  Future<bool> requestLocationPermission() {
    return super.noSuchMethod(
      Invocation.method(#requestLocationPermission, []),
      returnValue: Future.value(false),
      returnValueForMissingStub: Future.value(false),
    ) as Future<bool>;
  }
}
