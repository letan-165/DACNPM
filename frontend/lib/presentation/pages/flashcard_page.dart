import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/models/flashcard.dart';
import '../../data/models/topic.dart';
import '../../data/models/word.dart';
import '../../routes/app_navigate.dart';
import '../widgets/cards/card_flashcard.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/dialogs/completion_dialog.dart';
import '../widgets/snackbars/custom_snackbar.dart';
import 'home_page.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage>
    with SingleTickerProviderStateMixin {
  late List<FlashCard> cards;
  int currentIndex = 0;

  late AnimationController _flipController;
  late Animation<double> _flipAnim;
  bool _showBack = false;

  Offset cardOffset = Offset.zero;
  double cardAngle = 0.0;

  @override
  void initState() {
    super.initState();

    final topic = Topic(name: "Animals", description: "This is Animals");
    final word1 = Word(
      word: "Dog",
      translation: "Con chó",
      topic: topic,
      phonetic: "/dɒg/",
      audio: "https://.../dog.mp3",
      partOfSpeeches: ["noun"],
    );
    final word2 = Word(
      word: "Run",
      translation: "Chạy",
      topic: topic,
      phonetic: "/rʌn/",
      audio: "https://.../run.mp3",
      partOfSpeeches: ["verb"],
    );

    cards = [
      FlashCard(cardID: "1", studentID: "tan1", word: word1),
      FlashCard(cardID: "2", studentID: "tan1", word: word2),
    ];

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(_flipController);
  }

  void _toggleCard() {
    if (_showBack) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    _showBack = !_showBack;
  }

  void _nextCard(bool remembered) {
    if (currentIndex < cards.length - 1) {
      setState(() {
        currentIndex++;
        cardOffset = Offset.zero;
        cardAngle = 0;
        _showBack = false;
        _flipController.reset();
      });

      CustomSnackBar.show(
        context,
        message: remembered
            ? "Đã nhớ ${cards[currentIndex - 1].word.word}"
            : "Chưa nhớ ${cards[currentIndex - 1].word.word}",
        backgroundColor: remembered ? Colors.green : Colors.red,
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CompletionDialog(
          onGoToStats: () {
            Navigator.pop(context);
            AppNavigator.navigateTo(context, HomePage());
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = cards[currentIndex];

    Color bgColor;
    if (cardOffset.dx > 0) {
      bgColor = Color.lerp(Colors.white, Colors.green, cardOffset.dx / 300)!;
    } else if (cardOffset.dx < 0) {
      bgColor = Color.lerp(Colors.white, Colors.red, -cardOffset.dx / 300)!;
    } else {
      bgColor = Colors.white;
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Lật thẻ"),
      extendBodyBehindAppBar: true,
      body: Container(
        color: bgColor,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: cardOffset.dx.abs() > 120 ? 1 : 0,
                    child: Text(
                      cardOffset.dx > 0
                          ? "✅ Tôi đã nhớ từ này"
                          : cardOffset.dx < 0
                              ? "❌ Tôi chưa nhớ"
                              : "",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: cardOffset.dx > 0
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                      ),
                    ),
                  ),
                ),
              ),

              //flashcard
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: _toggleCard,
                        onPanUpdate: (details) {
                          setState(() {
                            cardOffset += details.delta;
                            cardAngle = 0.0015 * cardOffset.dx;
                          });
                        },
                        onPanEnd: (details) {
                          if (cardOffset.dx > 120) {
                            _nextCard(true);
                          } else if (cardOffset.dx < -120) {
                            _nextCard(false);
                          } else {
                            setState(() {
                              cardOffset = Offset.zero;
                              cardAngle = 0;
                            });
                          }
                        },
                        child: AnimatedBuilder(
                          animation: _flipAnim,
                          builder: (context, child) {
                            final angle = _flipAnim.value * pi;
                            final isBack = angle > pi / 2;

                            return Transform.translate(
                              offset: cardOffset,
                              child: Transform.rotate(
                                angle: cardAngle,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateY(angle),
                                  child: isBack
                                      ? Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.identity()
                                            ..rotateY(pi),
                                          child: FlashcardCard(
                                            card: card,
                                            isBack: true,
                                          ),
                                        )
                                      : FlashcardCard(
                                          card: card,
                                          isBack: false,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
