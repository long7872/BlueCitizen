/// Public profile and contribution progress for an application user.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.level,
    required this.points,
    this.badges = const [],
  });

  final String id;
  final String name;
  final int level;
  final int points;
  final List<String> badges;

  UserProfile copyWith({
    String? id,
    String? name,
    int? level,
    int? points,
    List<String>? badges,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      points: points ?? this.points,
      badges: List<String>.unmodifiable(badges ?? this.badges),
    );
  }
}
