import 'package:indriver_clone_flutter/src/domain/repository/RoutesRepository.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';

class GetRoutesSuggestedUseCase {
  RoutesRepository routesRepository;

  GetRoutesSuggestedUseCase(this.routesRepository);

  Future<List<Routes>> run({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    double proximityRadius = 500,
  }) {
    return routesRepository.getSuggestedRoutes(
      originLat: originLat,
      originLng: originLng,
      destLat: destLat,
      destLng: destLng,
      proximityRadius: proximityRadius,
    );
  }
}
