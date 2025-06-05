import 'package:get_it/get_it.dart';
import '../../map_feature/domain/i_location_service.dart';
import '../../map_feature/domain/i_address_service.dart';
import '../../map_feature/infrastructure/location_service.dart';
import '../../map_feature/infrastructure/nominatim_service.dart';

final getdep = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Infrastructure services
  getdep.registerLazySingleton<ILocationService>(
    () => LocationService(),
  );
  
  getdep.registerLazySingleton<IAddressService>(
    () => NominatimService(),
  );
} 