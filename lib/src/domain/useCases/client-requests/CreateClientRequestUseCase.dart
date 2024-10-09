import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';

class CreateClientRequestUseCase {
  ClientRequestRepository clientRequestRepository;

  CreateClientRequestUseCase(this.clientRequestRepository);

  run(ClientRequest clientRequest) =>
      clientRequestRepository.create(clientRequest);
}
