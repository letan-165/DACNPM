import 'package:flutter/material.dart';

import '../../data/models/Question.dart';
import '../../data/models/Topic.dart';
import '../../data/models/dto/QuizResponse.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/card_quiz.dart';
import '../widgets/custom_appbar.dart';
import 'join_quiz_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topic = Topic(name: "Animals", description: "Các loài động vật");

    final quizzes = [
      QuizResponse(
        quizID: "q1",
        topic: topic,
        title: "Động vật cơ bản",
        totalTime: 120,
        questions: [
          Question(
            questionID: 1,
            title: "Dog nghĩa là gì?",
            type: "SELECT",
            options: ["Con chó", "Con mèo", "Con cá"],
            correct: "Con chó",
          ),
          Question(
            questionID: 2,
            title: "Cat nghĩa là gì?",
            type: "SELECT",
            options: ["Con chó", "Con mèo", "Con cá"],
            correct: "Con mèo",
          ),
          Question(
            questionID: 3,
            title: "Điền từ: Con ___ là Cat",
            type: "ENTER",
            options: [],
            correct: "Mèo",
          ),
        ],
        updateAt: DateTime.now(),
      ),
      QuizResponse(
        quizID: "q2",
        topic: topic,
        title: "Thử thách nâng cao",
        totalTime: 10,
        questions: [],
        updateAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: "Danh sách Quiz"),
      body: ListView.builder(
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
