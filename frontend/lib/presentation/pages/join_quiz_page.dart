import 'package:flutter/material.dart';
import 'package:frontend/data/models/dto/Request/JoinQuizRequest.dart';
import 'package:frontend/data/storage/submit_storage.dart';
import 'package:frontend/presentation/pages/do_quiz_page.dart';

import '../../data/api/result_api.dart';
import '../../data/models/dto/Response/QuizResponse.dart';
import '../../data/storage/login_storage.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/cart_chip_join.dart';
import '../widgets/custom_appbar.dart';

class JoinQuizPage extends StatelessWidget {
  final QuizResponse quiz;
  const JoinQuizPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final questionCount = quiz.questions.length;

    final ResultApi resultApi = ResultApi();
    Future<void> handleJoin() async {
      final login = await LoginStorage.getLogin(context);
      final request =
          JoinQuizRequest(studentID: login.userID, quizID: quiz.quizID);
      final response = await resultApi.join(request);
      SubmitStorage.create(response.resultID);
      AppNavigator.navigateTo(context, DoQuizPage(quiz: quiz));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Tham gia Quiz"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF74EBD5), Color(0xFF9FACE6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon đẹp hơn với nền tròn
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.emoji_events,
                          size: 60, color: Colors.white),
                    ),

                    const SizedBox(height: 20),

                    // Tiêu đề
                    Text(
                      quiz.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 10,
                      children: [
                        CartChipJoin(
                          icon: Icons.timer,
                          text: "${quiz.totalTime} giây",
                        ),
                        CartChipJoin(
                          icon: Icons.help_outline,
                          text: "$questionCount câu hỏi",
                        ),
                        CartChipJoin(
                          icon: Icons.book,
                          text: quiz.topic?.name ?? "",
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Nút tham gia
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => handleJoin(),
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text(
                          "Tham gia ngay",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
