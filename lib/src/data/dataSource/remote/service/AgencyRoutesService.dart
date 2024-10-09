import 'package:flutter/services.dart' show rootBundle;
import 'package:indriver_clone_flutter/src/domain/models/Agency.dart';
import 'package:indriver_clone_flutter/src/domain/models/AgencyRoutes.dart';

class AgencyRoutesService {
  Future<Map<String, String>> readAgencies() async {
    final String data =
        await rootBundle.loadString('assets/routes/gtfs/agency.txt');
    Map<String, String> agencyMap = {};

    final lines = data.split('\n');
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      Agency agency = Agency.fromTxt(line);
      agencyMap[agency.agencyId] = agency.agencyName;
    }
    return agencyMap;
  }

  Future<Map<String, String>> readAgencyRoutes() async {
    final String data =
        await rootBundle.loadString('assets/routes/gtfs/routes.txt');
    Map<String, String> routeToAgencyMap = {};

    final lines = data.split('\n');
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      AgencyRoutes agencyRoute = AgencyRoutes.fromTxt(line);
      routeToAgencyMap[agencyRoute.routeId] = agencyRoute.agencyId;
    }
    return routeToAgencyMap;
  }
}
