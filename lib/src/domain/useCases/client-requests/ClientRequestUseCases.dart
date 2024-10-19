import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/CreateClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByClientTripsHistoryUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateRouteSelectUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateStatusClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/getTimeAndDistanceUseCase.dart';

class ClientRequestUseCases {
  CreateClientRequestUseCase createClientRequest;
  GetTimeAndDistanceUseCase getTimeAndDistance;
  UpdateRouteSelectUseCase updateRouteSelect;
  GetByClientRequestUseCase getByClientRequest;
  UpdateStatusClientRequestUseCase updateStatusClientRequest;
  GetByClientTripsHistoryUseCase getByClientTripsHistory;

  ClientRequestUseCases({
    required this.getTimeAndDistance,
    required this.createClientRequest,
    required this.updateRouteSelect,
    required this.getByClientRequest,
    required this.updateStatusClientRequest,
    required this.getByClientTripsHistory,
  });
}
