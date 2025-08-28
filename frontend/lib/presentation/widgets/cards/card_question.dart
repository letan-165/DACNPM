import 'package:flutter/material.dart';

import '../../../data/models/question.dart';
import '../../../data/models/result.dart'; // Answer
import 'card_answer_select.dart';

class CardQuestion extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool isReview = answer != null;

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
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
                "Câu ${currentIndex + 1}/$total",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                question.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              if (question.options.isNotEmpty)
                Column(
                  children: question.options.map((opt) {
                    bool showGreen = false;
                    bool showRed = false;

                    if (isReview) {
                      if (answer!.isCorrect) {
                        showGreen = (opt == answer!.answer);
                        showRed = false;
                      } else {
                        showGreen = (opt == question.correct);
                        showRed = (opt == answer!.answer);
                      }
                    }

                    return CardAnswerSelect(
                      option: opt,
                      isSelected: isReview ? showRed : (selectedAnswer == opt),
                      isCorrect: isReview ? showGreen : null,
                      isReview: isReview,
                      onTap:
                          isReview ? null : () => onAnswerSelected?.call(opt),
                    );
                  }).toList(),
                ),

              // --- CÂU ĐIỀN TỪ ---
              if (question.options.isEmpty)
                isReview
                    ? (answer!.isCorrect
                        // Đúng: chỉ hiện 1 ô xanh câu người học trả lời
                        ? _filledBox(
                            leading:
                                const Icon(Icons.check, color: Colors.green),
                            text: answer!.answer,
                            bg: Colors.green.shade100,
                            fg: Colors.green,
                          )
                        // Sai: hiện 2 ô — đáp án đúng (xanh) + bạn trả lời (đỏ)
                        : Column(
                            children: [
                              _filledBox(
                                leading: const Icon(Icons.check,
                                    color: Colors.green),
                                text: "Đáp án đúng: ${question.correct}",
                                bg: Colors.green.shade100,
                                fg: Colors.green,
                              ),
                              const SizedBox(height: 8),
                              _filledBox(
                                leading:
                                    const Icon(Icons.close, color: Colors.red),
                                text: "Bạn trả lời: ${answer!.answer}",
                                bg: Colors.red.shade100,
                                fg: Colors.red,
                              ),
                            ],
                          ))
                    : TextField(
                        decoration: InputDecoration(
                          labelText: "Nhập câu trả lời",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onChanged: onAnswerSelected,
                      ),
            ],
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
