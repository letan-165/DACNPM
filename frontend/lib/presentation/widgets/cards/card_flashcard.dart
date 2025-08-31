import 'package:flutter/material.dart';
import 'package:frontend/data/models/Word.dart';
import 'package:just_audio/just_audio.dart';

class FlashcardCard extends StatefulWidget {
  final Word word;
  final bool isBack;
  final bool? isMemorized;

  const FlashcardCard({
    super.key,
    required this.word,
    this.isBack = false,
    this.isMemorized,
  });

  @override
  State<FlashcardCard> createState() => _FlashcardCardState();
}

class _FlashcardCardState extends State<FlashcardCard> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.setUrl(widget.word.audio ?? '');
      _audioPlayer.play();
    } catch (e) {
      debugPrint('Lỗi phát âm thanh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBack = widget.isBack;
    final word = widget.word;

    return Stack(
      children: [
        SizedBox(
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
        ),
        if (widget.isMemorized != null)
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isMemorized!
                      ? [Colors.green.shade300, Colors.green.shade700]
                      : [Colors.grey.shade400, Colors.grey.shade600],
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
                widget.isMemorized! ? Icons.check : Icons.hourglass_empty,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFrontContent() {
    final word = widget.word;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          word.word,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          word.phonetic,
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: _playAudio,
          child: Container(
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
        ),
      ],
    );
  }

  Widget _buildBackContent() {
    final word = widget.word;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          word.translation,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Loại từ: ${word.partOfSpeeches.join(", ")}",
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ],
    );
  }
}
