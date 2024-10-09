import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class ClientMapBookingInfoState extends Equatable {
  final Completer<GoogleMapController> controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final bool positionInitialized;
  // Info para solicitar viaje
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  final Resource? responseTimeAndDistance;
  final Resource? responseClientRequest;
  final bool isRequestSubmitted;

  ClientMapBookingInfoState({
    Completer<GoogleMapController>? controller,
    this.position,
    this.cameraPosition = const CameraPosition(
        target: LatLng(-8.1138473, -79.0273625), zoom: 14.0),
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.positionInitialized = false, // Inicializar en falso por defecto
    this.pickUpLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.responseTimeAndDistance,
    this.responseClientRequest,
    this.isRequestSubmitted = false,
  }) : controller = controller ?? Completer<GoogleMapController>();

  ClientMapBookingInfoState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    bool? positionInitialized, // Añadir a copyWith
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Resource? responseTimeAndDistance,
    Resource? responseClientRequest,
    bool? isRequestSubmitted,
  }) {
    return ClientMapBookingInfoState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      positionInitialized: positionInitialized ??
          this.positionInitialized, // Copiar la propiedad
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription:
          destinationDescription ?? this.destinationDescription,
      responseTimeAndDistance:
          responseTimeAndDistance ?? this.responseTimeAndDistance,
      responseClientRequest:
          responseTimeAndDistance ?? this.responseClientRequest,
      isRequestSubmitted: isRequestSubmitted ?? this.isRequestSubmitted,
    );
  }

  @override
  List<Object?> get props => [
        position,
        markers,
        polylines,
        controller,
        positionInitialized,
        cameraPosition,
        pickUpLatLng,
        destinationLatLng,
        pickUpDescription,
        destinationDescription,
        responseTimeAndDistance,
        responseClientRequest,
        isRequestSubmitted,
      ];
}
