import 'question.dart';
import 'topic.dart';

class Quiz {
  final String quizID;
  final Topic topic;
  final String title;
  final int totalTime;
  final List<Question> questions;
  final DateTime updatedAt;

  Quiz({
    required this.quizID,
    required this.topic,
    required this.title,
    required this.totalTime,
    required this.questions,
    required this.updatedAt,
  });
}
