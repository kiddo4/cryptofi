import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated Background
          SizedBox.expand(
            child: CustomAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 2 * 3.14159),
              duration: const Duration(seconds: 10),
              builder: (context, value, child) {
                return CustomPaint(
                  painter: StarfieldPainter(value),
                );
              },
              // onCompleted: (controller) => controller.repeat(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.rocket_launch,
                  size: 80,
                  color: Colors.white,
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(duration: 1.seconds)
                    .then()
                    .shake(),
                const SizedBox(height: 24),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'CryptoFi',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    onFinished: () {
                      Future.delayed(
                        const Duration(seconds: 1),
                        () => context.go('/login'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Gateway to the Crypto Universe',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ).animate().fadeIn(delay: 1.seconds),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarfieldPainter extends CustomPainter {
  final double animation;
  final stars = List.generate(100, (index) => _Star.random());

  StarfieldPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    
    for (var star in stars) {
      final point = star.getPosition(animation, size);
      final opacity = (star.speed * 0.8).clamp(0.1, 1.0);
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(point, star.size, paint);
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) => true;
}

class _Star {
  final double x;
  final double y;
  final double speed;
  final double size;

  _Star(this.x, this.y, this.speed, this.size);

  factory _Star.random() {
    return _Star(
      _randomDouble(0, 1),
      _randomDouble(0, 1),
      _randomDouble(0.1, 1),
      _randomDouble(0.5, 2),
    );
  }

  Offset getPosition(double animation, Size size) {
    final progress = (animation * speed) % 1.0;
    return Offset(
      x * size.width,
      (y + progress) * size.height,
    );
  }

  static double _randomDouble(double min, double max) {
    return min + (max - min) * (DateTime.now().microsecondsSinceEpoch % 1000) / 1000;
  }
}
