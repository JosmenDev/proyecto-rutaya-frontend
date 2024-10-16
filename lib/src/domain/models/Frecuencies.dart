class Frequencies {
  String tripId;
  String startTime;
  String endTime;
  String headwaySecs;

  Frequencies({
    required this.tripId,
    required this.startTime,
    required this.endTime,
    required this.headwaySecs,
  });

  // Método para crear una instancia de `Frequencies` desde una línea de texto
  factory Frequencies.fromTxt(String line) {
    final parts = line.split(',');
    return Frequencies(
      tripId: parts[0],
      startTime: parts[1],
      endTime: parts[2],
      headwaySecs: parts[3],
    );
  }

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "start_time": startTime,
        "end_time": endTime,
        "headway_secs": headwaySecs,
      };
}
