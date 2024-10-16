abstract class MapTripEvent {}

class GetClientRequest extends MapTripEvent {
  final int idClientRequest;

  GetClientRequest({required this.idClientRequest});
}
