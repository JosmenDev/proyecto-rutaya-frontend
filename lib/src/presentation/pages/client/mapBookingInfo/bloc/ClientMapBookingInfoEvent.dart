import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ClientMapBookingInfoEvent {}

class ClientMapBookingInfoResetEvent extends ClientMapBookingInfoEvent {}

class ClientMapBookingInfoInitEvent extends ClientMapBookingInfoEvent {
  final LatLng pickUpLatLng;
  final LatLng destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;

  ClientMapBookingInfoInitEvent({
    required this.pickUpLatLng,
    required this.destinationLatLng,
    required this.pickUpDescription,
    required this.destinationDescription,
  });
}

class ChangeMapCameraPosition extends ClientMapBookingInfoEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

class GetTimeAndDistanceValues extends ClientMapBookingInfoEvent {}

class AddPolyline extends ClientMapBookingInfoEvent {}
