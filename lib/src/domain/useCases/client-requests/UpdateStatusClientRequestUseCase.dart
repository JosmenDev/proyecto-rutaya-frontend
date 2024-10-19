import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestRepository.dart';

class UpdateStatusClientRequestUseCase {
  ClientRequestRepository clientRequestRepository;

  UpdateStatusClientRequestUseCase(this.clientRequestRepository);

  run(int idClientRequest, StatusTrip statusTrip) =>
      clientRequestRepository.updateStatus(idClientRequest, statusTrip);
}
