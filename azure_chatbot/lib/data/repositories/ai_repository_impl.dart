import 'package:azure_chatbot/data/providers/network/apis/ai_api.dart';
import 'package:azure_chatbot/domain/entities/conversation_history.dart';
import 'package:azure_chatbot/domain/repositories/ai_repository.dart';

class AiRepositoryImpl extends AiRepository {
  @override
  Future<String> chat({
    required String message,
    List<ConversationHistory>? conversationHistory,
    String? systemPrompt,
  }) async {
    try {
      final api = AiApi.chat(
        message: message,
        conversationHistory: conversationHistory ?? [],
        systemPrompt: systemPrompt ?? "",
      );
      final response = await api.request();
      return response.toString();
    } catch (e) {
      print("Error in ai_repository_impl.dart ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
