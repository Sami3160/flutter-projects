/// Represents a single message in the conversation history
class ConversationHistory {
  final String role;
  final String content;

  ConversationHistory({required this.role, required this.content});

  /// Create from JSON map
  factory ConversationHistory.fromJson(Map<String, dynamic> json) {
    return ConversationHistory(
      role: json['role'] as String,
      content: json['content'] as String,
    );
  }

  /// Convert to JSON map for API request
  Map<String, dynamic> toJson() {
    return {'role': role, 'content': content};
  }

  /// Helper factory for user messages
  factory ConversationHistory.user(String content) {
    return ConversationHistory(role: 'user', content: content);
  }

  /// Helper factory for assistant messages
  factory ConversationHistory.assistant(String content) {
    return ConversationHistory(role: 'assistant', content: content);
  }

  @override
  String toString() => 'ConversationHistory(role: $role, content: $content)';
}
