class Times {
  String tripId;
  String stopSequence;
  String stopId;
  String arrivalTime;
  String departureTime;

  Times({
    required this.tripId,
    required this.stopSequence,
    required this.stopId,
    required this.arrivalTime,
    required this.departureTime,
  });

  factory Times.fromTxt(String line) {
    final parts = line.split(',');

    // Validar que la línea tiene las partes correctas
    if (parts.length != 5) {
      throw FormatException('Línea con formato inválido: $line');
    }

    // Validar las conversiones a entero
    return Times(
      tripId: parts[0].trim(),
      stopSequence: parts[1].trim(),
      stopId: parts[2].trim(),
      arrivalTime: parts[3].trim(),
      departureTime: parts[4].trim(),
    );
  }

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "stop_sequence": stopSequence,
        "stop_id": stopId,
        "arrival_time": arrivalTime,
        "departure_time": departureTime,
      };
}
