class Agency {
  final String agencyId;
  final String agencyName;

  Agency({required this.agencyId, this.agencyName = 'Nombre no disponible'});

  factory Agency.fromTxt(String line) {
    final parts = line.split(',');
    return Agency(
      agencyId: parts[0].trim(),
      agencyName: parts.length > 1 ? parts[1].trim() : 'Nombre no disponible',
    );
  }
}
