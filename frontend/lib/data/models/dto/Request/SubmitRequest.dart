class SubmitRequest {
  final String resultID;
  final List<Submit> submits;

  SubmitRequest({
    required this.resultID,
    required this.submits,
  });

  Map<String, dynamic> toJson() {
    return {
      'resultID': resultID,
      'submits': submits.map((s) => s.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SubmitRequest(resultID: $resultID, submits: $submits)';
  }
}

class Submit {
  final int questionID;
  final String answer;

  Submit({
    required this.questionID,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionID': questionID,
      'answer': answer,
    };
  }

  factory Submit.fromJson(Map<String, dynamic> json) {
    return Submit(
      questionID: json['questionID'],
      answer: json['answer'],
    );
  }
  @override
  String toString() {
    return 'Submit(questionID: $questionID, answer: $answer)';
  }
}
