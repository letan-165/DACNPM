class Question {
  final int questionID;
  final String title;
  final String type;
  final List<String> options;
  final String correct;

  Question({
    required this.questionID,
    required this.title,
    required this.type,
    required this.options,
    required this.correct,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionID: json['questionID'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'],
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      correct: json['correct'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionID': questionID,
      'title': title,
      'type': type,
      'options': options,
      'correct': correct,
    };
  }
}
