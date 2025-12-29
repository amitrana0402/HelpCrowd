enum ActivityIconType { image, globe, australiaMap }

class ActivityModel {
  final String id;
  final String description;
  final String timestamp;
  final ActivityIconType iconType;
  final String? imageUrl; // For image type icons

  ActivityModel({
    required this.id,
    required this.description,
    required this.timestamp,
    required this.iconType,
    this.imageUrl,
  });

  ActivityModel copyWith({
    String? id,
    String? description,
    String? timestamp,
    ActivityIconType? iconType,
    String? imageUrl,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      iconType: iconType ?? this.iconType,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

