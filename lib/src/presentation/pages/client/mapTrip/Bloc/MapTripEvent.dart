import 'package:geolocator/geolocator.dart';

abstract class MapTripEvent {}

class MapTripInitEvent extends MapTripEvent {}

class GetClientRequest extends MapTripEvent {
  final int idClientRequest;

  GetClientRequest({required this.idClientRequest});
}

class GetTimeAndDistanceValues extends MapTripEvent {
  final double lat;
  final double lng;

  GetTimeAndDistanceValues({required this.lat, required this.lng});
}

class AddPolyline extends MapTripEvent {
  final String idPolyline;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;

  AddPolyline(
      {required this.idPolyline,
      required this.originLat,
      required this.originLng,
      required this.destinationLat,
      required this.destinationLng});
}

class AddPolylineWalking extends MapTripEvent {
  final String idPolyline;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;

  AddPolylineWalking(
      {required this.idPolyline,
      required this.originLat,
      required this.originLng,
      required this.destinationLat,
      required this.destinationLng});
}

class ChangeMapCameraPosition extends MapTripEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

class AddMarketPickup extends MapTripEvent {
  final double lat;
  final double lng;
  AddMarketPickup({
    required this.lat,
    required this.lng,
  });
}

class AddMarketStopPickup extends MapTripEvent {
  final double lat;
  final double lng;
  AddMarketStopPickup({
    required this.lat,
    required this.lng,
  });
}

class AddMarketStopDestination extends MapTripEvent {
  final double lat;
  final double lng;
  AddMarketStopDestination({
    required this.lat,
    required this.lng,
  });
}

class AddMarketDestination extends MapTripEvent {
  final double lat;
  final double lng;
  AddMarketDestination({
    required this.lat,
    required this.lng,
  });
}

class ListenTripPosition extends MapTripEvent {}

// Eventos de posicion
class FindPosition extends MapTripEvent {}

class UpdateLocation extends MapTripEvent {
  final Position position;
  UpdateLocation({required this.position});
}

class StopLocation extends MapTripEvent {}

class AddMyPositionMarker extends MapTripEvent {
  final double lat;
  final double lng;
  AddMyPositionMarker({required this.lat, required this.lng});
}

class EmitDriverPositionSocketIO extends MapTripEvent {}

class UpdateStatusToFinished extends MapTripEvent {
  final int idClientRequest;
  UpdateStatusToFinished({required this.idClientRequest});
}
