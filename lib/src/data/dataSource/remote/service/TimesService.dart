import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/domain/models/Times.dart';

class TimesService {
  Future<List<Times>> getAllTimes() async {
    final String data =
        await rootBundle.loadString('assets/routes/gtfs/stop_times.txt');
    List<Times> timesList = [];
    final lines = data.split('\n');

    for (var line in lines) {
      if (line.trim().isEmpty || line.startsWith('trip_id')) continue;

      try {
        Times time = Times.fromTxt(line);
        timesList.add(time);

        // Imprimir el stopId para verificar que se están cargando los datos correctos
        print('Cargando stopId: ${time.stopId}');
      } catch (e) {
        print('Error al procesar la línea: $line, Error: $e');
      }
    }

    return timesList;
  }
}
