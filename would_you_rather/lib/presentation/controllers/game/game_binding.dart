import 'package:get/get.dart';
import 'game_controller.dart';
import '../../../domain/usecases/get_questions_use_case.dart';
import '../../../domain/usecases/submit_answer_use_case.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => GameController(
        GetQuestionsUseCase(Get.find()),
        SubmitAnswerUseCase(Get.find()),
      ),
    );
  }
}
