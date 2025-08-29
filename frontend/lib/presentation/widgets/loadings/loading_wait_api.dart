import 'package:flutter/material.dart';

class LoadingWaitApi extends StatefulWidget {
  final String? text;
  final double width;

  const LoadingWaitApi({super.key, this.text, this.width = 250});

  @override
  State<LoadingWaitApi> createState() => _LoadingWaitApiState();
}

class _LoadingWaitApiState extends State<LoadingWaitApi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.width,
            height: 8,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: null,
                  minHeight: 8,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation(
                    HSVColor.fromAHSV(1, (_animation.value * 360) % 360, 1, 1)
                        .toColor(),
                  ),
                );
              },
            ),
          ),
          if (widget.text != null) ...[
            const SizedBox(height: 16),
            Text(
              widget.text!,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ]
        ],
      ),
    );
  }
}
