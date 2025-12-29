class NewsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? datePosted;
  final bool isFeatured;
  final bool isTopStory;
  final String? content; // Full article content

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.datePosted,
    this.isFeatured = false,
    this.isTopStory = false,
    this.content,
  });

  NewsModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? datePosted,
    bool? isFeatured,
    bool? isTopStory,
    String? content,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      datePosted: datePosted ?? this.datePosted,
      isFeatured: isFeatured ?? this.isFeatured,
      isTopStory: isTopStory ?? this.isTopStory,
      content: content ?? this.content,
    );
  }
}
