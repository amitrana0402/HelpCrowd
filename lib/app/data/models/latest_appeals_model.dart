import 'appeal_model.dart';

class LatestAppealsModel {
  final int id;
  final int charityId;
  final String title;
  final String slug;
  final String? summary;
  final String? description;
  final String? coverImage;
  final String? videoUrl;
  final String? videoThumbnail;
  final String? gallery;
  final String goalAmount;
  final bool donationsEnabled;
  final String donationType;
  final bool termsAccepted;
  final String? shareOptions;
  final String currentAmount;
  final String currency;
  final String status;
  final bool isFeatured;
  final bool isUrgent;
  final String? startDate;
  final String? endDate;
  final int createdBy;
  final String? publishedAt;
  final String? scheduledAt;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int donationsCount;
  final Map<String, dynamic>? charity;
  final Map<String, dynamic>? creator;

  LatestAppealsModel({
    required this.id,
    required this.charityId,
    required this.title,
    required this.slug,
    this.summary,
    this.description,
    this.coverImage,
    this.videoUrl,
    this.videoThumbnail,
    this.gallery,
    required this.goalAmount,
    required this.donationsEnabled,
    required this.donationType,
    required this.termsAccepted,
    this.shareOptions,
    required this.currentAmount,
    required this.currency,
    required this.status,
    required this.isFeatured,
    required this.isUrgent,
    this.startDate,
    this.endDate,
    required this.createdBy,
    this.publishedAt,
    this.scheduledAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.donationsCount,
    this.charity,
    this.creator,
  });

  // Get image URL - prioritize cover_image, then video_thumbnail
  String get imageUrl {
    if (coverImage != null && coverImage!.isNotEmpty) {
      return coverImage!;
    }
    if (videoThumbnail != null && videoThumbnail!.isNotEmpty) {
      return videoThumbnail!;
    }
    return '';
  }

  // Format date for display
  String? get formattedDate {
    if (publishedAt == null) return null;
    try {
      final date = DateTime.parse(publishedAt!);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return null;
    }
  }

  // Convert to AppealModel for compatibility
  AppealModel toAppealModel({bool isSelected = false}) {
    return AppealModel(
      id: id.toString(),
      title: title,
      imageUrl: imageUrl,
      isSelected: isSelected,
    );
  }

  LatestAppealsModel copyWith({
    int? id,
    int? charityId,
    String? title,
    String? slug,
    String? summary,
    String? description,
    String? coverImage,
    String? videoUrl,
    String? videoThumbnail,
    String? gallery,
    String? goalAmount,
    bool? donationsEnabled,
    String? donationType,
    bool? termsAccepted,
    String? shareOptions,
    String? currentAmount,
    String? currency,
    String? status,
    bool? isFeatured,
    bool? isUrgent,
    String? startDate,
    String? endDate,
    int? createdBy,
    String? publishedAt,
    String? scheduledAt,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? donationsCount,
    Map<String, dynamic>? charity,
    Map<String, dynamic>? creator,
  }) {
    return LatestAppealsModel(
      id: id ?? this.id,
      charityId: charityId ?? this.charityId,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      gallery: gallery ?? this.gallery,
      goalAmount: goalAmount ?? this.goalAmount,
      donationsEnabled: donationsEnabled ?? this.donationsEnabled,
      donationType: donationType ?? this.donationType,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      shareOptions: shareOptions ?? this.shareOptions,
      currentAmount: currentAmount ?? this.currentAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      isUrgent: isUrgent ?? this.isUrgent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdBy: createdBy ?? this.createdBy,
      publishedAt: publishedAt ?? this.publishedAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      donationsCount: donationsCount ?? this.donationsCount,
      charity: charity ?? this.charity,
      creator: creator ?? this.creator,
    );
  }

  factory LatestAppealsModel.fromJson(Map<String, dynamic> json) {
    return LatestAppealsModel(
      id: json['id'] as int,
      charityId: json['charity_id'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String,
      summary: json['summary'] as String?,
      description: json['description'] as String?,
      coverImage: json['cover_image'] as String?,
      videoUrl: json['video_url'] as String?,
      videoThumbnail: json['video_thumbnail'] as String?,
      gallery: json['gallery'] as String?,
      goalAmount: json['goal_amount']?.toString() ?? '0.00',
      donationsEnabled: json['donations_enabled'] as bool? ?? true,
      donationType: json['donation_type'] as String? ?? 'any',
      termsAccepted: json['terms_accepted'] as bool? ?? false,
      shareOptions: json['share_options'] as String?,
      currentAmount: json['current_amount']?.toString() ?? '0.00',
      currency: json['currency'] as String? ?? 'AUD',
      status: json['status'] as String? ?? 'active',
      isFeatured: json['is_featured'] as bool? ?? false,
      isUrgent: json['is_urgent'] as bool? ?? false,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      createdBy: json['created_by'] as int,
      publishedAt: json['published_at'] as String?,
      scheduledAt: json['scheduled_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String?,
      donationsCount: json['donations_count'] as int? ?? 0,
      charity: json['charity'] as Map<String, dynamic>?,
      creator: json['creator'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'charity_id': charityId,
      'title': title,
      'slug': slug,
      'summary': summary,
      'description': description,
      'cover_image': coverImage,
      'video_url': videoUrl,
      'video_thumbnail': videoThumbnail,
      'gallery': gallery,
      'goal_amount': goalAmount,
      'donations_enabled': donationsEnabled,
      'donation_type': donationType,
      'terms_accepted': termsAccepted,
      'share_options': shareOptions,
      'current_amount': currentAmount,
      'currency': currency,
      'status': status,
      'is_featured': isFeatured,
      'is_urgent': isUrgent,
      'start_date': startDate,
      'end_date': endDate,
      'created_by': createdBy,
      'published_at': publishedAt,
      'scheduled_at': scheduledAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'donations_count': donationsCount,
      'charity': charity,
      'creator': creator,
    };
  }
}

