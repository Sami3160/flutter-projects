class Question {
  final int id;
  final String option1Text;
  final String option2Text;
  final String? option1ImageUrl;
  final String? option2ImageUrl;

  Question({
    required this.id,
    required this.option1Text,
    required this.option2Text,
    this.option1ImageUrl,
    this.option2ImageUrl,
  });
}
