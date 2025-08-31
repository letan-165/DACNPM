import 'package:flutter/material.dart';

import '../../../data/models/Answer.dart';
import '../../../data/models/Question.dart';
import '../../../data/storage/submit_storage.dart';
import 'card_answer_select.dart';

class CardQuestion extends StatefulWidget {
  final Question question;
  final int currentIndex;
  final int total;
  final String? selectedAnswer;
  final ValueChanged<String>? onAnswerSelected;
  final Answer? answer;
  const CardQuestion({
    super.key,
    required this.question,
    required this.currentIndex,
    required this.total,
    this.selectedAnswer,
    this.onAnswerSelected,
    this.answer,
  });

  @override
  State<CardQuestion> createState() => _CardQuestionState();
}

class _CardQuestionState extends State<CardQuestion> {
  String? _savedAnswer;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSavedAnswer();
  }

  @override
  void didUpdateWidget(covariant CardQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.questionID != widget.question.questionID) {
      _loadSavedAnswer();
    }
  }

  Future<void> _loadSavedAnswer() async {
    final submit = await SubmitStorage.get(widget.question.questionID);
    final answer = submit?.answer;
    print("tan $answer");
    if (mounted) {
      setState(() {
        _savedAnswer = answer;
        _controller.text = answer ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isReview = widget.answer != null;

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Câu ${widget.currentIndex + 1}/${widget.total}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.question.title.replaceAll("=@=", "_____"),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                if (widget.question.options.isNotEmpty)
                  Column(
                    children: widget.question.options.map((opt) {
                      bool showGreen = false;
                      bool showRed = false;

                      if (isReview) {
                        if (widget.answer?.answer == "") {
                          showGreen = (opt == widget.question.correct);
                          showRed = (opt != widget.question.correct);
                        } else {
                          if (widget.answer!.correct) {
                            showGreen = (opt == widget.answer!.answer);
                            showRed = false;
                          } else {
                            showGreen = (opt == widget.question.correct);
                            showRed = (opt == widget.answer!.answer);
                          }
                        }
                      }

                      return CardAnswerSelect(
                        option: opt,
                        isSelected: isReview
                            ? showRed
                            : (_savedAnswer == opt ||
                                widget.selectedAnswer == opt),
                        isCorrect: isReview ? showGreen : null,
                        isReview: isReview,
                        onTap: isReview
                            ? null
                            : () {
                                widget.onAnswerSelected?.call(opt);
                                setState(() {
                                  _savedAnswer = opt;
                                });
                              },
                      );
                    }).toList(),
                  ),

                // --- CÂU ĐIỀN TỪ ---
                if (widget.question.options.isEmpty)
                  isReview
                      ? (widget.answer!.correct
                          // Đúng: chỉ hiện 1 ô xanh câu người học trả lời
                          ? _filledBox(
                              leading:
                                  const Icon(Icons.check, color: Colors.green),
                              text: widget.answer!.answer,
                              bg: Colors.green.shade100,
                              fg: Colors.green,
                            )
                          // Sai: hiện 2 ô — đáp án đúng (xanh) + bạn trả lời (đỏ)
                          : Column(
                              children: [
                                _filledBox(
                                  leading: const Icon(Icons.check,
                                      color: Colors.green),
                                  text:
                                      "Đáp án đúng: ${widget.question.correct}",
                                  bg: Colors.green.shade100,
                                  fg: Colors.green,
                                ),
                                const SizedBox(height: 8),
                                _filledBox(
                                  leading: const Icon(Icons.close,
                                      color: Colors.red),
                                  text: "Bạn trả lời: ${widget.answer!.answer}",
                                  bg: Colors.red.shade100,
                                  fg: Colors.red,
                                ),
                              ],
                            ))
                      : TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: "Nhập câu trả lời",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onChanged: (value) {
                            widget.onAnswerSelected?.call(value);
                            setState(() {
                              _savedAnswer = value;
                            });
                          },
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filledBox({
    required Widget leading,
    required String text,
    required Color bg,
    required Color fg,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: fg, width: 2),
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
