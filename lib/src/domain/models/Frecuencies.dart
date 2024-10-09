class Frequencies {
  int tripId;
  String startTime;
  String endTime;
  int headwaySecs;

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
      tripId: int.parse(parts[0]),
      startTime: parts[1],
      endTime: parts[2],
      headwaySecs: int.parse(parts[3]),
    );
  }

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "start_time": startTime,
        "end_time": endTime,
        "headway_secs": headwaySecs,
      };
}
