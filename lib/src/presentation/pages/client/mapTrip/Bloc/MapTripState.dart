import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class MapTripState extends Equatable {
  final Resource? responseGetClientRequest;
  final Completer<GoogleMapController>? controller;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final Resource? responseTimeAndDistance;
  final Position? position;
  final int? idClient;
  final LatLng? destinationLatLng;
  final StatusTrip? statusTrip;
  final ClientRequest? clientRequestResponse;

  MapTripState({
    this.responseGetClientRequest,
    this.controller,
    this.cameraPosition = const CameraPosition(
        target: LatLng(-8.1138473, -79.0273625), zoom: 14.0),
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.responseTimeAndDistance,
    this.position,
    this.idClient,
    this.destinationLatLng,
    this.statusTrip,
    this.clientRequestResponse,
  });

  MapTripState copyWith({
    Resource? responseGetClientRequest,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    Resource? responseTimeAndDistance,
    Position? position,
    int? idClient,
    LatLng? destinationLatLng,
    StatusTrip? statusTrip,
    ClientRequest? clientRequestResponse,
  }) {
    return MapTripState(
      responseGetClientRequest:
          responseGetClientRequest ?? this.responseGetClientRequest,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      responseTimeAndDistance: responseTimeAndDistance,
      position: position ?? this.position,
      idClient: idClient ?? this.idClient,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      statusTrip: statusTrip ?? this.statusTrip,
      clientRequestResponse:
          clientRequestResponse ?? this.clientRequestResponse,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        destinationLatLng,
        idClient,
        responseGetClientRequest,
        responseTimeAndDistance,
        controller,
        markers,
        polylines,
        cameraPosition,
        position,
        statusTrip,
        clientRequestResponse,
      ];
}
