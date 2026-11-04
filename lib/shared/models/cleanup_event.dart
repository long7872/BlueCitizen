/// A scheduled community cleanup event.
class CleanupEvent {
  const CleanupEvent({
    required this.id,
    required this.title,
    required this.locationName,
    required this.lat,
    required this.lng,
    required this.startsAt,
    required this.capacity,
    required this.joined,
    required this.isJoined,
    this.checklist = const [],
  });

  final String id;
  final String title;
  final String locationName;
  final double lat;
  final double lng;
  final DateTime startsAt;

  /// Maximum number of participants.
  final int capacity;

  /// Number of participants who have joined.
  final int joined;

  /// Whether the current user has joined this event.
  final bool isJoined;

  /// Preparation items or things participants should bring.
  final List<String> checklist;

  CleanupEvent copyWith({
    String? id,
    String? title,
    String? locationName,
    double? lat,
    double? lng,
    DateTime? startsAt,
    int? capacity,
    int? joined,
    bool? isJoined,
    List<String>? checklist,
  }) {
    return CleanupEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      locationName: locationName ?? this.locationName,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      startsAt: startsAt ?? this.startsAt,
      capacity: capacity ?? this.capacity,
      joined: joined ?? this.joined,
      isJoined: isJoined ?? this.isJoined,
      checklist: List<String>.unmodifiable(checklist ?? this.checklist),
    );
  }
}
