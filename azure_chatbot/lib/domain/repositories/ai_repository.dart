import 'package:azure_chatbot/domain/entities/conversation_history.dart';

abstract class AiRepository {
  Future<String> chat({
    required String message,
    List<ConversationHistory>? conversationHistory,
    String? systemPrompt,
  });
}
