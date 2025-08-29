class QuestionDeleteRequest {
  final String quizID;
  final List<int> questionIDs;

  QuestionDeleteRequest({
    required this.quizID,
    required this.questionIDs,
  });

  Map<String, dynamic> toJson() {
    return {
      'quizID': quizID,
      'questionIDs': questionIDs,
    };
  }
}
