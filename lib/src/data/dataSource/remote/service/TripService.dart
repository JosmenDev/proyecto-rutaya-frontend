import 'package:flutter/services.dart';
import 'package:indriver_clone_flutter/src/domain/models/Trip.dart';

class TripService {
  Future<List<Trip>> getAllTrips() async {
    final String data =
        await rootBundle.loadString('assets/routes/gtfs/trips.txt');
    List<Trip> tripList = [];
    final lines = data.split('\n');
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      tripList.add(Trip.fromTxt(line));
    }
    return tripList;
  }
}
