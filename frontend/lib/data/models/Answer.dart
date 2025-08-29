class Answer {
  final int answerID;
  final String answer;
  final bool correct;

  Answer({
    required this.answerID,
    required this.answer,
    required this.correct,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerID: json['answerID'] ?? 0,
      answer: json['answer'] ?? '',
      correct: json['correct'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answerID': answerID,
      'answer': answer,
      'correct': correct,
    };
  }
}
