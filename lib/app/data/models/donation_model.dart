enum DonationType { adhoc, roundOff }

class DonationModel {
  final String id;
  final String name;
  final String date;
  final double amount;
  final String iconUrl; // For the colorful icon
  final DonationType type;

  DonationModel({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.iconUrl,
    required this.type,
  });

  DonationModel copyWith({
    String? id,
    String? name,
    String? date,
    double? amount,
    String? iconUrl,
    DonationType? type,
  }) {
    return DonationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      iconUrl: iconUrl ?? this.iconUrl,
      type: type ?? this.type,
    );
  }
}

