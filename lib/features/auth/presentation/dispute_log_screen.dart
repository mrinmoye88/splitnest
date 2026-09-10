import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/dispute_model.dart';
import '../../../providers/firestore_provider.dart';

class DisputeLogScreen extends ConsumerWidget {
  const DisputeLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const darkGreen = Color(0xFF13332B);
    const oweRed = Color(0xFFD9534F);

    final disputesAsync = ref.watch(disputesStreamProvider);

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
          'Dispute Log',
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
                disputesAsync.when(
                  data: (disputes) {
                    if (disputes.isEmpty) {
                      return const Center(child: Text('No disputes logged yet.'));
                    }
                    return ListView.separated(
                      itemCount: disputes.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final dispute = disputes[index];
                        final isOpen = dispute.status.toLowerCase() == 'open';

                        return _buildDisputeCard(
                          title: dispute.title,
                          reason: dispute.reason,
                          footer: dispute.footerText,
                          status: dispute.status,
                          statusBgColor: isOpen ? const Color(0xFFFDE8E4) : const Color(0xFFE2F0D9),
                          statusTextColor: isOpen ? oweRed : const Color(0xFF4E8D6D),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),

                // Floating Flag Button
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: oweRed,
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
                      icon: const Icon(Icons.flag, color: Colors.white, size: 24),
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

  Widget _buildDisputeCard({
    required String title,
    required String reason,
    required String footer,
    required String status,
    required Color statusBgColor,
    required Color statusTextColor,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            reason,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            footer,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}