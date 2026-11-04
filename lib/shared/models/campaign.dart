/// A fundraising campaign organized by an individual or organization.
class Campaign {
  const Campaign({
    required this.id,
    required this.title,
    required this.organization,
    required this.goalAmount,
    required this.raisedAmount,
  });

  final String id;
  final String title;
  final String organization;
  final double goalAmount;
  final double raisedAmount;

  Campaign copyWith({
    String? id,
    String? title,
    String? organization,
    double? goalAmount,
    double? raisedAmount,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      organization: organization ?? this.organization,
      goalAmount: goalAmount ?? this.goalAmount,
      raisedAmount: raisedAmount ?? this.raisedAmount,
    );
  }
}
