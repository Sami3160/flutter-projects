import 'package:azure_chatbot/app/services/speech_service.dart';
import 'package:azure_chatbot/app/services/tts_service.dart';
import 'package:azure_chatbot/data/repositories/ai_repository_impl.dart';
import 'package:azure_chatbot/domain/repositories/ai_repository.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Register services
    Get.put<TtsService>(TtsService(), permanent: true);
    Get.put<SpeechService>(SpeechService(), permanent: true);

    // Register repositories
    Get.lazyPut<AiRepository>(() => AiRepositoryImpl());
  }
}
