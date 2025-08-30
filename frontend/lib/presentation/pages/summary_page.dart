import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/result_history_page.dart';
import 'package:frontend/presentation/pages/vocab_history_page.dart';

import '../../routes/app_navigate.dart';
import '../widgets/cards/card_topic.dart';
import '../widgets/custom_appbar.dart';
import 'flashcard_page.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Tổng kết"),
      body: Container(
        padding: const EdgeInsets.only(top: 80),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                "Từ vựng",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Divider(color: Colors.white70, thickness: 1),
              CardTopic(
                icon: Icons.book,
                title: "Từ vựng đã học",
                subtitle: "120 từ vựng",
                color: Colors.orange,
                onTap: () {
                  AppNavigator.navigateTo(context, VocabHistoryPage());
                },
              ),
              const SizedBox(height: 20),
              CardTopic(
                icon: Icons.book,
                title: "Học tiếp từ chưa nhớ",
                subtitle: "80 từ vựng",
                color: Colors.red,
                onTap: () {
                  AppNavigator.navigateTo(
                      context, FlashcardPage(topic: "", summary: true));
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Bài tập",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Divider(color: Colors.white70, thickness: 1),
              CardTopic(
                icon: Icons.assignment,
                title: "Bài tập đã làm",
                subtitle: "2 bài quiz",
                color: Colors.green,
                onTap: () {
                  AppNavigator.navigateTo(context, ResultHistoryPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
