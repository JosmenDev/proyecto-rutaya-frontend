import 'package:indriver_clone_flutter/src/data/dataSource/remote/service/ClientRequestService.dart';
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
}
