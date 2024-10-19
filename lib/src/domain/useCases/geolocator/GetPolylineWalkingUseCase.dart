import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class GetPolyLineWalkingUseCase {
  GeolocatorRepository geolocatorRepository;

  GetPolyLineWalkingUseCase(this.geolocatorRepository);

  run(LatLng pickUpLatLng, LatLng destinationLatLng) =>
      geolocatorRepository.getPolylineWalking(pickUpLatLng, destinationLatLng);
}
