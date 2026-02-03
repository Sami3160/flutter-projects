import 'package:digitomize/domain/entities/user.dart';

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
  User owner;
  String? thumbnailUrl;
  List<String>? likes;
  List<String>? comments;
  List<String>? tags;
  DateTime createdAt;
  DateTime updatedAt;

  factory Blog.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Blog(
        id: '',
        title: '',
        content: '',
        category: '',
        owner: User(id: '0', username: 'Unknown'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    try {
      // Robust Owner Parsing
      User owner;
      final ownerData = json['owner'];
      if (ownerData is Map<String, dynamic>) {
        owner = User.fromJson(ownerData);
      } else if (ownerData is String) {
        owner = User(id: '', username: ownerData);
      } else {
        owner = User(id: '0', username: 'Unknown Owner');
      }

      return Blog(
        id: (json['id'] ?? json['_id'] ?? '').toString(),
        title: (json['title'] ?? '').toString(),
        content: (json['content'] ?? '').toString(),
        category: (json['category'] ?? '').toString(),
        owner: owner,
        thumbnailUrl: json['thumbnailUrl']?.toString() ?? '',
        likes:
            (json['likes'] as List?)?.map((e) => e.toString()).toList() ?? [],
        comments:
            (json['comments'] as List?)?.map((e) => e.toString()).toList() ??
            [],
        tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
    } catch (e) {
      print("❌ Error parsing Blog object: $e");
      print("Problematic JSON: $json");
      // Fallback object to prevent the whole list from failing
      return Blog(
        id: (json['id'] ?? json['_id'] ?? '').toString(),
        title: 'Error loading blog',
        content: '',
        category: '',
        owner: User(id: '0', username: 'Error'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'category': category,
    'owner': owner.toJson(),
    'thumbnailUrl': thumbnailUrl,
    'likes': likes,
    'comments': comments,
    'tags': tags,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
