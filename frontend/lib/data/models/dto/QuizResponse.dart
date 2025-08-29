import '../Question.dart';
import '../Topic.dart';

class QuizResponse {
  final String quizID;
  final Topic? topic;
  final String title;
  final int totalTime;
  final List<Question> questions;
  final DateTime? updateAt;

  QuizResponse({
    required this.quizID,
    this.topic,
    required this.title,
    required this.totalTime,
    required this.questions,
    this.updateAt,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      quizID: json['quizID'] ?? '',
      topic: json['topic'] != null
          ? Topic.fromJson(json['topic'] as Map<String, dynamic>)
          : null,
      title: json['title'] ?? '',
      totalTime: json['totalTime'] ?? 0,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizID': quizID,
      'topic': topic?.toJson(),
      'title': title,
      'totalTime': totalTime,
      'questions': questions.map((q) => q.toJson()).toList(),
      'updateAt': updateAt?.toIso8601String(),
    };
  }
}
