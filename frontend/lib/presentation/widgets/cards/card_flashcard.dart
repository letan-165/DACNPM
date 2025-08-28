import 'package:flutter/material.dart';

import '../../../data/models/flashcard.dart';

class FlashcardCard extends StatelessWidget {
  final FlashCard card;
  final bool isBack;

  const FlashcardCard({
    super.key,
    required this.card,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 440,
      child: Card(
        elevation: 12,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: isBack
                ? const LinearGradient(
                    colors: [Color(0xFF74EBD5), Color(0xFF9FACE6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          padding: const EdgeInsets.all(28),
          child: isBack ? _buildBackContent() : _buildFrontContent(),
        ),
      ),
    );
  }

  /// Mặt trước của thẻ
  Widget _buildFrontContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          card.word.word,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          card.word.phonetic,
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF74EBD5), Color(0xFF9FACE6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.volume_up, size: 36, color: Colors.white),
        ),
      ],
    );
  }

  /// Mặt sau của thẻ
  Widget _buildBackContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          card.word.translation,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Loại từ: ${card.word.partOfSpeeches.join(", ")}",
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ],
    );
  }
}
