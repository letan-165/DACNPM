class QuizSaveRequest {
  final String quizID;
  final String topic;
  final String title;
  final int totalTime;

  QuizSaveRequest({
    required this.quizID,
    required this.topic,
    required this.title,
    required this.totalTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'quizID': quizID,
      'topic': topic,
      'title': title,
      'totalTime': totalTime,
    };
  }
}
