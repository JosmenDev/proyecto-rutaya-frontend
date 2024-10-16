import 'dart:math';
import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/AgencyRoutesService.dart';
import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/StopsService.dart';
import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';
import 'package:indriver_clone_flutter/src/domain/models/Stops.dart';
import 'package:indriver_clone_flutter/src/domain/models/GeoRoutes.dart'; // Modelo para el geojson

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

      final Map<String, Stops> stopsMap = await stopsService.getAllStops();

      List<Routes> filteredRoutes = [];

      // Recorrer todas las rutas sugeridas
      for (var route in routesList) {
        String routeId = route.id.toString();
        String routeName = route.name;
        List<dynamic> stops = route.stops;

        // Obtener el nombre de la agencia para esta ruta
        String? agencyId = routeToAgencyMap[route.id.toString()];
        route.agencyName = agencyId != null
            ? agencyMap[agencyId] ?? 'Nombre no disponible'
            : 'Nombre no disponible';

        bool hasOriginStop = false;
        bool hasDestStop = false;
        String? closestArrivalTime;
        double? totalDistance;
        String? totalTimeEstimate;

        // Recorrer las paradas de la ruta
        for (var stopId in route.stops) {
          Stops? stop = stopsMap[stopId.toString()];

          if (stop != null) {
            double distanceToOrigin =
                calculateDistance(originLat, originLng, stop.lat, stop.lng);

            if (distanceToOrigin <= proximityRadius) {
              hasOriginStop = true;
              // Aquí llenamos la descripción y coordenadas de la parada de origen
              route.originStopLat = stop.lat;
              route.originStopLng = stop.lng;

              // Calcular la próxima llegada simulada
              String geojsonPath = 'assets/routes/geo/$routeId.geojson';
              try {
                String geojsonString = await rootBundle.loadString(geojsonPath);
                closestArrivalTime = await _findNextArrivalTimeFromGeoJson(
                  geojsonString: geojsonString,
                );

                // Calcular la distancia total en la ruta
                totalDistance = await calcularDistanciaTotal(
                  originLat: originLat,
                  originLng: originLng,
                  destLat: destLat,
                  destLng: destLng,
                  routeCoordinates: geoRoutesFromJson(geojsonString)
                      .features[0]
                      .geometry
                      .coordinates,
                );

                // Calcular el tiempo estimado total
                totalTimeEstimate = _calcularTiempoEstimado(
                  originLat: originLat,
                  originLng: originLng,
                  destLat: destLat,
                  destLng: destLng,
                  stopLat: stop.lat,
                  stopLng: stop.lng,
                  totalDistance: totalDistance ?? 0,
                );
              } catch (e) {
                print('No se pudo cargar el archivo $geojsonPath: $e');
              }
            }

            double distanceToDest =
                calculateDistance(destLat, destLng, stop.lat, stop.lng);
            if (distanceToDest <= proximityRadius) {
              hasDestStop = true;

              // Aquí llenamos la descripción y coordenadas de la parada de destino
              // route.destinationStopDescription = stop.description;
              route.destStopLat = stop.lat;
              route.destStopLng = stop.lng;
            }

            if (hasOriginStop && hasDestStop) {
              break;
            }
          }
        }

        if (hasOriginStop && hasDestStop) {
          // Actualizamos la ruta con los datos de agencia y la próxima llegada
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
      }

      return filteredRoutes;
    } catch (e) {
      // print('Error in getAllRoutes: $e');
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
    // Velocidades aproximadas
    double walkingSpeed = 5; // km/h
    double transitSpeed = 20; // km/h

    // Distancia desde el origen a la parada más cercana (caminando)
    double walkingToStopDistance =
        calculateDistance(originLat, originLng, stopLat, stopLng) /
            1000; // en km
    double walkingToStopTime =
        walkingToStopDistance / walkingSpeed * 60; // en minutos

    // Distancia en transporte público desde la parada de origen hasta la parada de destino
    double transitDistance = totalDistance / 1000; // en km
    double transitTime = transitDistance / transitSpeed * 60; // en minutos

    // Distancia desde la parada de destino hasta el destino final (caminando)
    // double walkingToDestDistance = calculateDistance(stopLat, stopLng, destLat, destLng) / 1000; // en km
    // double walkingToDestTime = walkingToDestDistance / walkingSpeed * 60; // en minutos

    // Tiempo total estimado
    double totalTime = walkingToStopTime + transitTime;

    return totalTime.toStringAsFixed(0);
  }

  // Método para encontrar la próxima hora de llegada basándose en el archivo .geojson
  Future<String?> _findNextArrivalTimeFromGeoJson({
    required String geojsonString,
  }) async {
    try {
      // Cargar el archivo .geojson
      final geojson = geoRoutesFromJson(geojsonString);

      // Extraer las propiedades necesarias del archivo .geojson
      String openingHours = geojson.features[0].properties.openingHours;

      // Llamar a la función que realiza el cálculo del tiempo de llegada aproximado
      return _calculateArrivalTime(
        openingHours: openingHours,
      );
    } catch (e) {
      // print('Error al calcular la hora de llegada desde geojson: $e');
      return null;
    }
  }

  // Función para calcular la hora de llegada simulada
  String? _calculateArrivalTime({
    required String openingHours,
  }) {
    // Hora actual en la zona horaria de Perú (UTC-5)
    final now = DateTime.now().toUtc().subtract(Duration(hours: 5));

    // Parsear el horario de apertura y cierre en la hora de Perú
    DateTime startTime = _parseTimeFromOpeningHours(openingHours, 'start')
        .toUtc()
        .subtract(Duration(hours: 5));
    DateTime endTime = _parseTimeFromOpeningHours(openingHours, 'end')
        .toUtc()
        .subtract(Duration(hours: 5));

    // print('Horario de apertura (hora Perú): $startTime');
    // print('Horario de cierre (hora Perú): $endTime');
    // print('Hora actual (hora Perú): $now');

    // Verificar si la hora actual está antes del inicio del servicio
    if (now.isBefore(startTime)) {
      // print('La hora actual está antes del inicio del servicio');
      return 'Fuera de servicio';
    }

    // Si la hora está después del cierre del servicio, forzamos una llegada simulada
    if (now.isAfter(endTime)) {
      // print(
      // 'La hora actual está después del cierre del servicio, forzando llegada simulada');
      DateTime simulatedArrival = now.add(Duration(minutes: 15));
      return simulatedArrival.toIso8601String(); // Simulamos la llegada
    }

    // Si está dentro del horario de servicio, generamos un tiempo de llegada entre 1 y 15 minutos
    int randomMinutes = Random().nextInt(15) + 1; // Genera entre 1 y 15 minutos
    DateTime nextArrival = now.add(Duration(minutes: randomMinutes));

    // print('Hora estimada de llegada: $nextArrival');
    return _formatearHora(
        nextArrival); // Devolvemos la hora de llegada simulada
  }

  Future<double> calcularDistanciaTotal({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    required List<List<double>> routeCoordinates,
  }) async {
    double totalDistance = 0.0;

    // Encontrar las coordenadas más cercanas al origen y destino
    int closestIndexToOrigin =
        _findClosestCoordinateIndex(originLat, originLng, routeCoordinates);
    int closestIndexToDest =
        _findClosestCoordinateIndex(destLat, destLng, routeCoordinates);

    // Si el índice del origen es mayor que el del destino, intercambiar
    if (closestIndexToOrigin > closestIndexToDest) {
      int temp = closestIndexToOrigin;
      closestIndexToOrigin = closestIndexToDest;
      closestIndexToDest = temp;
    }

    // Calcular la distancia total entre el origen y el destino pasando por las paradas
    for (int i = closestIndexToOrigin; i < closestIndexToDest; i++) {
      double lat1 = routeCoordinates[i][1];
      double lng1 = routeCoordinates[i][0];
      double lat2 = routeCoordinates[i + 1][1];
      double lng2 = routeCoordinates[i + 1][0];
      totalDistance += calculateDistance(lat1, lng1, lat2, lng2);
    }

    return totalDistance;
  }

  // Función que encuentra la coordenada más cercana
  int _findClosestCoordinateIndex(
      double originLat, double originLng, List<List<double>> coordinates) {
    double minDistance = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < coordinates.length; i++) {
      double coordLat = coordinates[i][1];
      double coordLng = coordinates[i][0];
      double distance =
          calculateDistance(originLat, originLng, coordLat, coordLng);

      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  // Parsear horario de apertura y cierre
  DateTime _parseTimeFromOpeningHours(String openingHours, String type) {
    final timeRange = openingHours.split(' ')[1];
    final startEnd = timeRange.split('-');
    final selectedTime = (type == 'start') ? startEnd[0] : startEnd[1];

    final now = DateTime.now();
    return DateTime.parse(
        "${now.toIso8601String().split('T').first}T$selectedTime:00");
  }

  // Cálculo de distancia entre dos puntos geográficos usando fórmula haversine
  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double R = 6371e3; // Radio de la Tierra en metros
    final double phi1 = lat1 * (3.14159 / 180); // φ, λ en radianes
    final double phi2 = lat2 * (3.14159 / 180);
    final double deltaPhi = (lat2 - lat1) * (3.14159 / 180);
    final double deltaLambda = (lng2 - lng1) * (3.14159 / 180);

    final double a = (sin(deltaPhi / 2) * sin(deltaPhi / 2)) +
        (cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2));
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final double distance = R * c; // En metros
    return distance;
  }

  String _formatearHora(DateTime dateTime) {
    // Retorna en formato hh:mm
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
