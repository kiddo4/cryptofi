import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cryptofi/presentation/screens/splash/splash_screen.dart';
import 'package:cryptofi/presentation/screens/auth/login_screen.dart';
import 'package:cryptofi/presentation/screens/auth/signup_screen.dart';
import 'package:cryptofi/presentation/screens/home/home_screen.dart';
import 'package:cryptofi/presentation/screens/trade/trade_screen.dart';
import 'package:cryptofi/presentation/screens/portfolio/portfolio_screen.dart';
import 'package:cryptofi/presentation/screens/wallet/wallet_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/trade',
          builder: (context, state) => const TradeScreen(),
        ),
        GoRoute(
          path: '/transfer',
          builder: (context, state) => const WalletScreen(),
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) => const PortfolioScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.rocket_outlined),
            selectedIcon: Icon(Icons.rocket),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.candlestick_chart_outlined),
            selectedIcon: Icon(Icons.candlestick_chart),
            label: 'Trade',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transfer',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/trade');
              break;
            case 2:
              context.go('/transfer');
              break;
            case 3:
              context.go('/portfolio');
              break;
          }
        },
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/trade')) return 1;
    if (location.startsWith('/transfer')) return 2;
    if (location.startsWith('/portfolio')) return 3;
    return 0;
  }
}
