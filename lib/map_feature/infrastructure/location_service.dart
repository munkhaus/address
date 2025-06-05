import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../core/utils/result.dart';
import '../domain/i_location_service.dart';
import '../domain/map_errors.dart';

class LocationService implements ILocationService {
  @override
  Future<Result<LatLng, LocationError>> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const Result.failure(LocationError.serviceDisabled);
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const Result.failure(LocationError.permissionDenied);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return const Result.failure(LocationError.permissionDenied);
      }

      // Get current position with timeout
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return Result.success(LatLng(position.latitude, position.longitude));
    } on TimeoutException {
      return const Result.failure(LocationError.timeout);
    } catch (e) {
      return const Result.failure(LocationError.unknown);
    }
  }

  @override
  Future<bool> hasLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> requestLocationPermission() async {
    try {
      final permission = await Geolocator.requestPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }
} 