class Times {
  int tripId;
  int stopSequence;
  int stopId;
  String arrivalTime;
  String departureTime;

  Times({
    required this.tripId,
    required this.stopSequence,
    required this.stopId,
    required this.arrivalTime,
    required this.departureTime,
  });

  // Método para crear una instancia de `Times` desde una línea de texto
  factory Times.fromTxt(String line) {
    final parts = line.split(',');

    // Validar que la línea tiene la cantidad de partes necesarias
    if (parts.length < 5) {
      throw FormatException('Línea con formato inválido: $line');
    }

    // Verificar si la línea es un encabezado y lanzarlo como excepción
    if (parts[0].toLowerCase().contains('trip_id')) {
      throw FormatException('Línea de encabezado encontrada: $line');
    }

    try {
      // Parsear las partes numéricas
      final tripId = int.parse(parts[0].trim());
      final stopSequence = int.parse(parts[1].trim());
      final stopId = int.parse(parts[2].trim());

      // Mantener los tiempos como cadenas de texto
      final arrivalTime = parts[3].trim();
      final departureTime = parts[4].trim();

      return Times(
        tripId: tripId,
        stopSequence: stopSequence,
        stopId: stopId,
        arrivalTime: arrivalTime,
        departureTime: departureTime,
      );
    } catch (e) {
      throw FormatException(
          'Error al parsear la línea: $line. Detalles del error: $e');
    }
  }

  // Método para convertir `Times` a JSON (si es necesario)
  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "stop_sequence": stopSequence,
        "stop_id": stopId,
        "arrival_time": arrivalTime,
        "departure_time": departureTime,
      };
}
