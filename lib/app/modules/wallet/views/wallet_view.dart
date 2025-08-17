import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Dummy transactions
    final List<Map<String, dynamic>> transactions = [
      {
        'title': 'Booking Payment',
        'amount': '- ₹500',
        'date': '27 Jun, 2025',
        'type': 'debit',
      },
      {
        'title': 'Referral Bonus',
        'amount': '+ ₹100',
        'date': '26 Jun, 2025',
        'type': 'credit',
      },
      {
        'title': 'Wallet Top-Up',
        'amount': '+ ₹2000',
        'date': '24 Jun, 2025',
        'type': 'credit',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Wallet', centerTitle: true),
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: size.height * 0.25,
            decoration: BoxDecoration(
              gradient: context.isLightTheme
                  ? AppColors.lightThemeGradient
                  : AppColors.darkThemeGradient,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wallet Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Available Balance',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '₹ 2,400.00',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Transaction List
                  Expanded(
                    child: ListView.separated(
                      itemCount: transactions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        final isCredit = tx['type'] == 'credit';
                        return CustomListTile(
                          title: Text(
                            tx['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            tx['date'],
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: Text(
                            tx['amount'],
                            style: TextStyle(
                              color: isCredit ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            // View transaction detail if needed
                          },
                          backgroundColor: AppColors.whiteColor,
                          borderRadius: 12,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
