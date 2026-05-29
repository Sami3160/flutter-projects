import '../repositories/game_repository.dart';

class SubmitAnswerUseCase {
  final GameRepository _repository;
  SubmitAnswerUseCase(this._repository);

  Future<Map<String, double>> execute(
    int questionId,
    int chosenOption,
    String userId,
    String userName,
  ) {
    return _repository.submitAnswer(questionId, chosenOption, userId, userName);
  }
}
