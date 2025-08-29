class CardSaveRequest {
  final String studentID;
  final String word;
  final bool memorized;

  CardSaveRequest({
    required this.studentID,
    required this.word,
    required this.memorized,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentID': studentID,
      'word': word,
      'memorized': memorized,
    };
  }
}
