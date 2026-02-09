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

      // API returns: {"response": "...", "status": "success"}
      if (response is Map<String, dynamic>) {
        final aiResponse = response['response'];
        if (aiResponse != null) {
          return aiResponse.toString();
        } else {
          throw Exception('API response missing "response" field');
        }
      } else {
        throw Exception('Unexpected response format: ${response.runtimeType}');
      }
    } catch (e) {
      print("Error in ai_repository_impl.dart ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
