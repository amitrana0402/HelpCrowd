class SettingsMenuItemModel {
  final String id;
  final String title;
  final String? imagePath;
  final String? trailingText;
  final bool showDot;
  final bool isProfileItem;

  SettingsMenuItemModel({
    required this.id,
    required this.title,
    this.imagePath,
    this.trailingText,
    this.showDot = false,
    this.isProfileItem = false,
  });

  SettingsMenuItemModel copyWith({
    String? id,
    String? title,
    String? imagePath,
    String? trailingText,
    bool? showDot,
    bool? isProfileItem,
  }) {
    return SettingsMenuItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      trailingText: trailingText ?? this.trailingText,
      showDot: showDot ?? this.showDot,
      isProfileItem: isProfileItem ?? this.isProfileItem,
    );
  }
}

