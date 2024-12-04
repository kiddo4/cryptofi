import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bip39/bip39.dart' as bip39;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  String? _mnemonic;
  bool _showSeedPhrase = false;

  @override
  void initState() {
    super.initState();
    _generateSeedPhrase();
  }

  void _generateSeedPhrase() {
    setState(() {
      _mnemonic = bip39.generateMnemonic();
    });
  }

  Future<void> _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Store seed phrase securely
      await _storage.write(key: 'seed_phrase', value: _mnemonic);
      // Navigate to home after signup
      if (mounted) {
        context.go('/home');
      }
    }
  }

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
              // onComplete: (controller) => controller.repeat(),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Join the Cosmic\nCrypto Journey',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn().slideY(begin: -0.2),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelStyle: const TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 200.milliseconds),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelStyle: const TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 400.milliseconds),
                    const SizedBox(height: 24),
                    if (_showSeedPhrase) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.purple),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Your Seed Phrase',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _mnemonic ?? '',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                  text: _mnemonic ?? '',
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Seed phrase copied!'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy),
                              label: const Text('Copy Seed Phrase'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 900.milliseconds),
                    ],
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (!_showSeedPhrase) {
                          setState(() => _showSeedPhrase = true);
                        } else {
                          _signup();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _showSeedPhrase ? 'Complete Signup' : 'Generate Wallet',
                      ),
                    ).animate().fadeIn(delay: 1100.milliseconds),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ).animate().fadeIn(delay: 1300.milliseconds),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
