import 'package:flutter/material.dart';

import '../../../data/models/dto/Response/ResultResponse.dart';
import '../../utils/time_function.dart';

class ResultHistoryCard extends StatelessWidget {
  final ResultResponse result;
  final VoidCallback onTap;

  const ResultHistoryCard({
    super.key,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final percent =
        ((result.totalCorrect / result.totalQuestion) * 100).toStringAsFixed(0);

    final Duration? duration =
        result.finish?.difference(result.createAt ?? DateTime.now());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.orange.withOpacity(0.15),
                child: Icon(Icons.menu_book, size: 32, color: Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.quiz?.title ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Câu đúng: ${result.totalCorrect}/${result.totalQuestion} ",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        ),
                        Text(
                          "Tổng điểm: ${result.score.toStringAsFixed(1)} ",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Thời gian làm: ${formatDuration(duration!)}",
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
