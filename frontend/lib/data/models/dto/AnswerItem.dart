import '../Answer.dart';
import '../Question.dart';

class AnswerItem {
  final int id;
  final String title;
  final String type;
  final String answer;

  AnswerItem({
    required this.id,
    required this.title,
    required this.type,
    required this.answer,
  });

  static List<AnswerItem> merge({
    required List<Question> questions,
    required List<Answer> answers,
  }) {
    return questions.map((q) {
      final ans = answers.firstWhere(
        (a) => a.answerID == q.questionID,
        orElse: () =>
            Answer(answerID: q.questionID, answer: '', correct: false),
      );
      return AnswerItem(
        id: q.questionID,
        title: q.title,
        type: q.type,
        answer: ans.answer,
      );
    }).toList();
  }
}
