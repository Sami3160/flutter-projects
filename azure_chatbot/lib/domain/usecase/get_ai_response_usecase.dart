import 'package:azure_chatbot/app/usecases/pram_usecase.dart';
import 'package:azure_chatbot/domain/entities/conversation_history.dart';
import 'package:azure_chatbot/domain/repositories/ai_repository.dart';

class GetAiResponseUsecase extends ParamUseCase<String, GetAiResponseParams> {
  final AiRepository _repo;
  GetAiResponseUsecase(this._repo);
  @override
  Future<String> execute(GetAiResponseParams params) {
    return _repo.chat(
      message: params.message,
      conversationHistory: params.conversation_history,
      systemPrompt: params.system_prompt,
    );
  }
}

class GetAiResponseParams {
  final String message;
  final List<ConversationHistory>? conversation_history;
  final String? system_prompt;
  GetAiResponseParams({
    required this.message,
    this.conversation_history,
    this.system_prompt,
  });
}
