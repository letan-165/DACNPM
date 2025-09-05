import 'package:flutter/material.dart';
import 'package:frontend/data/api/word_api.dart';
import 'package:frontend/data/models/dto/Request/WordRequest.dart';
import 'package:frontend/presentation/widgets/cards/word_card.dart';
import 'package:frontend/presentation/widgets/custom_appbar.dart';
import 'package:frontend/presentation/widgets/forms/button_do_quiz.dart';
import 'package:frontend/presentation/widgets/forms/custom_text_field.dart';
import 'package:frontend/presentation/widgets/snackbars/custom_snackbar.dart';
import '../../data/models/Word.dart';
import 'package:just_audio/just_audio.dart';

import '../widgets/loadings/loading_page.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _player = AudioPlayer();

  Word? word;
  final wordApi= WordApi();
  bool isLoading = false;
  Future<void> _searchWord() async {
    if (_controller.text.trim().isEmpty) {
      CustomSnackBar.show(context, message: "Vui lòng nhập từ vựng");
      return;
    }
    setState(() => isLoading = true);
    try {
      final request = WordRequest(word: _controller.text.trim(), topic: 'Gia đình');
      final response = await wordApi.suggest(request);

      setState(() {
        word = response;
        isLoading = false;
      });
    } catch (e) {
      CustomSnackBar.show(context, message: "Từ vựng không hợp lệ");
      setState(() {
        word = null;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Tra cứu từ vựng"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      isPt: false,
                      controller: _controller, label: 'Nhập từ vựng . . . .', icon: Icons.language
                    ),
                  ),
                  const SizedBox(width: 10),
                  ButtonDoQuiz(
                    onPressed: _searchWord, label: '', icon: Icons.search,
                  ),
                ],
              ),
            ),
            if (isLoading)
              const LoadingPage(text: "Đang tra cứu...")
            else if (word == null)
              const Center(
                child: Text(
                  "Chưa có từ cần tra",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(20),
                child: WordCard(word: word!),
              )
          ],
        ),
      ),
    );
  }
}
