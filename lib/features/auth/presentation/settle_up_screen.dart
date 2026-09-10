import 'package:flutter/material.dart';

class SettleUpScreen extends StatefulWidget {
  const SettleUpScreen({super.key});

  @override
  State<SettleUpScreen> createState() => _SettleUpScreenState();
}

class _SettleUpScreenState extends State<SettleUpScreen> {
  int selectedPaymentMethod = 0; // 0: Cash, 1: bKash, 2: Bank

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF13332B);
    const oweRed = Color(0xFFD9534F);
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
          'Settle Up',
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Total Amount Header
                        const Text(
                          '\$43',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: oweRed,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Simplified — you only need 1 payment',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // SUGGESTED PLAN
                        _buildSectionHeader('SUGGESTED PLAN'),
                        const SizedBox(height: 8),
                        _buildPaymentRow('You → Rafi', '\$43', isHighlighted: true),

                        const SizedBox(height: 24),

                        // INSTEAD OF (3 IOUs)
                        _buildSectionHeader('INSTEAD OF (3 IOUs)'),
                        const SizedBox(height: 8),
                        _buildPaymentRow('You → Rafi', '\$20'),
                        const SizedBox(height: 10),
                        _buildPaymentRow('You → Mim', '\$15'),

                        const SizedBox(height: 28),

                        // Payment Methods Options
                        Row(
                          children: [
                            Expanded(child: _buildMethodButton(0, 'Cash')),
                            const SizedBox(width: 8),
                            Expanded(child: _buildMethodButton(1, 'bKash')),
                            const SizedBox(width: 8),
                            Expanded(child: _buildMethodButton(2, 'Bank')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Mark as Settled Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldenYellow,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Mark as Settled',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String title, String amount, {bool isHighlighted = false}) {
    const oweRed = Color(0xFFD9534F);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? oweRed : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodButton(int index, String label) {
    const darkGreen = Color(0xFF13332B);
    final isSelected = selectedPaymentMethod == index;

    return GestureDetector(
      onTap: () => setState(() => selectedPaymentMethod = index),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? darkGreen : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? darkGreen : Colors.black12,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}