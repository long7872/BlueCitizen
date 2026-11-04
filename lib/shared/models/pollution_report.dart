import 'severity.dart';

/// Review status of a pollution report.
enum ReportStatus { pending, approved, inProgress, resolved, rejected }

/// Waste categories used by pollution reports.
///
/// This is a proposed baseline taxonomy. The module reviewers should confirm
/// that these values cover the reporting flow before the model contract freezes.
enum WasteType {
  plastic,
  fishingGear,
  metal,
  glass,
  paper,
  organic,
  chemical,
  other,
}

/// A user-submitted environmental pollution report.
class PollutionReport {
  const PollutionReport({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.severity,
    required this.wasteType,
    required this.status,
    this.photoPaths = const [],
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final double lat;
  final double lng;
  final Severity severity;
  final WasteType wasteType;
  final ReportStatus status;
  final List<String> photoPaths;
  final DateTime createdAt;

  PollutionReport copyWith({
    String? id,
    String? title,
    String? description,
    double? lat,
    double? lng,
    Severity? severity,
    WasteType? wasteType,
    ReportStatus? status,
    List<String>? photoPaths,
    DateTime? createdAt,
  }) {
    return PollutionReport(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      severity: severity ?? this.severity,
      wasteType: wasteType ?? this.wasteType,
      status: status ?? this.status,
      photoPaths: List<String>.unmodifiable(photoPaths ?? this.photoPaths),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
