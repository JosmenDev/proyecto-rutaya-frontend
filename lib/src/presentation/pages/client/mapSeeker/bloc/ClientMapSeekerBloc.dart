import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';

class ClientMapSeekerBloc
    extends Bloc<ClientMapSeekerEvent, ClientMapseekerState> {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  List<ClientMapSeekerEvent> pendingEvents =
      []; // Lista para eventos pendientes

  GeolocatorUseCases geolocatorUseCases;

  ClientMapSeekerBloc(this.geolocatorUseCases)
      : super(ClientMapseekerState(
            controller: Completer<GoogleMapController>())) {
    on<ClientMapSeekerResetEvent>((event, emit) {
      // Reiniciar el estado del controlador y la posición.
      controller = Completer<GoogleMapController>();
      emit(ClientMapseekerState(controller: controller));
    });

    on<ClientMapSeekerInitEvent>((event, emit) {
      emit(state.copyWith(controller: controller));

      for (var pendingEvent in pendingEvents) {
        add(pendingEvent);
      }
      pendingEvents.clear();
    });

    on<FindPosition>((event, emit) async {
      if (!state.controller.isCompleted) {
        pendingEvents.add(event);
        return;
      }

      try {
        Position newPosition = await geolocatorUseCases.findPosition.run();
        if (state.position == null || !state.positionInitialized) {
          add(ChangeMapCameraPosition(
            lat: newPosition.latitude,
            lng: newPosition.longitude,
          ));

          // BitmapDescriptor imageMarker = await geolocatorUseCases.createMarket
          //     .run('assets/img/icon-location-small.png');
          // Marker marker = geolocatorUseCases.getMarker.run(
          //   'MyLocation',
          //   newPosition.latitude,
          //   newPosition.longitude,
          //   'Mi posición',
          //   '',
          //   imageMarker,
          // );

          emit(state.copyWith(
            position: newPosition,
            // markers: {marker.markerId: marker},
            // positionInitialized: true,
          ));

          print('Position Lat: ${newPosition.latitude}');
          print('Position Lng: ${newPosition.longitude}');
        }
      } catch (e) {
        print('Error al obtener la posición o crear el marcador: $e');
      }
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      if (!state.controller.isCompleted) {
        pendingEvents.add(event);
        return;
      }

      try {
        GoogleMapController googleMapController = await state.controller.future;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(event.lat, event.lng),
              zoom: 13,
              bearing: 0,
            ),
          ),
        );
      } catch (e) {
        print('Error al cambiar la posición de la cámara: $e');
      }
    });

    on<OnCameraMove>((event, emit) {
      emit(state.copyWith(
        cameraPosition: event.cameraPosition,
      ));
    });

    on<OnCameraIdle>((event, emit) async {
      PlacemarkData placemarkData =
          await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
      emit(state.copyWith(
        placeMarkData: placemarkData,
      ));
    });

    on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(state.copyWith(
        pickUpLatLng: LatLng(event.lat, event.lng),
        pickUpDescription: event.pickUpDescription,
      ));
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(state.copyWith(
        destinationLatLng: LatLng(event.lat, event.lng),
        destinationDescription: event.destinationDescription,
      ));
    });
  }
}
