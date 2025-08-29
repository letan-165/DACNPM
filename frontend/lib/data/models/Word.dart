import 'Topic.dart';

class Word {
  final String word;
  final String translation;
  final Topic? topic;
  final String phonetic;
  final String audio;
  final List<String> partOfSpeeches;

  Word({
    required this.word,
    required this.translation,
    this.topic,
    required this.phonetic,
    required this.audio,
    required this.partOfSpeeches,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'] ?? '',
      translation: json['translation'] ?? '',
      topic: json['topic'] != null
          ? Topic.fromJson(json['topic'] as Map<String, dynamic>)
          : null,
      phonetic: json['phonetic'] ?? '',
      audio: json['audio'] ?? '',
      partOfSpeeches: (json['partOfSpeeches'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'translation': translation,
      'topic': topic?.toJson(),
      'phonetic': phonetic,
      'audio': audio,
      'partOfSpeeches': partOfSpeeches,
    };
  }
}
