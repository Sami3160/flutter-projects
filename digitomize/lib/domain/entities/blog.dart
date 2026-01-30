class Blog {
  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    this.likes,
    this.comments,
    this.tags,
    this.thumbnailUrl,
  });
  String id;
  String title;
  String content;
  String category;
  String owner;
  String? thumbnailUrl;
  List<String>? likes;
  List<String>? comments;
  List<String>? tags;
  DateTime createdAt;
  DateTime updatedAt;


  factory Blog.fromJson(Map<String, dynamic>? json) {
    return Blog(
      id: json?['id'] as String,
      title: json?['title'] as String,
      content: json?['content'] as String,
      category: json?['category'] as String,
      owner: json?['owner'] as String,
      thumbnailUrl: json?['thumbnailUrl'] as String? ?? '',
      likes: json?['likes'] as List<String>? ?? [],
      comments: json?['comments'] as List<String>? ?? [],
      tags: json?['tags'] as List<String>? ?? [],
      createdAt: json?['createdAt'] as DateTime,
      updatedAt: json?['updatedAt'] as DateTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'title':title,
    'content':content,
    'category':category,
    'owner':owner,
    'thumbnailUrl':thumbnailUrl,
    'likes':likes,
    'comments':comments,
    'tags':tags,
    'createdAt':createdAt,
    'updatedAt':updatedAt,
  };
}