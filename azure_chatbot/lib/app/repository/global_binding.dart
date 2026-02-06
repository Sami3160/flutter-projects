import 'package:azure_chatbot/data/repositories/ai_repository_impl.dart';
import 'package:azure_chatbot/domain/repositories/ai_repository.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiRepository>(()=>AiRepositoryImpl());
    
  }
}
