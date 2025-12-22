class AppealModel {
  final String id;
  final String title;
  final String imageUrl;
  final bool isSelected;

  AppealModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isSelected = false,
  });

  AppealModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    bool? isSelected,
  }) {
    return AppealModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

