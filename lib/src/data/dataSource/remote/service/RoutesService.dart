import 'dart:math';
import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AgencyRoutesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/StopsService.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';
import 'package:indriver_clone_flutter/src/domain/models/Stops.dart';

class RoutesService {
  final AgencyRoutesService agencyRoutesService;
  final StopsService stopsService;

  RoutesService(
    this.agencyRoutesService,
    this.stopsService,
  );

  Future<List<Routes>> getAllRoutes({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    double proximityRadius = 500,
  }) async {
    try {
      // Obtener los datos de las agencias y rutas
      Map<String, String> agencyMap = await agencyRoutesService.readAgencies();
      Map<String, String> routeToAgencyMap =
          await agencyRoutesService.readAgencyRoutes();

      // Cargar el archivo routes.json
      final String jsonString =
          await rootBundle.loadString('assets/routes/routes.json');
      List<Routes> routesList = RoutesFromJson(jsonString);

      // Cargar las paradas de la base de datos desde stops.json
      final Map<String, Stops> stopsMap = await stopsService.getAllStops();

      List<Routes> filteredRoutes = [];

      // Recorrer todas las rutas sugeridas
      for (var route in routesList) {
        String routeId = route.id.toString();
        String routeName = route.name;

        // Obtener el nombre de la agencia para esta ruta
        String? agencyId = routeToAgencyMap[route.id.toString()];
        route.agencyName = agencyId != null
            ? agencyMap[agencyId] ?? 'Nombre no disponible'
            : 'Nombre no disponible';

        bool hasValidOrigin = false;
        bool hasValidDest = false;
        String? closestArrivalTime;
        double? totalDistance;
        String? totalTimeEstimate;

        try {
          // Encontrar la parada más cercana al origen del usuario
          Stops closestOriginStop = _findClosestStop(
              originLat, originLng, stopsMap, route.id.toString());
          double originDistance = calculateDistance(originLat, originLng,
              closestOriginStop.lat, closestOriginStop.lng);

          // Encontrar la parada más cercana al destino del usuario
          Stops closestDestStop =
              _findClosestStop(destLat, destLng, stopsMap, route.id.toString());
          double destDistance = calculateDistance(
              destLat, destLng, closestDestStop.lat, closestDestStop.lng);

          // Validar si el origen y el destino están dentro del radio de proximidad
          if (originDistance <= proximityRadius) {
            hasValidOrigin = true;
            route.originStopLat = closestOriginStop.lat;
            route.originStopLng = closestOriginStop.lng;
          }

          if (destDistance <= proximityRadius) {
            hasValidDest = true;
            route.destStopLat = closestDestStop.lat;
            route.destStopLng = closestDestStop.lng;
          }

          if (hasValidOrigin && hasValidDest) {
            // Calcular la distancia total de la ruta entre origen y destino usando las paradas más cercanas
            totalDistance = await calcularDistanciaTotal(
              originLat: route.originStopLat!,
              originLng: route.originStopLng!,
              destLat: route.destStopLat!,
              destLng: route.destStopLng!,
              routeStops: [
                closestOriginStop,
                closestDestStop
              ], // Lista de las paradas
            );

            // Calcular el tiempo estimado
            totalTimeEstimate = _calcularTiempoEstimado(
              originLat: originLat,
              originLng: originLng,
              destLat: destLat,
              destLng: destLng,
              stopLat: route.originStopLat!,
              stopLng: route.originStopLng!,
              totalDistance: totalDistance ?? 0,
            );

            // Simular la próxima hora de llegada
            closestArrivalTime = _calculateArrivalTime();

            // Agregar la ruta a la lista filtrada
            filteredRoutes.add(Routes(
              id: route.id,
              name: route.name,
              stops: route.stops,
              from: route.from,
              to: route.to,
              connections: route.connections,
              distances: route.distances,
              agencyName: route.agencyName,
              nextArrivalTime: closestArrivalTime ?? 'No disponible',
              distanceToDisplay:
                  totalDistance?.toStringAsFixed(2) ?? 'No disponible',
              totalEstimatedTime: totalTimeEstimate ?? 'No disponible',

              // Nuevos campos
              originStopLat: route.originStopLat,
              originStopLng: route.originStopLng,
              destStopLat: route.destStopLat,
              destStopLng: route.destStopLng,
            ));
          }
        } catch (e) {
          print('Error al procesar la ruta: $e');
        }
      }

      return filteredRoutes.reversed.toList();
    } catch (e) {
      throw Exception('Error al cargar y filtrar las rutas: $e');
    }
  }

