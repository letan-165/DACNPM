class WordRequest {
  final String topic;
  final String word;

  WordRequest({
    required this.topic,
    required this.word,
  });

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'word': word,
    };
  }
}
