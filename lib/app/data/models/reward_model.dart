class RewardModel {
  final String id;
  final String title;
  final String subtitle;
  final String? price;
  final String? finePrint;
  final RewardType type;
  final String backgroundColor; // Hex color or color name
  final String? imageUrl;
  final String? logoText;

  RewardModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.price,
    this.finePrint,
    required this.type,
    required this.backgroundColor,
    this.imageUrl,
    this.logoText,
  });

  RewardModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? price,
    String? finePrint,
    RewardType? type,
    String? backgroundColor,
    String? imageUrl,
    String? logoText,
  }) {
    return RewardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      finePrint: finePrint ?? this.finePrint,
      type: type ?? this.type,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      imageUrl: imageUrl ?? this.imageUrl,
      logoText: logoText ?? this.logoText,
    );
  }
}

enum RewardType {
  starbucks,
  mcdonalds,
  eventCinemas,
}

