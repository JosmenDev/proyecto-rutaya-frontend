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
