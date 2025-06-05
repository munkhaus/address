import 'dart:async';
import 'package:flutter_application_9/core/utils/result.dart';
import 'package:flutter_application_9/map_feature/domain/map_errors.dart';
import 'package:flutter_application_9/map_feature/infrastructure/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// Manually define the mock using MockPlatformInterfaceMixin
// and providing default implementations for all methods.
class MockGeolocatorPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {

  @override
  Future<LocationPermission> checkPermission() {
    return super.noSuchMethod(
      Invocation.method(#checkPermission, []),
      returnValue: Future.value(LocationPermission.denied),
      returnValueForMissingStub: Future.value(LocationPermission.denied),
    ) as Future<LocationPermission>;
  }

  @override
  Future<LocationPermission> requestPermission() {
    return super.noSuchMethod(
      Invocation.method(#requestPermission, []),
      returnValue: Future.value(LocationPermission.denied),
      returnValueForMissingStub: Future.value(LocationPermission.denied),
    ) as Future<LocationPermission>;
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return super.noSuchMethod(
      Invocation.method(#isLocationServiceEnabled, []),
      returnValue: Future.value(false),
      returnValueForMissingStub: Future.value(false),
    ) as Future<bool>;
  }

  @override
  Future<Position?> getLastKnownPosition({bool forceLocationManager = false}) {
    return super.noSuchMethod(
      Invocation.method(#getLastKnownPosition, [], {#forceLocationManager: forceLocationManager}),
      returnValue: Future<Position?>.value(null),
      returnValueForMissingStub: Future<Position?>.value(null),
    ) as Future<Position?>;
  }

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) {
    // Provide a default valid Position object for cases where it's not specifically stubbed
    final defaultPosition = Position(
        latitude: 0.0, longitude: 0.0, timestamp: DateTime(2023), accuracy: 0.0,
        altitude: 0.0, altitudeAccuracy: 0.0, heading: 0.0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0);
    return super.noSuchMethod(
      Invocation.method(#getCurrentPosition, [], {#locationSettings: locationSettings}),
      returnValue: Future.value(defaultPosition),
      returnValueForMissingStub: Future.value(defaultPosition),
    ) as Future<Position>;
  }

  @override
  Stream<ServiceStatus> getServiceStatusStream() {
    return super.noSuchMethod(
      Invocation.method(#getServiceStatusStream, []),
      returnValue: Stream.value(ServiceStatus.disabled),
      returnValueForMissingStub: Stream.value(ServiceStatus.disabled),
    ) as Stream<ServiceStatus>;
  }

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    return super.noSuchMethod(
      Invocation.method(#getPositionStream, [], {#locationSettings: locationSettings}),
      returnValue: Stream<Position>.empty(),
      returnValueForMissingStub: Stream<Position>.empty(),
    ) as Stream<Position>;
  }

  @override
  Future<LocationAccuracyStatus> requestTemporaryFullAccuracy({required String purposeKey}) {
     return super.noSuchMethod(
      Invocation.method(#requestTemporaryFullAccuracy, [], {#purposeKey: purposeKey}),
      returnValue: Future.value(LocationAccuracyStatus.reduced),
      returnValueForMissingStub: Future.value(LocationAccuracyStatus.reduced),
    ) as Future<LocationAccuracyStatus>;
  }

  @override
  Future<LocationAccuracyStatus> getLocationAccuracy() {
    return super.noSuchMethod(
      Invocation.method(#getLocationAccuracy, []),
      returnValue: Future.value(LocationAccuracyStatus.reduced),
      returnValueForMissingStub: Future.value(LocationAccuracyStatus.reduced),
    ) as Future<LocationAccuracyStatus>;
  }

  @override
  Future<bool> openAppSettings() {
    return super.noSuchMethod(
      Invocation.method(#openAppSettings, []),
      returnValue: Future.value(false),
      returnValueForMissingStub: Future.value(false),
    ) as Future<bool>;
  }

  @override
  Future<bool> openLocationSettings() {
    return super.noSuchMethod(
      Invocation.method(#openLocationSettings, []),
      returnValue: Future.value(false),
      returnValueForMissingStub: Future.value(false),
    ) as Future<bool>;
  }

  // distanceBetween and bearingBetween are not async, they return double.
  // Mockito's Mock class handles non-async methods by returning a default value (like null for objects, 0 for numbers)
  // if no stub is found. We can provide explicit default return values if needed, but often not necessary
  // unless these methods are called by the code under test and their specific default return matters.
  // For now, we'll rely on Mockito's default for these, or add them if tests fail due to them.
}


void main() {
  late LocationService locationService;
  late MockGeolocatorPlatform mockGeolocatorPlatform;

  setUp(() {
    locationService = LocationService();
    mockGeolocatorPlatform = MockGeolocatorPlatform();
    GeolocatorPlatform.instance = mockGeolocatorPlatform;
  });

  tearDown(() {
    // It's good practice to reset the instance, though in this setup,
    // GeolocatorPlatform.instance is overwritten in each setUp.
    // However, if GeolocatorPlatform held a real instance initially,
    // you'd want to restore it. For these tests, it's less critical.
  });

  group('getCurrentLocation', () {
    final testPosition = Position(
        latitude: 10.0, longitude: 20.0, timestamp: DateTime.now(), accuracy: 0.0,
        altitude: 0.0, altitudeAccuracy: 0.0, heading: 0.0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0);

    test(
        'should return LatLng on success',
        () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      when(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).thenAnswer((_) async => testPosition);

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, isA<Success<LatLng, LocationError>>());
      expect((result as Success).data, LatLng(10.0, 20.0));
      verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
      verify(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).called(1);
    });

    test('should return LocationError.serviceDisabled if service is disabled', () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => false);
      // No other whens needed as isLocationServiceEnabled = false should be the first exit point.

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, const Result<LatLng, LocationError>.failure(LocationError.serviceDisabled));
      verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verifyNever(mockGeolocatorPlatform.checkPermission());
      verifyNever(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      ));
    });

    test('should request permission if denied and return LatLng on success', () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(mockGeolocatorPlatform.requestPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      when(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).thenAnswer((_) async => testPosition);

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, isA<Success<LatLng, LocationError>>());
      expect((result as Success).data, LatLng(10.0, 20.0));
      verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
      verify(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).called(1);
    });

    test('should return LocationError.permissionDenied if permission is denied after request', () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      when(mockGeolocatorPlatform.requestPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, const Result<LatLng, LocationError>.failure(LocationError.permissionDenied));
      verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
      verifyNever(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      ));
    });

    test('should return LocationError.permissionDenied if permission is deniedForever', () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.deniedForever);
      // No requestPermission when as it's deniedForever

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, const Result<LatLng, LocationError>.failure(LocationError.permissionDenied));
      verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
      verifyNever(mockGeolocatorPlatform.requestPermission());
      verifyNever(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      ));
    });

    test('should return LocationError.timeout on TimeoutException', () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      when(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).thenThrow(TimeoutException('Timeout'));

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, const Result<LatLng, LocationError>.failure(LocationError.timeout));
      verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
      verify(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).called(1);
    });

     test('should return LocationError.unknown on other exceptions', () async {
      // Arrange
      when(mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      when(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).thenThrow(Exception('Some other error'));

      // Act
      final result = await locationService.getCurrentLocation();

      // Assert
      expect(result, const Result<LatLng, LocationError>.failure(LocationError.unknown));
       verify(mockGeolocatorPlatform.isLocationServiceEnabled()).called(1);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
      verify(mockGeolocatorPlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      )).called(1);
    });
  });

  group('hasLocationPermission', () {
    test('should return true if permission is LocationPermission.always', () async {
      // Arrange
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      // Act
      final result = await locationService.hasLocationPermission();
      // Assert
      expect(result, isTrue);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
    });

    test('should return true if permission is LocationPermission.whileInUse', () async {
      // Arrange
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      // Act
      final result = await locationService.hasLocationPermission();
      // Assert
      expect(result, isTrue);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
    });

    test('should return false if permission is LocationPermission.denied', () async {
      // Arrange
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      // Act
      final result = await locationService.hasLocationPermission();
      // Assert
      expect(result, isFalse);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
    });

    test('should return false if permission is LocationPermission.deniedForever', () async {
      // Arrange
      when(mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.deniedForever);
      // Act
      final result = await locationService.hasLocationPermission();
      // Assert
      expect(result, isFalse);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
    });

    test('should return false on exception', () async {
      // Arrange
      when(mockGeolocatorPlatform.checkPermission()).thenThrow(Exception('error'));
      // Act
      final result = await locationService.hasLocationPermission();
      // Assert
      expect(result, isFalse);
      verify(mockGeolocatorPlatform.checkPermission()).called(1);
    });
  });

  group('requestLocationPermission', () {
    test('should return true if permission granted with LocationPermission.always', () async {
      // Arrange
      when(mockGeolocatorPlatform.requestPermission())
          .thenAnswer((_) async => LocationPermission.always);
      // Act
      final result = await locationService.requestLocationPermission();
      // Assert
      expect(result, isTrue);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
    });

    test('should return true if permission granted with LocationPermission.whileInUse', () async {
      // Arrange
      when(mockGeolocatorPlatform.requestPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      // Act
      final result = await locationService.requestLocationPermission();
      // Assert
      expect(result, isTrue);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
    });

    test('should return false if permission is LocationPermission.denied', () async {
      // Arrange
      when(mockGeolocatorPlatform.requestPermission())
          .thenAnswer((_) async => LocationPermission.denied);
      // Act
      final result = await locationService.requestLocationPermission();
      // Assert
      expect(result, isFalse);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
    });

    test('should return false if permission is LocationPermission.deniedForever', () async {
      // Arrange
      when(mockGeolocatorPlatform.requestPermission())
          .thenAnswer((_) async => LocationPermission.deniedForever);
      // Act
      final result = await locationService.requestLocationPermission();
      // Assert
      expect(result, isFalse);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
    });

    test('should return false on exception', () async {
      // Arrange
      when(mockGeolocatorPlatform.requestPermission()).thenThrow(Exception('error'));
      // Act
      final result = await locationService.requestLocationPermission();
      // Assert
      expect(result, isFalse);
      verify(mockGeolocatorPlatform.requestPermission()).called(1);
    });
  });
}
