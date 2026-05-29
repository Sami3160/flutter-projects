import '../entities/question.dart';
import '../repositories/game_repository.dart';

class GetQuestionsUseCase {
  final GameRepository _repository;
  GetQuestionsUseCase(this._repository);

  Future<List<Question>> execute() {
    return _repository.getQuestions();
  }
}
