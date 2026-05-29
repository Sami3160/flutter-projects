import '../entities/question.dart';
import '../entities/user.dart';

abstract class GameRepository {
  Future<List<Question>> getQuestions();
  Future<Map<String, double>> submitAnswer(
    int questionId,
    int chosenOption,
    String userId,
    String userName,
  );
  Future<User> registerUser(String name);
}
