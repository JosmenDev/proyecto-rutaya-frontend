import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';

class ClientMapBookingInfoBloc
    extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  List<ClientMapBookingInfoEvent> pendingEvents =
      []; // Lista para eventos pendientes

  GeolocatorUseCases geolocatorUseCases;
  ClientRequestUseCases clientRequestUseCases;

  ClientMapBookingInfoBloc(this.geolocatorUseCases, this.clientRequestUseCases)
      : super(ClientMapBookingInfoState(
            controller: Completer<GoogleMapController>())) {
    on<ClientMapBookingInfoResetEvent>((event, emit) {
      // Reiniciar el estado del controlador y la posición.
    });

    on<ClientMapBookingInfoInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          pickUpLatLng: event.pickUpLatLng,
          destinationLatLng: event.destinationLatLng,
          pickUpDescription: event.pickUpDescription,
          destinationDescription: event.destinationDescription,
          controller: controller,
        ),
      );

      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarket
          .run('assets/img/icon-location-small.png');
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases
          .createMarket
          .run('assets/img/icon-retorno.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        'Lugar de origen',
        'Punto de refernecia de origen para los micros',
        pickUpDescriptor,
      );
      Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        'Lugar de destino',
        'Punto de refernecia de origen para los micros',
        destinationDescriptor,
      );

      emit(
        state.copyWith(markers: {
          markerPickUp.markerId: markerPickUp,
          markerDestination.markerId: markerDestination,
        }),
      );

      for (var pendingEvent in pendingEvents) {
        add(pendingEvent);
      }
      pendingEvents.clear();
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

    on<GetTimeAndDistanceValues>((event, emit) async {
      emit(state.copyWith(responseTimeAndDistance: Loading()));
      Resource<TimeAndDistanceValues> response =
          await clientRequestUseCases.getTimeAndDistance.run(
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
      );
      emit(state.copyWith(responseTimeAndDistance: response));
    });

    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyLine
          .run(state.pickUpLatLng!, state.destinationLatLng!);
      PolylineId id = PolylineId("MyRoute");
      Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.purple,
          points: polylineCoordinates,
          width: 6);
      emit(state.copyWith(
        polylines: {
          id: polyline,
        },
      ));
    });
  }
}
