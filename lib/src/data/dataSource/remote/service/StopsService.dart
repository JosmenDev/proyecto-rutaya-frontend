import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/domain/models/Stops.dart';

class StopsService {
  // Método para cargar las paradas desde el archivo JSON
  Future<Map<String, Stops>> getAllStops() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/routes/stops.json');
      final Map<String, Stops> stopsMap = StopsFromJson(jsonString);
      return stopsMap;
    } catch (e) {
      throw Exception('Error al cargar las paradas: $e');
    }
  }
}
