import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class ClientRequestRepository {
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequests(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  );
}
