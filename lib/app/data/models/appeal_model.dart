class AppealModel {
  final int id;
  final String title;
  final String imageUrl;
  final bool isSelected;
  final bool isFavourite;

  AppealModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isSelected = false,
    this.isFavourite = false,
  });

  AppealModel copyWith({
    int? id,
    String? title,
    String? imageUrl,
    bool? isSelected,
    bool? isFavourite,
  }) {
    return AppealModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  factory AppealModel.fromJson(Map<String, dynamic> json) {
    return AppealModel(
      id: json['id'] as int,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      isSelected: json['is_preferred'] as bool? ?? false,
      isFavourite: json['is_favourite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'is_preferred': isSelected,
      'is_favourite': isFavourite,
    };
  }
}
