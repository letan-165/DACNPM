import 'package:flutter/material.dart';
import 'package:frontend/data/api/quiz_api.dart';

import '../../data/models/dto/Response/QuizResponse.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/card_quiz.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/loadings/loading_wait_api.dart';
import 'join_quiz_page.dart';

class QuizPage extends StatefulWidget {
  final String topic;
  const QuizPage({
    super.key,
    required this.topic,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizApi quizApi = QuizApi();
  List<QuizResponse> quizzes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      final data = await quizApi.findAllByTopic(widget.topic);
      setState(() {
        quizzes = data;
        loading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Danh sách Quiz"),
      body: loading
          ? const LoadingWaitApi(text: "Đang tải dữ liệu...")
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return CardQuiz(
                  quiz: quiz,
                  onTap: () {
                    AppNavigator.navigateTo(context, JoinQuizPage(quiz: quiz));
                  },
                );
              },
            ),
    );
  }
}
