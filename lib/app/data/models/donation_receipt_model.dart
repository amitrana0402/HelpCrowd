class DonationReceiptModel {
  final String id;
  final String invoiceNumber;
  final String date; // Format: "31/7/18"

  DonationReceiptModel({
    required this.id,
    required this.invoiceNumber,
    required this.date,
  });

  DonationReceiptModel copyWith({
    String? id,
    String? invoiceNumber,
    String? date,
  }) {
    return DonationReceiptModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      date: date ?? this.date,
    );
  }
}

