class Topic {
  final String name;
  final String description;

  Topic({
    required this.name,
    required this.description,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
