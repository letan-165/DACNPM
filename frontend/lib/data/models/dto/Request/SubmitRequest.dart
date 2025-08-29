class SubmitRequest {
  final String resultID;
  final int questionID;
  final String answer;

  SubmitRequest({
    required this.resultID,
    required this.questionID,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'resultID': resultID,
      'questionID': questionID,
      'answer': answer,
    };
  }
}
