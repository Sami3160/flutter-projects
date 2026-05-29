import 'dart:io';
import '../api_endpoints.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum GameApiType { getQuestions, submitVote, registerUser }

class GameAPI implements APIRequestRepresentable {
  final GameApiType type;
  int? questionId;
  int? chosenOption;
  String? userId;
  String? userName;

  GameAPI._({
    required this.type,
    this.questionId,
    this.chosenOption,
    this.userId,
    this.userName,
  });

  GameAPI.getQuestions() : this._(type: GameApiType.getQuestions);

  GameAPI.submitVote({
    required int questionId,
    required int chosenOption,
    required String userId,
    required String userName,
  }) : this._(
         type: GameApiType.submitVote,
         questionId: questionId,
         chosenOption: chosenOption,
         userId: userId,
         userName: userName,
       );

  GameAPI.registerUser({required String userName})
    : this._(type: GameApiType.registerUser, userName: userName);

  @override
  String get endpoint => ApiEndpoints.baseUrl;

  @override
  String get path {
    switch (type) {
      case GameApiType.getQuestions:
        return "/questions";
      case GameApiType.submitVote:
        return "/votes";
      case GameApiType.registerUser:
        return "/users";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case GameApiType.getQuestions:
        return HTTPMethod.get;
      default:
        return HTTPMethod.post;
    }
  }

  @override
  Map<String, String> get headers => {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  @override
  Map<String, String>? get query => null;

  @override
  dynamic get body {
    switch (type) {
      case GameApiType.submitVote:
        return {
          'user_id': userId,
          'question_id': questionId,
          'selected_option': chosenOption,
        };
      case GameApiType.registerUser:
        return {'name': userName};
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
