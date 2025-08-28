import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/result_page.dart';
import 'package:frontend/routes/app_navigate.dart';

import '../../data/models/question.dart';
import '../../data/models/quiz.dart';
import '../../data/models/result.dart';
import '../../data/models/topic.dart';
import '../widgets/cards/card_result_history.dart';
import '../widgets/custom_appbar.dart';

class ResultHistoryPage extends StatelessWidget {
  const ResultHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = <Result>[
      Result(
        resultID: "r1",
        quiz: Quiz(
          quizID: "q1",
          title: "Ôn tập Unit 1",
          topic: Topic(description: "t1", name: "Family"),
          questions: [
            Question(
              questionID: "ques1",
              title: "Từ nào nghĩa là 'bạn bè'?",
              options: ["friend", "house", "school", "dog"],
              correct: "friend",
              type: QuestionType.SELECT,
            ),
            Question(
              questionID: "ques2",
              title: "Điền vào chỗ trống: My ___ is 40 years old.",
              options: [],
              correct: "father",
              type: QuestionType.ENTER,
            ),
          ],
          totalTime: 15,
          updatedAt: DateTime.now(),
        ),
        studentID: "HS001",
        answers: [
          Answer(answerID: "a1", answer: "friend", isCorrect: true),
          Answer(answerID: "a2", answer: "mother", isCorrect: false),
        ],
        totalQuestion: 2,
        totalCorrect: 1,
        score: 5.0,
        createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
        finish: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Result(
        resultID: "r2",
        quiz: Quiz(
          quizID: "q2",
          title: "Ôn tập Unit 2",
          topic: Topic(description: "t2", name: "School"),
          questions: [
            Question(
              questionID: "ques3",
              title: "Từ nào nghĩa là 'trường học'?",
              options: ["book", "school", "pen", "teacher"],
              correct: "school",
              type: QuestionType.SELECT,
            ),
          ],
          totalTime: 10,
          updatedAt: DateTime.now(),
        ),
        studentID: "HS001",
        answers: [
          Answer(answerID: "a3", answer: "school", isCorrect: true),
        ],
        totalQuestion: 1,
        totalCorrect: 1,
        score: 10.0,
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        finish: DateTime.now()
            .subtract(const Duration(days: 1, hours: 1, minutes: 50)),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Lịch sử làm bài"),
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
        padding: const EdgeInsets.only(top: 80),
        child: results.isEmpty
            ? const Center(
                child: Text(
                  "Bạn chưa làm bài tập nào",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final r = results[index];
                  return ResultHistoryCard(
                    result: r,
                    onTap: () {
                      AppNavigator.navigateTo(context, ResultPage(result: r));
                    },
                  );
                },
              ),
      ),
    );
  }
}
