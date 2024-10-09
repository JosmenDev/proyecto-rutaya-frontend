import 'package:indriver_clone_flutter/src/domain/models/Routes.dart';

abstract class RoutesRepository {
  Future<List<Routes>> getSuggestedRoutes({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    double proximityRadius,
  });
}
