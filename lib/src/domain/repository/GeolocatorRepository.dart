import 'package:geolocator/geolocator.dart';

abstract class GeolocatorRepository {
  Future<Position> findPosition();
}
