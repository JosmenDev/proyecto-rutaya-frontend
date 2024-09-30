import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';

class ClientMapSeekerBloc
    extends Bloc<ClientMapSeekerEvent, ClientMapseekerState> {
  GeolocatorUseCases geolocatorUseCases;
  ClientMapSeekerBloc(this.geolocatorUseCases) : super(ClientMapseekerState()) {
    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      emit(state.copyWith(
        position: position,
      ));
      print('Position Lat: ${position.latitude}');
      print('Position Lng: ${position.longitude}');
    });
  }
}