  // Método para calcular el tiempo estimado basado en distancia y velocidades aproximadas
  String _calcularTiempoEstimado({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    required double stopLat,
    required double stopLng,
    required double totalDistance,
  }) {
    // Velocidades ajustadas para hacer el cálculo más realista
    double walkingSpeed = 4; // km/h (ajuste a velocidad promedio de caminata)
    double transitSpeed =
        15; // km/h (ajuste a velocidad promedio de transporte público)

    // Distancia desde el origen a la parada más cercana (caminando)
    double walkingToStopDistance =
        calculateDistance(originLat, originLng, stopLat, stopLng) /
            1000; // en km
    double walkingToStopTime =
        walkingToStopDistance / walkingSpeed * 60; // en minutos

    // Distancia en transporte público desde la parada de origen hasta la parada de destino
    double transitDistance = totalDistance / 1000; // en km
    double transitTime = transitDistance / transitSpeed * 60; // en minutos

    // Tiempo total estimado
    double totalTime = walkingToStopTime + transitTime;

    return totalTime.toStringAsFixed(0);
  }

  // Simulación de la próxima hora de llegada basada en el tiempo actual
  String _calculateArrivalTime() {
    final now = DateTime.now();
    int randomMinutes = Random().nextInt(15) + 1; // Genera entre 1 y 15 minutos
    DateTime nextArrival = now.add(Duration(minutes: randomMinutes));

    // Devolver la hora de llegada estimada
    return _formatearHora(nextArrival);
  }

  // Método para encontrar la parada más cercana a una ubicación específica dentro de una ruta específica
  Stops _findClosestStop(
      double lat, double lng, Map<String, Stops> stopsMap, String routeId) {
    double minDistance = double.infinity;
    Stops? closestStop;

    stopsMap.forEach((key, stop) {
      // Revisar si la parada está en la ruta actual
      bool isStopInRoute =
          stop.routes.any((route) => route.route.toString() == routeId);

      if (isStopInRoute) {
        double distance = calculateDistance(lat, lng, stop.lat, stop.lng);
        if (distance < minDistance) {
          minDistance = distance;
          closestStop = stop;
        }
      }
    });

    return closestStop!;
  }

  // Cálculo de la distancia total entre origen y destino utilizando las paradas más cercanas
  Future<double> calcularDistanciaTotal({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    required List<Stops> routeStops,
  }) async {
    double totalDistance = 0.0;

    for (int i = 0; i < routeStops.length - 1; i++) {
      totalDistance += calculateDistance(
        routeStops[i].lat,
        routeStops[i].lng,
        routeStops[i + 1].lat,
        routeStops[i + 1].lng,
      );
    }

    return totalDistance;
  }

  // Cálculo de distancia entre dos puntos geográficos usando la fórmula de Haversine
  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double R = 6371e3; // Radio de la Tierra en metros
    final double phi1 = lat1 * (pi / 180); // Convertir latitud a radianes
    final double phi2 = lat2 * (pi / 180);
    final double deltaPhi = (lat2 - lat1) * (pi / 180);
    final double deltaLambda = (lng2 - lng1) * (pi / 180);

    final double a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final double distance = R * c; // Distancia en metros
    return distance;
  }

  String _formatearHora(DateTime dateTime) {
    // Retorna en formato hh:mm
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
