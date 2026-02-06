import 'package:azure_chatbot/domain/repositories/ai_repository.dart';
import 'package:azure_chatbot/domain/usecase/get_ai_response_usecase.dart';
import 'package:azure_chatbot/presentation/controllers/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetAiResponseUsecase(Get.find<AiRepository>()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find<GetAiResponseUsecase>()));
  }
}
