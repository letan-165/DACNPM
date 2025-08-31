import 'package:flutter/material.dart';
import 'package:frontend/data/api/flashcard_api.dart';
import 'package:frontend/data/api/word_api.dart';
import 'package:frontend/data/models/dto/Request/CardSaveRequest.dart';
import 'package:frontend/presentation/pages/topic_page.dart';

import '../../data/models/Word.dart';
import '../../data/storage/login_storage.dart';
import '../../routes/app_navigate.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/dialogs/completion_dialog.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/loadings/loading_wait_api.dart';
import '../widgets/snackbars/custom_snackbar.dart';

class FlashcardPage extends StatefulWidget {
  final String topic;
  final bool summary;

  const FlashcardPage({
    super.key,
    this.topic = "",
    this.summary = false,
  });

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  final WordApi wordApi = WordApi();
  final FlashCardApi flashCardApi = FlashCardApi();
  List<CardRequest> cards = [];
  List<Word> words = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    widget.summary ? fetchSummary() : fetchWords();
  }

  Future<void> fetchWords() async {
    try {
      final data = await wordApi.findAllByTopic(widget.topic);
      setState(() {
        words = data;
        loading = false;
      });
    } catch (e) {}
  }

  Future<void> fetchSummary() async {
    final login = await LoginStorage.getLogin(context);
    try {
      final data = await flashCardApi.findUnmemorizedCards(login.userID);
      setState(() {
        words = data.cards.map((e) => e.word).toList();
        loading = false;
      });
    } catch (e) {}
  }

  Future<void> handleCompletion() async {
    final login = await LoginStorage.getLogin(context);
    final studentID = login.userID;
    final request = CardSaveRequest(studentID: studentID, cards: cards);
    try {
      await flashCardApi.save(request);
    } catch (e) {
      CustomSnackBar.show(context, message: "Lưu thất bại: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Lật thẻ"),
      body: SafeArea(
        child: loading
            ? const LoadingWaitApi(text: "Đang tải dữ liệu...")
            : FlashcardWidget(
                words: words,
                onCardSwiped: (card) {
                  CustomSnackBar.show(
                    context,
                    message: card.isMemorized
                        ? "Đã nhớ ${card.word.word}"
                        : "Chưa nhớ ${card.word.word}",
                    backgroundColor:
                        card.isMemorized ? Colors.green : Colors.red,
                    duration: 0,
                  );
                  setState(() {
                    cards.add(CardRequest(
                        word: card.word.word, memorized: card.isMemorized));
                  });
                  if (words.indexOf(card.word) == words.length - 1) {
                    handleCompletion();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => CompletionDialog(
                        onGoToStats: () {
                          Navigator.pop(context);
                          AppNavigator.navigateTo(
                              context, TopicPage(mode: "flashcard"));
                        },
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
