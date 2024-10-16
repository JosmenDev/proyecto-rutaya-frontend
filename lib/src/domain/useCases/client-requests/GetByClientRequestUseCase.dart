import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';

class GetByClientRequestUseCase {
  ClientRequestRepository clientRequestRepository;

  GetByClientRequestUseCase(this.clientRequestRepository);

  run(int idClientRequest) =>
      clientRequestRepository.getByClientRequest(idClientRequest);
}
