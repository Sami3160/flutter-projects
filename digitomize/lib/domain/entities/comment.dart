import 'package:digitomize/domain/entities/user.dart';

class Comment {
  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  String id;
  String content;
  User author;
  DateTime createdAt;

  factory Comment.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Comment(
        id: '',
        content: '',
        author: User(id: '', username: 'Unknown'),
        createdAt: DateTime.now(),
      );
    }

    // Parse author
    User author;
    final authorData = json['author'];
    if (authorData is Map<String, dynamic>) {
      author = User.fromJson(authorData);
    } else if (authorData is String) {
      author = User(id: authorData, username: 'User');
    } else {
      author = User(id: '', username: 'Unknown');
    }

    return Comment(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      author: author,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'author': author.toJson(),
    'createdAt': createdAt.toIso8601String(),
  };
}
