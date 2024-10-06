import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class GetMarkerUseCase {
  GeolocatorRepository geolocatorRepository;
  GetMarkerUseCase(this.geolocatorRepository);
  run(
    String marketId,
    double lat,
    double lng,
    String title,
    String content,
    BitmapDescriptor imageMarket,
  ) =>
      geolocatorRepository.getMarket(
          marketId, lat, lng, title, content, imageMarket);
}
