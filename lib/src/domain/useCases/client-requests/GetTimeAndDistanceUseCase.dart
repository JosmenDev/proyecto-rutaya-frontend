import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';

class GetTimeAndDistanceUseCase {
  ClientRequestRepository clientRequestRepository;

  GetTimeAndDistanceUseCase(this.clientRequestRepository);

  run(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  ) =>
      clientRequestRepository.getTimeAndDistanceClientRequests(
          originLat, originLng, destinationLat, destinationLng);
}
