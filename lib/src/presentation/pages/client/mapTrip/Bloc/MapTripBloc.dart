import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/colors/colors.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/Bloc/MapTripState.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

class MapTripBloc extends Bloc<MapTripEvent, MapTripState> {
  BlocSocketIO blocSocketIO;
  ClientRequestUseCases clientRequestUseCases;
  GeolocatorUseCases geolocatorUseCases;
  AuthUseCases authUseCases;
  StreamSubscription? positionSubscription;

  MapTripBloc(this.blocSocketIO, this.clientRequestUseCases,
      this.geolocatorUseCases, this.authUseCases)
      : super(MapTripState()) {
    on<MapTripInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller,
        ),
      );
    });

    on<AddMarketPickup>((event, emit) async {
      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarket
          .run('assets/img/icon-location-small.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        event.lat,
        event.lng,
        'Lugar de origen',
        'Punto de refernecia de origen para los micros',
        pickUpDescriptor,
      );

      emit(
        state.copyWith(
            markers: Map.of(state.markers)
              ..[markerPickUp.markerId] = markerPickUp),
      );
    });

    on<AddMarketStopPickup>((event, emit) async {
      BitmapDescriptor pickUpStopDescriptor = await geolocatorUseCases
          .createMarket
          .run('assets/img/icon-pardada-micro.png');
      Marker markerPickUpStop = geolocatorUseCases.getMarker.run(
        'pickupStop',
        event.lat,
        event.lng,
        'Parada próxima al origen',
        'Punto de refernecia de parada mas cercana al origen',
        pickUpStopDescriptor,
      );

      emit(
        state.copyWith(
            markers: Map.of(state.markers)
              ..[markerPickUpStop.markerId] = markerPickUpStop),
      );
    });

    on<AddMarketStopDestination>((event, emit) async {
      BitmapDescriptor destinationStopDescriptor = await geolocatorUseCases
          .createMarket
          .run('assets/img/icon-pardada-micro.png');
      Marker markerDestinationStop = geolocatorUseCases.getMarker.run(
        'destinationStop',
        event.lat,
        event.lng,
        'Parada próxima al destino',
        'Punto de refernecia de parada mas cercana al destino',
        destinationStopDescriptor,
      );

      emit(
        state.copyWith(
            markers: Map.of(state.markers)
              ..[markerDestinationStop.markerId] = markerDestinationStop),
      );
    });

    on<AddMarketDestination>((event, emit) async {
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases
          .createMarket
          .run('assets/img/icon-retorno.png');
      Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination',
        event.lat,
        event.lng,
        'Punto de destino',
        'Punto de destino del usuario',
        destinationDescriptor,
      );

      emit(
        state.copyWith(
            markers: Map.of(state.markers)
              ..[markerDestination.markerId] = markerDestination),
      );
    });

    on<GetClientRequest>((event, emit) async {
      Resource response = await clientRequestUseCases.getByClientRequest
          .run(event.idClientRequest);
      emit(
        state.copyWith(
          responseGetClientRequest: response,
        ),
      );
      if (response is Success) {
        final data = response.data as ClientRequest;
        emit(state.copyWith(
          idClient: data.idClient,
          destinationLatLng: LatLng(data.pickupStopLat!, data.pickupStopLng!),
          clientRequestResponse: data,
        ));
        add(FindPosition());
        add(AddMarketStopPickup(
          lat: data.pickupStopLat!,
          lng: data.pickupStopLng!,
        ));
        add(AddMarketStopDestination(
          lat: data.destinationStopLat!,
          lng: data.destinationStopLng!,
        ));
        add(AddMarketDestination(
          lat: data.destinationLat!,
          lng: data.destinationLng!,
        ));
      }
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController =
            await state.controller!.future;
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
        print('ChangeMapCameraPosition: $e');
      }
    });

    on<GetTimeAndDistanceValues>((event, emit) async {
      emit(state.copyWith(responseTimeAndDistance: Loading()));
      Resource<TimeAndDistanceValues> response =
          await clientRequestUseCases.getTimeAndDistance.run(
        event.lat,
        event.lng,
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
      );
      emit(state.copyWith(responseTimeAndDistance: response));
    });

    on<AddPolyline>((event, emit) async {
      if (state.position != null) {
        // Obtenemos las coordenadas del origen y destino para la polyline
        List<LatLng> polylineCoordinates =
            await geolocatorUseCases.getPolyLine.run(
          LatLng(event.originLat, event.originLng),
          LatLng(event.destinationLat, event.destinationLng),
        );

        // Creamos un nuevo Polyline con su identificador
        PolylineId id = PolylineId(event.idPolyline);
        Polyline polyline = Polyline(
          polylineId: id,
          color: celeste,
          points: polylineCoordinates,
          width: 6,
        );

        // Actualizamos el estado con las nuevas polylines, manteniendo las anteriores
        emit(
          state.copyWith(
            polylines: Map.of(state.polylines)
              ..[id] =
                  polyline, // Añadimos la nueva polyline a las ya existentes
          ),
        );
      }
    });

    on<AddPolylineWalking>((event, emit) async {
      if (state.position != null) {
        // Obtenemos las coordenadas del origen y destino para la polyline
        List<LatLng> polylineCoordinates =
            await geolocatorUseCases.getPolyLineWalking.run(
          LatLng(event.originLat, event.originLng),
          LatLng(event.destinationLat, event.destinationLng),
        );

        // Creamos un nuevo Polyline con su identificador
        PolylineId id = PolylineId(event.idPolyline);
        Polyline polyline = Polyline(
          polylineId: id,
          color: celeste,
          points: polylineCoordinates,
          width: 4,
        );

        // Actualizamos el estado con las nuevas polylines, manteniendo las anteriores
        emit(
          state.copyWith(
            polylines: Map.of(state.polylines)
              ..[id] =
                  polyline, // Añadimos la nueva polyline a las ya existentes
          ),
        );
      }
    });

    on<FindPosition>((event, emit) async {
      geolocator.Position position =
          await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(
          lat: position.latitude, lng: position.longitude));
      add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));
      Stream<Position> positionStream =
          geolocatorUseCases.getPositionStream.run();
      positionSubscription = positionStream.listen((currentPosition) {
        add(UpdateLocation(position: currentPosition as geolocator.Position));
      });
      add(AddPolylineWalking(
        idPolyline: "Ruta 1",
        originLat: position.latitude,
        originLng: position.longitude,
        destinationLat: state.clientRequestResponse!.pickupStopLat!,
        destinationLng: state.clientRequestResponse!.pickupStopLng!,
      ));
      add(AddPolyline(
        idPolyline: "Ruta 2",
        originLat: state.clientRequestResponse!.pickupStopLat!,
        originLng: state.clientRequestResponse!.pickupStopLng!,
        destinationLat: state.clientRequestResponse!.destinationStopLat!,
        destinationLng: state.clientRequestResponse!.destinationStopLng!,
      ));
      add(AddPolylineWalking(
        idPolyline: "Ruta 3",
        originLat: state.clientRequestResponse!.destinationStopLat!,
        originLng: state.clientRequestResponse!.destinationStopLng!,
        destinationLat: state.clientRequestResponse!.destinationLat!,
        destinationLng: state.clientRequestResponse!.destinationLng!,
      ));
      emit(state.copyWith(
        position: position,
      ));
    });

    on<AddMyPositionMarker>((event, emit) async {
      BitmapDescriptor descriptor =
          await geolocatorUseCases.createMarket.run('assets/img/icon-user.png');
      Marker marker = geolocatorUseCases.getMarker.run(
          'my_location', event.lat, event.lng, 'Mi posicion', '', descriptor);
      emit(state.copyWith(
        markers: Map.of(state.markers)..[marker.markerId] = marker,
      ));
    });

    on<UpdateLocation>((event, emit) async {
      add(AddMyPositionMarker(
          lat: event.position.latitude, lng: event.position.longitude));
      add(ChangeMapCameraPosition(
          lat: event.position.latitude, lng: event.position.longitude));
      emit(state.copyWith(position: event.position));
      add(EmitDriverPositionSocketIO());
    });

    on<StopLocation>((event, emit) {
      positionSubscription?.cancel();
      // add(DeleteLocationData(idDriver: state.idDriver!));
    });

    on<EmitDriverPositionSocketIO>((event, emit) async {
      if (state.idClient != null) {
        blocSocketIO.state.socket?.emit('trip_change_position', {
          'id': state.idClient,
          'lat': state.position!.latitude,
          'lng': state.position!.longitude,
        });
        add(GetTimeAndDistanceValues(
            lat: state.position!.latitude, lng: state.position!.longitude));
      }
    });

    on<ListenTripPosition>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      blocSocketIO.state.socket?.on('trip_new_position/${authResponse.user.id}',
          (data) {
        // print('Nueva posición recibida: $data');
        add(AddMarketPickup(
            lat: data['lat'] as double, lng: data['lng'] as double));
      });
    });

    on<UpdateStatusToFinished>((event, emit) async {
      Resource response = await clientRequestUseCases.updateStatusClientRequest
          .run(event.idClientRequest, StatusTrip.FINISHED);
      if (response is Success) {
        emit(state.copyWith(
          statusTrip: StatusTrip.FINISHED,
        ));
      }
    });
  }
}
