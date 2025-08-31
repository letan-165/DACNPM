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
  String? selectedTopic; // null đại diện cho "Tất cả"
  List<String> topics = [];

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
        topics = cards
            .map((card) => card.word.topic?.name)
            .whereType<String>() // loại bỏ null
            .toSet()
            .toList();
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  List<CardItem> get filteredCards {
    if (selectedTopic == null) return cards;
    return cards
        .where((card) => card.word.topic?.name == selectedTopic)
        .toList();
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
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.category,
                                  color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              DropdownButton<String>(
                                hint: const Text("Chọn chủ đề"),
                                value: selectedTopic,
                                underline: const SizedBox(),
                                items: [
                                  const DropdownMenuItem<String>(
                                    value: null,
                                    child: Text("Tất cả"),
                                  ),
                                  ...topics.map((topic) {
                                    return DropdownMenuItem(
                                      value: topic,
                                      child: Text(topic),
                                    );
                                  }),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedTopic = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.library_books,
                                  color: Colors.green),
                              const SizedBox(width: 6),
                              Text(
                                'Tổng số: ${filteredCards.length}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: filteredCards.length,
                      itemBuilder: (context, index) {
                        final card = filteredCards[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: FlipCard(
                              front: FlashcardCard(
                                  word: card.word,
                                  isBack: false,
                                  isMemorized: card.isMemorized),
                              back: FlashcardCard(
                                  word: card.word,
                                  isBack: true,
                                  isMemorized: card.isMemorized),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
