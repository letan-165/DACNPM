import '../../Question.dart';

class QuestionSaveRequest {
  final String quizID;
  final List<Question> questions;

  QuestionSaveRequest({
    required this.quizID,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'quizID': quizID,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
