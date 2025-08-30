import 'package:flutter/material.dart';
import 'package:frontend/data/models/dto/AnswerItem.dart';

class CardReviewSubmit extends StatelessWidget {
  final int index;
  final AnswerItem answer;

  const CardReviewSubmit({
    super.key,
    required this.answer,
    required this.index,
  });

  Color getCardColor() {
    return answer.type == 'SELECT'
        ? Colors.blue.shade50
        : Colors.orange.shade50;
  }

  IconData getIcon() {
    return answer.type == 'SELECT' ? Icons.check_circle_outline : Icons.edit;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: getCardColor(),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: getCardColor().withOpacity(0.6),
              width: 1.2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon loại câu hỏi
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(
                  getIcon(),
                  size: 28,
                  color: Colors.indigoAccent,
                ),
              ),
              const SizedBox(width: 16),
              // Nội dung câu hỏi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Câu $index: ${answer.title}".replaceAll("=@=", "____"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        answer.type == "SELECT" ? "Chọn đáp án" : "Nhập đáp án",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Đáp án: ${answer.answer}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
