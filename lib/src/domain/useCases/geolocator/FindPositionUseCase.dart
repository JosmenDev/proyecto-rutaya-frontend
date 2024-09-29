import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class FindPositionUseCase {
  GeolocatorRepository geolocatorRepository;

  FindPositionUseCase(this.geolocatorRepository);

  run() => geolocatorRepository.findPosition();
}
