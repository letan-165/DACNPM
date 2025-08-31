import 'dart:async';

import 'package:flutter/material.dart';

class QuizTimer {
  late int _remainingTime;
  Timer? _timer;
  final ValueNotifier<int> _timeNotifier = ValueNotifier<int>(0);

  void create(int totalSeconds, {Function()? onFinish}) {
    _remainingTime = totalSeconds;
    _timeNotifier.value = _remainingTime;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        _timeNotifier.value = _remainingTime;
      } else {
        timer.cancel();
        if (onFinish != null) {
          onFinish();
        }
      }
    });
  }

  Widget buildTimerWidget({TextStyle? textStyle}) {
    return ValueListenableBuilder<int>(
      valueListenable: _timeNotifier,
      builder: (context, value, _) {
        final minutes = (value ~/ 60).toString().padLeft(2, '0');
        final seconds = (value % 60).toString().padLeft(2, '0');
        return Row(
          children: [
            const Icon(Icons.timer, color: Colors.red, size: 20),
            const SizedBox(width: 6),
            Text(
              "$minutes:$seconds",
              style: textStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
            ),
          ],
        );
      },
    );
  }

  void dispose() {
    _timer?.cancel();
  }
}
