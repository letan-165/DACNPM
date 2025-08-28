enum QuestionType { SELECT, ENTER }

class Question {
  final String questionID;
  final String title;
  final QuestionType type;
  final List<String> options;
  final String correct;

  Question({
    required this.questionID,
    required this.title,
    required this.type,
    required this.options,
    required this.correct,
  });
}
