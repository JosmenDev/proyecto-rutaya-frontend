import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class GetPositionStreamUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPositionStreamUseCase(this.geolocatorRepository);

  run() => geolocatorRepository.getPositionStream();

}