import 'package:get_it/get_it.dart';
import '../../map_feature/domain/i_location_service.dart';
import '../../map_feature/infrastructure/location_service.dart';

final getdep = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Infrastructure services
  getdep.registerLazySingleton<ILocationService>(
    () => LocationService(),
  );
} 