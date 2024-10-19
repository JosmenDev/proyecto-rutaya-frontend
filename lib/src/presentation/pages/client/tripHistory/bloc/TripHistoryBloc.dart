import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/tripHistory/bloc/TripHistoryState.dart';

class TripHistoryBloc extends Bloc<TripHistoryEvent, TripHistoryState> {
  AuthUseCases authUseCases;
  ClientRequestUseCases clientRequestUseCases;

  TripHistoryBloc(this.clientRequestUseCases, this.authUseCases)
      : super(TripHistoryState()) {
    on<GetHistoryTrip>((event, emit) async {
      emit(state.copyWith(response: Loading()));
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response = await clientRequestUseCases.getByClientTripsHistory
          .run(authResponse.user.id!);
      emit(state.copyWith(response: response));
    });
  }
}
