class JoinQuizRequest {
  final String studentID;
  final String quizID;

  JoinQuizRequest({
    required this.studentID,
    required this.quizID,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentID': studentID,
      'quizID': quizID,
    };
  }
}
