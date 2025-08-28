import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/summary_page.dart';
import 'package:frontend/presentation/pages/topic_page.dart';

import '../../routes/app_navigate.dart';
import '../widgets/cards/card_home.dart';
import '../widgets/dialogs/feature_dialog.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        "title": "Lật thẻ",
        "icon": Icons.style,
        "navigate": () =>
            AppNavigator.navigateTo(context, TopicPage(mode: "flashcard")),
      },
      {
        "title": "Luyện tập",
        "icon": Icons.quiz,
        "navigate": () =>
            AppNavigator.navigateTo(context, TopicPage(mode: "quiz")),
      },
      {
        "title": "Tổng kết",
        "icon": Icons.bar_chart,
        "navigate": () => AppNavigator.navigateTo(context, SummaryPage()),
      },
      {
        "title": "Cài đặt",
        "icon": Icons.settings,
        "navigate": () => FeatureDialog.show(context,
            message: "Người không có trình thì đừng bấm vào 🤬"),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 MeVocab + Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Xin chào👋",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    ClipOval(
                      child: Image.network(
                        "https://static.vecteezy.com/system/resources/thumbnails/017/300/766/small_2x/learning-english-doodle-set-language-school-in-sketch-style-online-language-education-course-hand-drawn-illustration-isolated-on-white-background-vector.jpg",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                const Text(
                  "Hôm nay bạn muốn học gì?",
                  style: TextStyle(fontSize: 25, color: Colors.white70),
                ),
                const SizedBox(height: 30),

                // Danh sách tính năng
                Expanded(
                  child: GridView.builder(
                    itemCount: features.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final feature = features[index];
                      return CardHome(
                          title: feature["title"] as String,
                          icon: feature["icon"] as IconData,
                          onTap: feature["navigate"] as void Function());
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      AppNavigator.navigateTo(context, LoginPage());
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Đăng xuất",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
