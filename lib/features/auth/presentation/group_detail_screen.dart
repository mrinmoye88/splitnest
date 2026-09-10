import 'package:flutter/material.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF13332B);
    const goldenYellow = Color(0xFFE8A033);
    const oweRed = Color(0xFFD9534F);
    const owedGreen = Color(0xFF4E8D6D);

    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGreen),
          onPressed: () => Navigator.of(context).pop(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Group Icon + Title
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: goldenYellow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'FM',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flatmates',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tanvir, Rafi, Mim',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Total spent  \$640',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Colors.black12),
                const SizedBox(height: 12),

                // Transactions List
                Expanded(
                  child: ListView(
                    children: [
                      _buildTransactionTile(
                        dateDay: '04',
                        dateMonth: 'SEP',
                        title: 'Groceries',
                        subtitle: 'Paid by Rafi · split 3 ways',
                        status: 'You owe',
                        amount: '\$43',
                        statusColor: oweRed,
                      ),
                      const Divider(height: 24, color: Colors.black12),
                      _buildTransactionTile(
                        dateDay: '02',
                        dateMonth: 'SEP',
                        title: 'Rent – September',
                        subtitle: 'Paid by you · split 3 ways',
                        status: "You're owed",
                        amount: '\$210',
                        statusColor: owedGreen,
                      ),
                      const Divider(height: 24, color: Colors.black12),
                      _buildTransactionTile(
                        dateDay: '29',
                        dateMonth: 'AUG',
                        title: 'Internet bill',
                        subtitle: 'Paid by Mim · split 3 ways',
                        status: 'You owe',
                        amount: '\$20',
                        statusColor: oweRed,
                      ),
                    ],
                  ),
                ),

                // Settle Up Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Settle Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  Widget _buildTransactionTile({
    required String dateDay,
    required String dateMonth,
    required String title,
    required String subtitle,
    required String status,
    required String amount,
    required Color statusColor,
  }) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              dateDay,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              dateMonth,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.black45, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}