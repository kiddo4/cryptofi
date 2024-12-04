import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isSending = false;
  String _walletAddress = '0x742d35Cc6634C0532925a3b844Bc454e4438f44e';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showSuccessAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.purpleAccent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.rocket_launch,
                size: 80,
                color: Colors.purpleAccent,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scale(duration: 1.seconds)
                  .then()
                  .shake(),
              const SizedBox(height: 24),
              const Text(
                'Transaction Launched! 🚀',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your crypto is on its way to the stars!',
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue Exploring',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              // onCompleted: (controller) => controller.repeat(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.purpleAccent.withOpacity(0.3),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent,
                            Colors.purple.shade800,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purpleAccent.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.rocket_launch),
                          text: 'Send',
                        ),
                        Tab(
                          icon: Icon(Icons.rocket_outlined),
                          text: 'Receive',
                        ),
                      ],
                    ),
                  ).animate().slideY(
                        begin: -1,
                        duration: 500.milliseconds,
                        curve: Curves.easeOut,
                      ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Send Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.purpleAccent.withOpacity(0.3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purpleAccent.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _addressController,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Recipient Address',
                                      labelStyle: TextStyle(
                                        color: Colors.purpleAccent.withOpacity(0.7),
                                        fontSize: 16,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.purpleAccent.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.purpleAccent,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.05),
                                    ),
                                  ).animate().fadeIn(delay: 200.milliseconds),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _amountController,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    keyboardType: const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      labelStyle: TextStyle(
                                        color: Colors.purpleAccent.withOpacity(0.7),
                                        fontSize: 16,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.purpleAccent.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.purpleAccent,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.05),
                                    ),
                                  ).animate().fadeIn(delay: 400.milliseconds),
                                  const SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _isSending
                                          ? null
                                          : () {
                                              setState(() => _isSending = true);
                                              Future.delayed(
                                                const Duration(seconds: 2),
                                                () {
                                                  setState(() => _isSending = false);
                                                  _showSuccessAnimation();
                                                },
                                              );
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purpleAccent,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 8,
                                        shadowColor:
                                            Colors.purpleAccent.withOpacity(0.5),
                                      ),
                                      child: _isSending
                                          ? const SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'Launch Transaction 🚀',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ).animate().fadeIn(delay: 600.milliseconds),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Receive Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.purpleAccent.withOpacity(0.3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purpleAccent.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  QrImageView(
                                    data: _walletAddress,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                    backgroundColor: Colors.white,
                                  ).animate().scale(delay: 200.milliseconds),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'Your Wallet Address',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                        ClipboardData(text: _walletAddress),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Address copied to clipboard'),
                                          backgroundColor: Colors.purpleAccent,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.purpleAccent.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${_walletAddress.substring(0, 6)}...${_walletAddress.substring(_walletAddress.length - 4)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'monospace',
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.copy,
                                            color: Colors.purpleAccent,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).animate().fadeIn(delay: 400.milliseconds),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}

class StarfieldPainter extends CustomPainter {
  final double animation;
  final List<_Star> _stars = List.generate(100, (index) => _Star());

  StarfieldPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    for (var star in _stars) {
      final position = star.getPosition(animation, size);
      canvas.drawCircle(position, 1, paint);
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) =>
      animation != oldDelegate.animation;
}

class _Star {
  final double _x = _randomDouble(0, 1);
  final double _y = _randomDouble(0, 1);
  final double _z = _randomDouble(0, 1);

  Offset getPosition(double animation, Size size) {
    final progress = ((_z + animation) % 1) * 4 - 2;
    final distanceScale = (progress + 2) / 4;
    final x = size.width * (_x - 0.5) / distanceScale + size.width / 2;
    final y = size.height * (_y - 0.5) / distanceScale + size.height / 2;
    return Offset(x, y);
  }

  static double _randomDouble(double min, double max) {
    return min + (max - min) * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000;
  }
}
