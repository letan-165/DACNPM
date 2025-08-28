import 'package:flutter/material.dart';

import '../../data/models/question.dart';
import '../../data/models/quiz.dart';
import '../../data/models/topic.dart';
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
      Quiz(
        quizID: "q1",
        topic: topic,
        title: "Động vật cơ bản",
        totalTime: 120,
        questions: [
          Question(
            questionID: "1",
            title: "Dog nghĩa là gì?",
            type: QuestionType.SELECT,
            options: ["Con chó", "Con mèo", "Con cá"],
            correct: "Con chó",
          ),
          Question(
            questionID: "2",
            title: "Cat nghĩa là gì?",
            type: QuestionType.SELECT,
            options: ["Con chó", "Con mèo", "Con cá"],
            correct: "Con mèo",
          ),
          Question(
            questionID: "3",
            title: "Điền từ: Con ___ là Cat",
            type: QuestionType.ENTER,
            options: [],
            correct: "Mèo",
          ),
        ],
        updatedAt: DateTime.now(),
      ),
      Quiz(
        quizID: "q2",
        topic: topic,
        title: "Thử thách nâng cao",
        totalTime: 10,
        questions: [],
        updatedAt: DateTime.now(),
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
