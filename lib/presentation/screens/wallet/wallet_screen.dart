import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:particles_flutter/particles_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isProcessing = false;
  String _walletAddress = '0x742d35Cc6634C0532925a3b844Bc454e4438f44e';
  double _balance = 2.5; // Example balance

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showTransactionSuccess() {
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
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Transaction Launched! 🚀',
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your crypto is traveling through the cosmos!',
                style: TextStyle(color: Colors.grey[300]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Continue Exploring'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
          // CircularParticle(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   particleColor: Colors.white.withOpacity(.5),
          //   numberOfParticles: 50,
          //   speedOfParticles: 1,
          //   maxParticleSize: 3,
          //   awayRadius: 100,
          //   onTapAnimation: true,
          //   isRandSize: true,
          //   isRandomColor: false,
          //   connectDots: true,
          //   enableHover: true,
          // ),
          SafeArea(
            child: Column(
              children: [
                // Balance Card
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.8),
                        Colors.deepPurple.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.currency_bitcoin,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _balance.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().slideY(
                      begin: -1,
                      duration: 500.milliseconds,
                      curve: Curves.easeOut,
                    ),
                // Tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                      ),
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
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.purpleAccent.withOpacity(0.3),
                                ),
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _recipientController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Recipient Address',
                                      labelStyle: TextStyle(color: Colors.grey[400]),
                                      prefixIcon: const Icon(Icons.person_outline, color: Colors.purpleAccent),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Colors.grey[700]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.purpleAccent),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.05),
                                    ),
                                  ).animate().fadeIn(delay: 200.milliseconds),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _amountController,
                                    style: const TextStyle(color: Colors.white),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      labelStyle: TextStyle(color: Colors.grey[400]),
                                      prefixIcon: const Icon(Icons.currency_bitcoin, color: Colors.purpleAccent),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Colors.grey[700]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(color: Colors.purpleAccent),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.05),
                                    ),
                                  ).animate().fadeIn(delay: 400.milliseconds),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _isProcessing
                                          ? null
                                          : () {
                                              setState(() => _isProcessing = true);
                                              Future.delayed(
                                                const Duration(seconds: 2),
                                                () {
                                                  setState(() {
                                                    _isProcessing = false;
                                                    _balance -= double.tryParse(_amountController.text) ?? 0;
                                                  });
                                                  _showTransactionSuccess();
                                                },
                                              );
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purpleAccent,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: _isProcessing
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'Launch Transaction 🚀',
                                              style: TextStyle(fontSize: 16),
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
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.purpleAccent.withOpacity(0.3),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purpleAccent.withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: QrImageView(
                                      data: _walletAddress,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                      eyeStyle: const QrEyeStyle(
                                        eyeShape: QrEyeShape.square,
                                        color: Colors.purple,
                                      ),
                                      dataModuleStyle: const QrDataModuleStyle(
                                        dataModuleShape: QrDataModuleShape.square,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ).animate().scale(),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Your Cosmic Address',
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _walletAddress,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: _walletAddress));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Address copied to clipboard!'),
                                          backgroundColor: Colors.purple,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.copy),
                                    label: const Text('Copy Address'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.purpleAccent),
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
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
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
