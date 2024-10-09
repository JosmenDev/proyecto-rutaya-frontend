import 'dart:math';

// Función para calcular la distancia entre dos puntos dados en coordenadas de latitud y longitud.
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double R = 6371e3; // Radio de la Tierra en metros
  final double lat1Rad = lat1 * pi / 180;
  final double lat2Rad = lat2 * pi / 180;
  final double deltaLat = (lat2 - lat1) * pi / 180;
  final double deltaLon = (lon1 - lon2) * pi / 180;

  final double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  final double distance = R * c; // Distancia en metros
  return distance;
}
