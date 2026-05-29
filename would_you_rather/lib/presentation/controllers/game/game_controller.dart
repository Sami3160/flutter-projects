import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/usecases/get_questions_use_case.dart';
import '../../../domain/usecases/submit_answer_use_case.dart';
import '../../controllers/result/result_binding.dart';
import '../../pages/result/result_page.dart';

class GameController extends GetxController {
  final GetQuestionsUseCase getQuestionsUseCase;
  final SubmitAnswerUseCase submitAnswerUseCase;

  GameController(this.getQuestionsUseCase, this.submitAnswerUseCase);

  var questions = <Question>[].obs;
  var currentIndex = 0.obs;
  var isLoading = true.obs;
  var hasVoted = false.obs;
  var percentages = <String, double>{}.obs;

  var userSelections = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void fetchQuestions() async {
    isLoading.value = true;
    final res = await getQuestionsUseCase.execute();
    questions.assignAll(res);
    isLoading.value = false;
  }

  void submitVote(int chosenOption) async {
    if (hasVoted.value) return;
    hasVoted.value = true;

    // Retrieve User ID and Name
    final user = Get.find<LocalStorageService>().user;
    final userId = user?.id ?? 'unknown_uid';
    final userName = user?.name ?? 'unknown_name';

    // Call backend API
    final res = await submitAnswerUseCase.execute(
      questions[currentIndex.value].id,
      chosenOption,
      userId,
      userName,
    );
    percentages.assignAll(res);

    userSelections.add({
      'questionId': questions[currentIndex.value].id,
      'chosen': chosenOption,
      'option1Text': questions[currentIndex.value].option1Text,
      'option2Text': questions[currentIndex.value].option2Text,
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (currentIndex.value < 9) {
        currentIndex.value++;
        hasVoted.value = false;
        percentages.clear();
      } else {
        Get.off(
          () => const ResultPage(),
          binding: ResultBinding(),
          arguments: userSelections.toList(),
        );
      }
    });
  }
}
