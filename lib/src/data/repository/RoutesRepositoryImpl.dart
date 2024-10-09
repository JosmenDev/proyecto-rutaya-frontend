import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/RoutesService.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';
import 'package:indriver_clone_flutter/src/domain/repository/RoutesRepository.dart';

class RoutesRepositoryImpl implements RoutesRepository {
  RoutesService routesService;

  RoutesRepositoryImpl(this.routesService);

  @override
  Future<List<Routes>> getSuggestedRoutes({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    double proximityRadius =
        500, // Radio opcional para considerar una parada cercana
  }) async {
    try {
      // Utiliza el RoutesService para obtener las rutas filtradas
      List<Routes> routesList = await routesService.getAllRoutes(
        originLat: originLat,
        originLng: originLng,
        destLat: destLat,
        destLng: destLng,
        proximityRadius: proximityRadius,
      );
      return routesList;
    } catch (e) {
      // Manejo de errores en caso de que falle la carga
      throw Exception('Error al obtener las rutas sugeridas: $e');
    }
  }
}
