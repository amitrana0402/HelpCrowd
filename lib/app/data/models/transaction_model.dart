class TransactionModel {
  final String id;
  final String name;
  final String date;
  final double amount;
  final double donationAmount;
  final String iconType; // 'spreadsheet', 'house', 'theater', 'wine', etc.
  final String iconColor; // 'red', 'green', 'purple', 'blue', etc.

  TransactionModel({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.donationAmount,
    required this.iconType,
    required this.iconColor,
  });

  TransactionModel copyWith({
    String? id,
    String? name,
    String? date,
    double? amount,
    double? donationAmount,
    String? iconType,
    String? iconColor,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      donationAmount: donationAmount ?? this.donationAmount,
      iconType: iconType ?? this.iconType,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}

