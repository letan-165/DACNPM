import 'package:flutter/material.dart';
import 'package:frontend/data/api/word_api.dart';
import 'package:frontend/data/models/CardItem.dart';
import 'package:frontend/presentation/pages/topic_page.dart';

import '../../data/models/Word.dart';
import '../../routes/app_navigate.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/dialogs/completion_dialog.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/loadings/loading_wait_api.dart';
import '../widgets/snackbars/custom_snackbar.dart';

class FlashcardPage extends StatefulWidget {
  final String topic;

  const FlashcardPage({
    super.key,
    required this.topic,
  });

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  final WordApi wordApi = WordApi();
  List<CardItem> cards = [];
  List<Word> words = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchWords();
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
                  );
                  setState(() {
                    cards.add(card);
                  });
                  if (words.indexOf(card.word) == words.length - 1) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => CompletionDialog(
                        onGoToStats: () {
                          //TODO: Navigate to stats page

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
