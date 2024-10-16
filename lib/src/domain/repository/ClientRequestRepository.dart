import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class ClientRequestRepository {
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequests(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  );

  Future<Resource<int>> create(ClientRequest clientRequest);
  Future<Resource<bool>> updateRouteSelect(
      int idClientRequest,
      String agencyLongName,
      String originStopDescription,
      String destinationStopDescription,
      double originStopLat,
      double originStopLng,
      double destStopLat,
      double destStopLng,
      double distanceRoute,
      int timeRoute,
      double tarifaRoute);

  Future<Resource<ClientRequest>> getByClientRequest(int idClientRequest);
}
