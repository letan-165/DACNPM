import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/Word.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../data/models/CardItem.dart';
import '../widgets/cards/card_flashcard.dart';

class FlashcardWidget extends StatefulWidget {
  final List<Word> words;
  final void Function(CardItem card)? onCardSwiped;

  const FlashcardWidget({
    super.key,
    required this.words,
    this.onCardSwiped,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  late SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  void _onSwipeCompleted(int index, SwipeDirection direction) {
    if (index >= widget.words.length) return;
    final word = widget.words[index];
    final remembered = direction == SwipeDirection.right;
    widget.onCardSwiped?.call(CardItem(word: word, isMemorized: remembered));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty) {
      return const Center(child: Text("Không có thẻ nào để hiển thị"));
    }

    return SwipableStack(
      controller: _controller,
      onSwipeCompleted: _onSwipeCompleted,
      itemCount: widget.words.length,
      onWillMoveNext: (index, direction) {
        if (direction == SwipeDirection.left ||
            direction == SwipeDirection.right) {
          return true;
        }
        return false;
      },
      builder: (context, index, constraints) {
        final word = widget.words[index];
        return Center(
          child: FlipCard(
            front: FlashcardCard(word: word, isBack: false),
            back: FlashcardCard(word: word, isBack: true),
          ),
        );
      },
    );
  }
}
