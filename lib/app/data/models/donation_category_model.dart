
class DonationCategoryModel {
  final int id;
  final String name;
  final String icon;
  final String? description;
  final int order;
  final bool isPreferred;

  DonationCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    this.description,
    required this.order,
    this.isPreferred = false,
  });

  // Getter for backward compatibility (title -> name)
  String get title => name;

  // Getter for backward compatibility (isSelected -> isPreferred)
  bool get isSelected => isPreferred;


  // Factory constructor from JSON
  factory DonationCategoryModel.fromJson(Map<String, dynamic> json) {
    return DonationCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String?,
      order: json['order'] as int? ?? 0,
      isPreferred: json['is_preferred'] as bool? ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'order': order,
      'is_preferred': isPreferred,
    };
  }

  DonationCategoryModel copyWith({
    int? id,
    String? name,
    String? icon,
    String? description,
    int? order,
    bool? isPreferred,
  }) {
    return DonationCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      order: order ?? this.order,
      isPreferred: isPreferred ?? this.isPreferred,
    );
  }
}
