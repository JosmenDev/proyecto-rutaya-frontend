import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/domain/models/Times.dart';

class TimesService {
  Future<List<Times>> getAllTimes() async {
    final String data =
        await rootBundle.loadString('assets/routes/gtfs/stop_times.txt');
    List<Times> timesList = [];

    final lines = data
        .split('\n')
        .skip(1); // Saltar explícitamente la primera línea (posible encabezado)

    for (var line in lines) {
      line = line.trim();
      print('Línea original: "$line"'); // Depuración adicional
      print('Línea después de trim: "$line"'); // Depuración adicional

      // Saltar líneas vacías
      if (line.isEmpty) {
        print('Línea vacía, se omite.');
        continue;
      }

      try {
        timesList.add(Times.fromTxt(line));
      } catch (e) {
        print('Error al parsear la línea: $line. Detalles del error: $e');
      }
    }
    return timesList;
  }
}
