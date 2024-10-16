class Trip {
  String tripId;
  String routeId;
  String serviceId;
  String shapeId;

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
      tripId: parts[0],
      routeId: parts[1],
      serviceId: parts[2],
      shapeId: parts[3],
    );
  }

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "route_id": routeId,
        "service_id": serviceId,
        "shape_id": shapeId,
      };
}
