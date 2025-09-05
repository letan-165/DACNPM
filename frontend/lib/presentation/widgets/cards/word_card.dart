import 'package:flutter/material.dart';
import 'package:frontend/data/models/Word.dart';
import 'package:just_audio/just_audio.dart';

class WordCard extends StatefulWidget {
  final Word word;

  const WordCard({
    super.key,
    required this.word,
  });

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  final AudioPlayer _player = AudioPlayer();

  Future<void> _playAudio(String url) async {
    try {
      await _player.setUrl(url);
      _player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi audio")),
      );
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = widget.word;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 12,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFFDFBFB), Color(0xFFE6E6E6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    word.word,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up,
                      color: Colors.blueAccent, size: 32),
                  onPressed: () => _playAudio(word.audio),
                ),
              ],
            ),

            const SizedBox(height: 6),
            Text(
              word.phonetic,
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),

            const Divider(height: 30, thickness: 1),

            Row(
              children: [
                const Icon(Icons.translate, color: Colors.teal, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    word.translation,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.bookmark, color: Colors.blue, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    word.partOfSpeeches.join(" - "),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
