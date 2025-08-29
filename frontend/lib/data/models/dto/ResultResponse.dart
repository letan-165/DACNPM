import '../Answer.dart';
import 'QuizResponse.dart';

class ResultResponse {
  final String resultID;
  final QuizResponse quiz;
  final String studentID;
  final List<Answer> answers;
  final int totalQuestion;
  final int totalCorrect;
  final double score;
  final DateTime? createAt;
  final DateTime? finish;

  ResultResponse({
    required this.resultID,
    required this.quiz,
    required this.studentID,
    required this.answers,
    required this.totalQuestion,
    required this.totalCorrect,
    required this.score,
    this.createAt,
    this.finish,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(
      resultID: json['resultID'] ?? '',
      quiz: QuizResponse.fromJson(json['quiz'] as Map<String, dynamic>),
      studentID: json['studentID'] ?? '',
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalQuestion: json['totalQuestion'] ?? 0,
      totalCorrect: json['totalCorrect'] ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      createAt:
          json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      finish: json['finish'] != null ? DateTime.parse(json['finish']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resultID': resultID,
      'quiz': quiz?.toJson(),
      'studentID': studentID,
      'answers': answers.map((a) => a.toJson()).toList(),
      'totalQuestion': totalQuestion,
      'totalCorrect': totalCorrect,
      'score': score,
      'createAt': createAt?.toIso8601String(),
      'finish': finish?.toIso8601String(),
    };
  }
}
