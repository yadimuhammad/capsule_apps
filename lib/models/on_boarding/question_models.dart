class QuestionModels {
  final String id;
  final String title;
  final List<String> options;
  String? selectedAnswer;

  QuestionModels({
    required this.id,
    required this.title,
    required this.options,
    this.selectedAnswer,
  });

  QuestionModels copyWith({String? selectedAnswer}) {
    return QuestionModels(
      id: id,
      title: title,
      options: options,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}
