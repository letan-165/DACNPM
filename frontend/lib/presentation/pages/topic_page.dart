import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/quiz_page.dart';

import '../../data/models/Topic.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/card_topic.dart';
import '../widgets/custom_appbar.dart';
import 'flashcard_page.dart';

class TopicPage extends StatelessWidget {
  final mode;
  const TopicPage({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final page = mode == "quiz" ? QuizPage() : FlashcardPage();

    final topics = [
      Topic(name: "Animals", description: "Các loài động vật"),
      Topic(name: "Fruits", description: "Tên các loại trái cây"),
      Topic(name: "Jobs", description: "Các nghề nghiệp phổ biến"),
      Topic(name: "Travel", description: "Từ vựng về du lịch"),
      Topic(name: "Technology", description: "Từ vựng về công nghệ"),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Chủ đề"),
      body: Container(
        padding: const EdgeInsets.only(top: 70),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return CardTopic(
              icon: Icons.book,
              title: topic.name,
              subtitle: topic.description,
              color: Colors.orange,
              onTap: () {
                AppNavigator.navigateTo(context, page);
              },
            );
          },
        ),
      ),
    );
  }
}
