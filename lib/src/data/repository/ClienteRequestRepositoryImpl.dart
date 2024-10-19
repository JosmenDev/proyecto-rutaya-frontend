import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/ClientRequestService.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class ClienteRequestRepositoryImpl implements ClientRequestRepository {
  ClientRequestService clientRequestService;

  ClienteRequestRepositoryImpl(this.clientRequestService);
  @override
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequests(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  ) {
    return clientRequestService.getTimeAndDistanceClientRequest(
        originLat, originLng, destinationLat, destinationLng);
  }

  @override
  Future<Resource<int>> create(ClientRequest clientRequest) {
    return clientRequestService.create(clientRequest);
  }

  @override
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
      double tarifaRoute) {
    return clientRequestService.updateRouteSelect(
        idClientRequest,
        agencyLongName,
        originStopDescription,
        destinationStopDescription,
        originStopLat,
        originStopLng,
        destStopLat,
        destStopLng,
        distanceRoute,
        timeRoute,
        tarifaRoute);
  }

  @override
  Future<Resource<ClientRequest>> getByClientRequest(int idClientRequest) {
    return clientRequestService.getByClientRequest(idClientRequest);
  }

  @override
  Future<Resource<bool>> updateStatus(
      int idClientRequest, StatusTrip statusTrip) {
    return clientRequestService.updateStatus(idClientRequest, statusTrip);
  }
}
