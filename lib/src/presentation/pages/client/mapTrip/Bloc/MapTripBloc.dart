import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripState.dart';

class MapTripBloc extends Bloc<MapTripEvent, MapTripState> {
  ClientRequestUseCases clientRequestUseCases;

  MapTripBloc(this.clientRequestUseCases) : super(MapTripState()) {
    on<GetClientRequest>((event, emit) async {
      Resource<ClientRequest> response = await clientRequestUseCases
          .getByClientRequest
          .run(event.idClientRequest);
      emit(
        state.copyWith(
          responseGetClientRequest: response,
        ),
      );
    });
  }
}
