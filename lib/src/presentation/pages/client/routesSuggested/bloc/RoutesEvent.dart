abstract class RoutesEvent {}

class GetRoutesSuggets extends RoutesEvent {
  final double originLat;
  final double originLng;
  final double destLat;
  final double destLng;

  GetRoutesSuggets({
    required this.originLat,
    required this.originLng,
    required this.destLat,
    required this.destLng,
  });
}

class RouteSelect extends RoutesEvent {
  final int idClientRequest;
  final String agencyLongName;
  final String originStopDescription;
  final String destinationStopDescription;
  final double originStopLat;
  final double originStopLng;
  final double destStopLat;
  final double destStopLng;
  final double distanceRoute;
  final int timeRoute;
  final double tarifaRoute;

  RouteSelect({
    required this.idClientRequest,
    required this.agencyLongName,
    required this.originStopDescription,
    required this.destinationStopDescription,
    required this.originStopLat,
    required this.originStopLng,
    required this.destStopLat,
    required this.destStopLng,
    required this.distanceRoute,
    required this.timeRoute,
    required this.tarifaRoute,
  });
}
