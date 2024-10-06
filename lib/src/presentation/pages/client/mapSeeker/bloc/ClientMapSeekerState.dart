import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';

class ClientMapseekerState extends Equatable {
  final Completer<GoogleMapController> controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final PlacemarkData? placemarkData;
  final Map<MarkerId, Marker> markers;
  final bool positionInitialized;
  // Info para solicitar viaje
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;

  ClientMapseekerState({
    Completer<GoogleMapController>? controller,
    this.position,
    this.cameraPosition = const CameraPosition(
        target: LatLng(-8.1138473, -79.0273625), zoom: 14.0),
    this.placemarkData,
    this.markers = const <MarkerId, Marker>{},
    this.positionInitialized = false, // Inicializar en falso por defecto
    this.pickUpLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
  }) : controller = controller ?? Completer<GoogleMapController>();

  ClientMapseekerState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    PlacemarkData? placeMarkData,
    Map<MarkerId, Marker>? markers,
    bool? positionInitialized, // Añadir a copyWith
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
  }) {
    return ClientMapseekerState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      placemarkData: placeMarkData ?? this.placemarkData,
      positionInitialized: positionInitialized ??
          this.positionInitialized, // Copiar la propiedad
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription:
          destinationDescription ?? this.destinationDescription,
    );
  }

  @override
  List<Object?> get props => [
        position,
        markers,
        controller,
        positionInitialized,
        cameraPosition,
        placemarkData,
        pickUpLatLng,
        destinationLatLng,
        pickUpDescription,
        destinationDescription,
      ];
}
