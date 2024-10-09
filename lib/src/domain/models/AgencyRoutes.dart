class AgencyRoutes {
  final String routeId;
  final String agencyId;

  AgencyRoutes({required this.routeId, required this.agencyId});

  factory AgencyRoutes.fromTxt(String line) {
    final parts = line.split(',');
    return AgencyRoutes(
      routeId: parts[0].trim(),
      agencyId: parts[1].trim(),
    );
  }
}
