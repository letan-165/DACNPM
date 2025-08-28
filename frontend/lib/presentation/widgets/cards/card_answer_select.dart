import 'package:flutter/material.dart';

class CardAnswerSelect extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool? isCorrect;
  final bool isReview;
  final VoidCallback? onTap;

  const CardAnswerSelect({
    super.key,
    required this.option,
    required this.isSelected,
    this.isCorrect,
    this.isReview = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey.shade400;
    Color? fillColor;

    if (isReview) {
      if (isCorrect == true) {
        borderColor = Colors.green;
        fillColor = Colors.green.shade100;
      } else if (isSelected) {
        borderColor = Colors.red;
        fillColor = Colors.red.shade100;
      }
    } else if (isSelected) {
      borderColor = Colors.deepPurple;
      fillColor = Colors.deepPurple.shade100;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: fillColor ?? Colors.white,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(option, style: const TextStyle(fontSize: 16)),
            ),
            if (isReview && isCorrect == true)
              const Icon(Icons.check, color: Colors.green),
            if (isReview && isSelected && (isCorrect != true))
              const Icon(Icons.close, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
