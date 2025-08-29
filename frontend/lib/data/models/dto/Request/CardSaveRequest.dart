class CardSaveRequest {
  final String studentID;
  final List<CardRequest> cards;

  CardSaveRequest({
    required this.studentID,
    required this.cards,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentID': studentID,
      'cards': cards.map((c) => c.toJson()).toList(),
    };
  }
}

class CardRequest {
  final String word;
  final bool memorized;

  CardRequest({
    required this.word,
    required this.memorized,
  });

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'memorized': memorized,
    };
  }
}
