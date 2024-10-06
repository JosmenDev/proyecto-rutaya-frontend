import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class CreateMarketUseCase {
  GeolocatorRepository geolocatorRepository;
  CreateMarketUseCase(this.geolocatorRepository);

  run(String path) => geolocatorRepository.createMarketFromAsset(path);
}
