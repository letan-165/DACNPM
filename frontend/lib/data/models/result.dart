import 'package:frontend/data/models/quiz.dart';

class Result {
  final String resultID;
  final Quiz quiz;
  final String studentID;
  final List<Answer> answers;
  final int totalQuestion;
  final int totalCorrect;
  final double score;
  final DateTime createdAt;
  final DateTime finish;

  Result({
    required this.resultID,
    required this.quiz,
    required this.studentID,
    required this.answers,
    required this.totalQuestion,
    required this.totalCorrect,
    required this.score,
    required this.createdAt,
    required this.finish,
  });
}

class Answer {
  final String answerID;
  final String answer;
  final bool isCorrect;

  Answer({
    required this.answerID,
    required this.answer,
    required this.isCorrect,
  });
}
