import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';

class GetByClientTripsHistoryUseCase {
  ClientRequestRepository clientRequestRepository;

  GetByClientTripsHistoryUseCase(this.clientRequestRepository);

  run(int idClient) =>
      clientRequestRepository.getByClientTripsHistory(idClient);
}
