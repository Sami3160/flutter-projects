import '../../domain/entities/question.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/game_repository.dart';
import '../models/question_model.dart';
import '../models/user_model.dart';
import '../providers/network/apis/game_api.dart';

class GameRepositoryImpl implements GameRepository {
  @override
  Future<List<Question>> getQuestions() async {
    final response = await GameAPI.getQuestions().request();
    List<dynamic> list = [];
    if (response is List) {
      list = response;
    }
    return list.map((item) => QuestionModel.fromJson(item)).toList();
  }

  @override
  Future<Map<String, double>> submitAnswer(
    int questionId,
    int chosenOption,
    String userId,
    String userName,
  ) async {
    final response = await GameAPI.submitVote(
      questionId: questionId,
      chosenOption: chosenOption,
      userId: userId,
      userName: userName,
    ).request();

    final stats = response['stats'];
    return {
      'left': (stats['option1_percentage'] as num).toDouble(),
      'right': (stats['option2_percentage'] as num).toDouble(),
    };
  }

  @override
  Future<User> registerUser(String name) async {
    final response = await GameAPI.registerUser(userName: name).request();
    return UserModel.fromJson(response);
  }
}
