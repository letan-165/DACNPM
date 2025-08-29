import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/do_quiz_page.dart';
import 'package:frontend/presentation/pages/home_page.dart';
import 'package:intl/intl.dart';

import '../../data/models/dto/ResultResponse.dart';
import '../../routes/app_navigate.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/forms/button_do_quiz.dart';

class ResultPage extends StatelessWidget {
  final ResultResponse result;

  const ResultPage({super.key, required this.result});

  String formatDate(DateTime dt) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dt);
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Kết quả"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- Header ---
                  Column(
                    children: [
                      Icon(Icons.school,
                          size: 40, color: Colors.deepPurpleAccent),
                      const SizedBox(height: 10),
                      Text(
                        result.quiz?.title ?? "",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        result.quiz?.topic?.name ?? "",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  const Divider(height: 30, thickness: 1),

                  // --- Info Rows ---
                  InfoRow(
                    icon: Icons.person,
                    label: "Học sinh",
                    value: result.studentID,
                  ),
                  InfoRow(
                    icon: Icons.check_circle,
                    label: "Số câu đúng",
                    value: "${result.totalCorrect}/${result.totalQuestion}",
                    valueColor: Colors.blue,
                  ),
                  InfoRow(
                    icon: Icons.star,
                    label: "Điểm",
                    value: result.score.toStringAsFixed(1),
                    valueColor: Colors.green,
                  ),
                  InfoRow(
                    icon: Icons.play_circle,
                    label: "Bắt đầu",
                    value: formatDate(result.createAt ?? DateTime.now()),
                  ),
                  InfoRow(
                    icon: Icons.stop_circle,
                    label: "Kết thúc",
                    value: formatDate(result.finish ?? DateTime.now()),
                  ),
                  InfoRow(
                    icon: Icons.timer,
                    label: "Tổng thời gian",
                    value:
                        "${formatDuration(result.finish!.difference(result.createAt ?? DateTime.now()))} / ${result.quiz?.totalTime} phút",
                    valueColor: Colors.orange,
                  ),

                  const SizedBox(height: 20),

                  // --- Action buttons ---
                  ButtonDoQuiz(
                    label: "Xem chi tiết",
                    icon: Icons.visibility,
                    onPressed: () {
                      AppNavigator.navigateTo(
                          context,
                          DoQuizPage(
                            quiz: result.quiz,
                            answers: result.answers,
                          ));
                    },
                  ),
                  const SizedBox(height: 12),
                  ButtonDoQuiz(
                    label: "Về trang chính",
                    icon: Icons.home,
                    onPressed: () {
                      AppNavigator.navigateTo(context, HomePage());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
