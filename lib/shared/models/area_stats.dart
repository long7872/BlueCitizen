/// Aggregated environmental statistics for a monitored area.
class AreaStats {
  const AreaStats({
    required this.id,
    required this.name,
    required this.wasteKg,
    required this.reportCount,
    required this.cleanScore,
  });

  final String id;
  final String name;
  final double wasteKg;
  final int reportCount;
  final double cleanScore;

  AreaStats copyWith({
    String? id,
    String? name,
    double? wasteKg,
    int? reportCount,
    double? cleanScore,
  }) {
    return AreaStats(
      id: id ?? this.id,
      name: name ?? this.name,
      wasteKg: wasteKg ?? this.wasteKg,
      reportCount: reportCount ?? this.reportCount,
      cleanScore: cleanScore ?? this.cleanScore,
    );
  }
}
