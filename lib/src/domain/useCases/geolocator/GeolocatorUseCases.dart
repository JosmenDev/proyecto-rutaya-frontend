import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/CreateMarketUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetMarkerUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPlacemarkDataUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPolylineUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPolylineWalkingUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GetPositionStreamUseCase.dart';

class GeolocatorUseCases {
  FindPositionUseCase findPosition;
  CreateMarketUseCase createMarket;
  GetMarkerUseCase getMarker;
  GetPlacemarkDataUseCase getPlacemarkData;
  GetPolyLineUseCase getPolyLine;
  GetPositionStreamUseCase getPositionStream;
  GetPolyLineWalkingUseCase getPolyLineWalking;

  GeolocatorUseCases({
    required this.findPosition,
    required this.createMarket,
    required this.getMarker,
    required this.getPlacemarkData,
    required this.getPolyLine,
    required this.getPositionStream,
    required this.getPolyLineWalking,
  });
}
