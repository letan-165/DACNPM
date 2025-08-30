import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/api/flashcard_api.dart';
import 'package:frontend/data/models/CardItem.dart';

import '../../data/storage/login_storage.dart';
import '../widgets/cards/card_flashcard.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/loadings/loading_wait_api.dart';

class VocabHistoryPage extends StatefulWidget {
  const VocabHistoryPage({super.key});

  @override
  State<VocabHistoryPage> createState() => _VocabHistoryPageState();
}

class _VocabHistoryPageState extends State<VocabHistoryPage> {
  final FlashCardApi flashCardApi = FlashCardApi();
  List<CardItem> cards = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchWords();
  }

  Future<void> fetchWords() async {
    final login = await LoginStorage.getLogin(context);
    try {
      final data = await flashCardApi.findByStudentID(login.userID);
      setState(() {
        cards = data.cards;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Từ vựng đã học"),
      body: loading
          ? const LoadingWaitApi(text: "Đang tải dữ liệu...")
          : Padding(
              padding: const EdgeInsets.only(top: 80),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Stack(
                      children: [
                        Center(
                          child: FlipCard(
                            front:
                                FlashcardCard(word: card.word, isBack: false),
                            back: FlashcardCard(word: card.word, isBack: true),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 60,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: card.isMemorized
                                    ? [
                                        Colors.green.shade300,
                                        Colors.green.shade700
                                      ] // Đã nhớ
                                    : [
                                        Colors.grey.shade400,
                                        Colors.grey.shade600
                                      ], // Chưa nhớ
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            child: Icon(
                              card.isMemorized
                                  ? Icons.check
                                  : Icons.hourglass_empty,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
