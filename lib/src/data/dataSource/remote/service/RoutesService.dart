import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';
import 'package:indriver_clone_flutter/src/domain/models/Stops.dart'; // Importar el modelo de Stops
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AgencyRoutesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/StopsService.dart'; // Importar el servicio de Stops
import 'package:indriver_clone_flutter/src/presentation/utils/CalculateDistance.dart';

class RoutesService {
  final AgencyRoutesService agencyRoutesService;
  final StopsService stopsService;

  // Constructor que acepta los servicios como dependencias
  RoutesService(this.agencyRoutesService, this.stopsService);

  // Método para obtener todas las rutas según la proximidad a las coordenadas de origen y destino
  Future<List<Routes>> getAllRoutes({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    double proximityRadius =
        500, // Radio en metros para considerar una parada cercana
  }) async {
    try {
      // Leer los datos de las agencias y las relaciones entre rutas y agencias
      Map<String, String> agencyMap = await agencyRoutesService.readAgencies();
      Map<String, String> routeToAgencyMap =
          await agencyRoutesService.readAgencyRoutes();

      // Cargar el contenido del archivo JSON de rutas
      final String jsonString =
          await rootBundle.loadString('assets/routes/routes.json');
      List<Routes> routesList = RoutesFromJson(jsonString);

      // Cargar todas las paradas
      final Map<String, Stops> stopsMap = await stopsService.getAllStops();

      // Lista para las rutas filtradas
      List<Routes> filteredRoutes = [];

      for (var route in routesList) {
        // Asignar el nombre de la agencia
        String? agencyId = routeToAgencyMap[route.id.toString()];
        if (agencyId != null) {
          route.agencyName = agencyMap[agencyId] ?? 'Nombre no disponible';
        } else {
          route.agencyName = 'Nombre no disponible';
        }

        // Variables para almacenar si hay una parada cercana al origen y destino
        bool hasOriginStop = false;
        bool hasDestStop = false;

        // Iterar sobre las paradas de la ruta para verificar la cercanía al origen y destino
        for (var stopId in route.stops) {
          Stops? stop = stopsMap[stopId.toString()];

          if (stop != null) {
            // Calcular distancia al origen
            double distanceToOrigin =
                calculateDistance(originLat, originLng, stop.lat, stop.lng);
            if (distanceToOrigin <= proximityRadius) {
              hasOriginStop = true;
            }

            // Calcular distancia al destino
            double distanceToDest =
                calculateDistance(destLat, destLng, stop.lat, stop.lng);
            if (distanceToDest <= proximityRadius) {
              hasDestStop = true;
            }

            // Si ya encontramos paradas cercanas tanto al origen como al destino, salimos del bucle
            if (hasOriginStop && hasDestStop) {
              break;
            }
          }
        }

        // Solo agregar la ruta si tiene paradas cercanas al origen y destino
        if (hasOriginStop && hasDestStop) {
          filteredRoutes.add(route);
        }
      }

      return filteredRoutes;
    } catch (e) {
      // Manejo de errores si ocurre algún problema al leer los archivos
      throw Exception('Error al cargar y filtrar las rutas: $e');
    }
  }
}
