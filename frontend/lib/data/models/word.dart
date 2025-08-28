import 'topic.dart';

class Word {
  final String word;
  final String translation;
  final Topic topic;
  final String phonetic;
  final String audio;
  final List<String> partOfSpeeches;

  Word({
    required this.word,
    required this.translation,
    required this.topic,
    required this.phonetic,
    required this.audio,
    required this.partOfSpeeches,
  });
}
