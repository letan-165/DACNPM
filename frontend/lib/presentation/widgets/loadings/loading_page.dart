import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final String? text;
  final double size;

  const LoadingPage({
    super.key,
    this.text,
    this.size = 80,
  });

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Color> gradientColors = [
    Color(0xFF74EBD5),
    Color(0xFF9FACE6),
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: _controller,
                child: SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return SweepGradient(
                        colors: gradientColors,
                        startAngle: 0.0,
                        endAngle: 6.3, // ~2*PI
                        tileMode: TileMode.clamp,
                      ).createShader(rect);
                    },
                    child: const CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        if (widget.text != null) ...[
          const SizedBox(height: 16),
          Text(
            widget.text!,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]
      ],
    );
  }
}
