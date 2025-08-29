import 'Word.dart';

class CardItem {
  final Word word;
  late final bool isMemorized;

  CardItem({
    required this.word,
    required this.isMemorized,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      word: Word.fromJson(json['word'] as Map<String, dynamic>),
      isMemorized: json['isMemorized'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word.toJson(),
      'isMemorized': isMemorized,
    };
  }
}
