/// A recorded sighting of a marine species.
class SpeciesSighting {
  const SpeciesSighting({
    required this.id,
    required this.speciesName,
    required this.lat,
    required this.lng,
    required this.note,
    required this.createdAt,
  });

  final String id;
  final String speciesName;
  final double lat;
  final double lng;
  final String note;
  final DateTime createdAt;

  SpeciesSighting copyWith({
    String? id,
    String? speciesName,
    double? lat,
    double? lng,
    String? note,
    DateTime? createdAt,
  }) {
    return SpeciesSighting(
      id: id ?? this.id,
      speciesName: speciesName ?? this.speciesName,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
