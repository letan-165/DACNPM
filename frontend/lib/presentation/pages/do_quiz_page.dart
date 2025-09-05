import 'package:flutter/material.dart';
import 'package:frontend/data/api/result_api.dart';
import 'package:frontend/data/storage/submit_storage.dart';
import 'package:frontend/presentation/pages/result_history_page.dart';
import 'package:frontend/presentation/pages/result_page.dart';
import 'package:frontend/presentation/pages/review_submit_page.dart';

import '../../data/models/Answer.dart';
import '../../data/models/dto/Response/QuizResponse.dart';
import '../../routes/app_navigate.dart';
import '../utils/quiz_timer.dart';
import '../widgets/cards/card_question.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/forms/button_do_quiz.dart';

class DoQuizPage extends StatefulWidget {
  final QuizResponse quiz;
  final List<Answer>? answers;
  const DoQuizPage({super.key, required this.quiz, this.answers});

  @override
  State<DoQuizPage> createState() => _DoQuizPageState();
}

class _DoQuizPageState extends State<DoQuizPage> with WidgetsBindingObserver {
  final quizTimer = QuizTimer();

  @override
  void initState() {
    super.initState();
    if (widget.answers == null) {
      quizTimer.create(widget.quiz.totalTime, onFinish: () async {
        handleReview(isFinish: true);
      });
    }
  }

  @override
  void dispose() {
    if (widget.answers == null) quizTimer.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  String? selectedAnswer;

  final ResultApi resultApi = ResultApi();

  Future<void> handleSubmit() async {
    final answer = selectedAnswer;
    if (answer == null) return;
    final question = widget.quiz.questions[currentIndex];
    SubmitStorage.save(question.questionID, answer);
  }

  Future<void> handleReview({bool isFinish = false}) async {
    handleSubmit();
    if (widget.answers == null) {
      final request = await SubmitStorage.getRequest();
      final responseSubmit = await resultApi.submit(request!);
      if (isFinish) {
        final responseFinish = await resultApi.finish(request.resultID);
        AppNavigator.navigateTo(context, ResultPage(result: responseFinish));
      } else {
        AppNavigator.navigateTo(
            context, ReviewSubmitPage(result: responseSubmit));
      }
    } else {
      AppNavigator.navigateTo(context, ResultHistoryPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentIndex];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Làm Quiz"),
      body: Stack(
        children: [
          Container( // background full
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildProgressBar(),
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildQuestionCard(question),
                  const SizedBox(height: 20),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: (currentIndex + 1) / widget.quiz.questions.length,
      backgroundColor: Colors.white24,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
      minHeight: 8,
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDropdown(),
        quizTimer.buildTimerWidget(),
      ],
    );
  }

  Widget _buildDropdown() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: currentIndex + 1,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            items: List.generate(
              widget.quiz.questions.length,
              (index) => DropdownMenuItem(
                value: index + 1,
                child: Text("Câu ${index + 1}"),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                handleSubmit();
                setState(() {
                  currentIndex = value - 1;
                  selectedAnswer = null;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(question) {
    return CardQuestion(
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
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentIndex > 0
            ? ButtonDoQuiz(
                label: "Trước",
                icon: Icons.arrow_back,
                onPressed: () {
                  handleSubmit();
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
              handleSubmit();
              setState(() {
                currentIndex++;
                selectedAnswer = null;
              });
            },
          )
        else
          ButtonDoQuiz(
            label: widget.answers == null ? "Hoàn thành" : "Quay về",
            icon: Icons.check_circle,
            onPressed: () => handleReview(),
          ),
      ],
    );
  }
}
