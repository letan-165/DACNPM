import '../../CardItem.dart';

class FlashCardResponse {
  final String studentID;
  final List<CardItem> cards;

  FlashCardResponse({
    required this.studentID,
    required this.cards,
  });

  factory FlashCardResponse.fromJson(Map<String, dynamic> json) {
    return FlashCardResponse(
      studentID: json['studentID'] ?? '',
      cards: (json['cards'] as List<dynamic>?)
              ?.map((e) => CardItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentID': studentID,
      'cards': cards.map((c) => c.toJson()).toList(),
    };
  }
}
