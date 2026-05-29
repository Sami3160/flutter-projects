import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.id,
    required super.option1Text,
    required super.option2Text,
    super.option1ImageUrl,
    super.option2ImageUrl,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      option1Text: json['option1_text'],
      option1ImageUrl: json['option1_image_url'],
      option2Text: json['option2_text'],
      option2ImageUrl: json['option2_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'option1_text': option1Text,
      'option1_image_url': option1ImageUrl,
      'option2_text': option2Text,
      'option2_image_url': option2ImageUrl,
    };
  }
}
