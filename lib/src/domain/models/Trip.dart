class Trip {
  int tripId;
  int routeId;
  int serviceId;
  int shapeId;

  Trip({
    required this.tripId,
    required this.routeId,
    required this.serviceId,
    required this.shapeId,
  });

  // Método para crear una instancia de `Trip` desde una línea de texto
  factory Trip.fromTxt(String line) {
    final parts = line.split(',');
    return Trip(
      tripId: int.parse(parts[0]),
      routeId: int.parse(parts[1]),
      serviceId: int.parse(parts[2]),
      shapeId: int.parse(parts[3]),
    );
  }

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "route_id": routeId,
        "service_id": serviceId,
        "shape_id": shapeId,
      };
}
