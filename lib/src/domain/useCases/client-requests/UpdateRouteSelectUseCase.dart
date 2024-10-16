import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';

class UpdateRouteSelectUseCase {
  ClientRequestRepository clientRequestRepository;

  UpdateRouteSelectUseCase(this.clientRequestRepository);

  run(
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
    double tarifaRoute,
  ) =>
      clientRequestRepository.updateRouteSelect(
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
        tarifaRoute,
      );
}
