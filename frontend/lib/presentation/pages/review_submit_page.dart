import 'package:flutter/material.dart';
import 'package:frontend/data/models/dto/Response/ResultResponse.dart';
import 'package:frontend/presentation/pages/result_history_page.dart';

import '../../data/api/result_api.dart';
import '../../data/models/dto/AnswerItem.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/card_review_submit.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/forms/button_do_quiz.dart';

class ReviewSubmitPage extends StatelessWidget {
  final ResultResponse result;
  const ReviewSubmitPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final questions = result.quiz.questions;
    final answers = result.answers;
    final mergedList = AnswerItem.merge(
      questions: result.quiz.questions,
      answers: result.answers,
    );
    final ResultApi resultApi = ResultApi();

    Future<void> handleFinish() async {
      final response = await resultApi.finish(result.resultID);
      AppNavigator.navigateTo(context, ResultHistoryPage());
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'Kiểm tra lại bài làm'),
      body: Container(
        padding:
            const EdgeInsets.only(top: 80, left: 12, right: 12, bottom: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          spacing: 20,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return CardReviewSubmit(
                      index: index + 1, answer: mergedList[index]);
                },
              ),
            ),
            // Nút bấm dưới cùng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDoQuiz(
                    label: "Tiếp tục làm",
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context)),
                ButtonDoQuiz(
                  label: "Nộp bài",
                  icon: Icons.check_circle,
                  onPressed: () => handleFinish(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
