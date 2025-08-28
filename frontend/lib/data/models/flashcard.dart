import 'word.dart';

class FlashCard {
  final String cardID;
  final String studentID;
  final Word word;
  bool isMemorized;

  FlashCard({
    required this.cardID,
    required this.studentID,
    required this.word,
    this.isMemorized = false,
  });
}
