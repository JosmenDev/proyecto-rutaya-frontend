import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/CreateClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/getTimeAndDistanceUseCase.dart';

class ClientRequestUseCases {
  CreateClientRequestUseCase createClientRequest;
  GetTimeAndDistanceUseCase getTimeAndDistance;

  ClientRequestUseCases({
    required this.getTimeAndDistance,
    required this.createClientRequest,
  });
}
