import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/domain/models/Frecuencies.dart';

class FrequenciesService {
  Future<List<Frequencies>> getAllFrequencies() async {
    final String data =
        await rootBundle.loadString('assets/routes/gtfs/frequencies.txt');
    List<Frequencies> frequenciesList = [];
    final lines = data.split('\n');
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      frequenciesList.add(Frequencies.fromTxt(line));
    }
    return frequenciesList;
  }
}
