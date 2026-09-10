import 'package:flutter/material.dart';

class BillsRemindersScreen extends StatelessWidget {
  const BillsRemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF13332B);
    const goldenYellow = Color(0xFFE8A033);

    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Bills & Reminders',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7F2),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: darkGreen, width: 2),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upcoming',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildBillCard(
                            icon: Icons.home_outlined,
                            iconBgColor: const Color(0xFFFDE8E4),
                            iconColor: const Color(0xFFD9534F),
                            title: 'Rent',
                            amount: '\$450',
                            subtitle: 'Due monthly · split 3 ways',
                            dueText: 'Due in 2 days',
                            dueBgColor: const Color(0xFFFCEBE6),
                            dueTextColor: const Color(0xFFD9534F),
                          ),
                          const SizedBox(height: 16),
                          _buildBillCard(
                            icon: Icons.signal_cellular_alt,
                            iconBgColor: const Color(0xFFFEF3D6),
                            iconColor: goldenYellow,
                            title: 'WiFi',
                            amount: '\$30',
                            subtitle: 'Due monthly · split 3 ways',
                            dueText: 'Due in 5 days',
                            dueBgColor: const Color(0xFFFCEBE6),
                            dueTextColor: const Color(0xFFD9534F),
                          ),
                          const SizedBox(height: 16),
                          _buildBillCard(
                            icon: Icons.bolt_outlined,
                            iconBgColor: const Color(0xFFFEF8DB),
                            iconColor: const Color(0xFFE8A033),
                            title: 'Electricity',
                            amount: '\$65',
                            subtitle: 'Due monthly · split evenly',
                            dueText: 'Due in 14 days',
                            dueBgColor: const Color(0xFFE2F0D9),
                            dueTextColor: const Color(0xFF4E8D6D),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // FAB Button
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: goldenYellow,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.black, size: 28),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBillCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String amount,
    required String subtitle,
    required String dueText,
    required Color dueBgColor,
    required Color dueTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: dueBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dueText,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: dueTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}