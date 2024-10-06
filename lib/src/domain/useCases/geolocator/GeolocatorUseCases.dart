import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetMarkerUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPlacemarkDataUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPolylineUseCase.dart';

class GeolocatorUseCases {
  FindPositionUseCase findPosition;
  CreateMarketUseCase createMarket;
  GetMarkerUseCase getMarker;
  GetPlacemarkDataUseCase getPlacemarkData;
  GetPolyLineUseCase getPolyLine;

  GeolocatorUseCases({
    required this.findPosition,
    required this.createMarket,
    required this.getMarker,
    required this.getPlacemarkData,
    required this.getPolyLine,
  });
}
