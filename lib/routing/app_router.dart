import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/auth/presentation/group_detail_screen.dart';
import '../features/auth/presentation/add_expense_screen.dart';
import '../features/auth/presentation/bills_reminders_screen.dart';
import '../features/auth/presentation/settle_up_screen.dart';
import '../features/auth/presentation/chores_screen.dart';
import '../features/auth/presentation/dispute_log_screen.dart';
import '../features/auth/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.asData?.value != null;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/group-detail',
        builder: (context, state) => const GroupDetailScreen(),
      ),
      GoRoute(
        path: '/add-expense',
        builder: (context, state) => const AddExpenseScreen(),
      ),
      GoRoute(
        path: '/bills-reminders',
        builder: (context, state) => const BillsRemindersScreen(),
      ),
      GoRoute(
        path: '/settle-up',
        builder: (context, state) => const SettleUpScreen(),
      ),
      GoRoute(
        path: '/chores',
        builder: (context, state) => const ChoresScreen(),
      ),
      GoRoute(
        path: '/dispute-log',
        builder: (context, state) => const DisputeLogScreen(),
      ),
    ],
  );
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const darkGreen = Color(0xFF13332B);
    const goldenYellow = Color(0xFFE8A033);
    const oweRed = Color(0xFFD9534F);
    const owedGreen = Color(0xFF4E8D6D);

    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE1),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: darkGreen,
              borderRadius: BorderRadius.circular(32),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Hello,',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.logout, color: Colors.white70, size: 20),
                                  onPressed: () => ref.read(authRepositoryProvider).signOut(),
                                ),
                              ],
                            ),
                            const Text(
                              'Mrinmoye Rahman',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/settle-up'),
                                    child: _buildBalanceBox(
                                      'You are owed',
                                      '\$125',
                                      owedGreen,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/settle-up'),
                                    child: _buildBalanceBox(
                                      'You owe',
                                      '\$43',
                                      oweRed,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildQuickActionButton(
                              icon: Icons.receipt_long_outlined,
                              label: 'Bills',
                              onTap: () => context.push('/bills-reminders'),
                            ),
                            _buildQuickActionButton(
                              icon: Icons.cleaning_services_outlined,
                              label: 'Chores',
                              onTap: () => context.push('/chores'),
                            ),
                            _buildQuickActionButton(
                              icon: Icons.flag_outlined,
                              label: 'Disputes',
                              onTap: () => context.push('/dispute-log'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFAF7F2),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Groups',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: ListView(
                                  children: [
                                    GestureDetector(
                                      onTap: () => context.push('/group-detail'),
                                      child: _buildGroupCard(
                                        code: 'FM',
                                        name: 'Flatmates',
                                        members: '3 members',
                                        amount: '-\$43',
                                        subtitle: 'you owe',
                                        badgeColor: goldenYellow,
                                        amountColor: oweRed,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    _buildGroupCard(
                                      code: 'OL',
                                      name: 'Office Lunch',
                                      members: '6 members',
                                      amount: '\$0',
                                      subtitle: 'settled',
                                      badgeColor: const Color(0xFF6B5B95),
                                      amountColor: Colors.grey,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildGroupCard(
                                      code: 'FT',
                                      name: 'Friends Trip',
                                      members: '5 members',
                                      amount: '+\$82',
                                      subtitle: "you're owed",
                                      badgeColor: darkGreen,
                                      amountColor: owedGreen,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: goldenYellow,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.black, size: 28),
                        onPressed: () => context.push('/add-expense'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFE8A033), size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  static Widget _buildBalanceBox(String label, String amount, Color amountColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E4238),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildGroupCard({
    required String code,
    required String name,
    required String members,
    required String amount,
    required String subtitle,
    required Color badgeColor,
    required Color amountColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              code,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  members,
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.black45, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}