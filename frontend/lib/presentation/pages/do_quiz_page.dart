import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/result_page.dart';

import '../../data/models/quiz.dart';
import '../../data/models/result.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/card_question.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/forms/button_do_quiz.dart';

class DoQuizPage extends StatefulWidget {
  final Quiz quiz;
  final List<Answer>? answers;
  const DoQuizPage({super.key, required this.quiz, this.answers});

  @override
  State<DoQuizPage> createState() => _DoQuizPageState();
}

class _DoQuizPageState extends State<DoQuizPage> {
  int currentIndex = 0;
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentIndex];

    final result = Result(
      resultID: "rs001",
      quiz: widget.quiz,
      studentID: "student123",
      answers: [
        Answer(answerID: "1", answer: "Con mèo", isCorrect: false),
        Answer(answerID: "2", answer: "Con mèo", isCorrect: true),
        Answer(answerID: "3", answer: "Chó", isCorrect: false),
      ],
      totalQuestion: 5,
      totalCorrect: 3,
      score: 6.0,
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      finish: DateTime.now(),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Làm Quiz"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thanh tiến trình
              LinearProgressIndicator(
                value: (currentIndex + 1) / widget.quiz.questions.length,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),

              CardQuestion(
                answer: widget.answers?[currentIndex],
                question: question,
                currentIndex: currentIndex,
                total: widget.quiz.questions.length,
                selectedAnswer: selectedAnswer,
                onAnswerSelected: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex > 0
                      ? ButtonDoQuiz(
                          label: "Trước",
                          icon: Icons.arrow_back,
                          onPressed: () {
                            setState(() {
                              currentIndex--;
                              selectedAnswer = null;
                            });
                          },
                        )
                      : const SizedBox(width: 120, height: 48),
                  if (currentIndex < widget.quiz.questions.length - 1)
                    ButtonDoQuiz(
                      label: "Tiếp",
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        setState(() {
                          currentIndex++;
                          selectedAnswer = null;
                        });
                      },
                    )
                  else
                    ButtonDoQuiz(
                      label: widget.answers == null ? "Nộp bài" : "Quay về",
                      icon: Icons.check_circle,
                      onPressed: () {
                        AppNavigator.navigateTo(
                            context, ResultPage(result: result));
                      },
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
