import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/customListTile.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Bookings', centerTitle: true),
      body: Stack(
        children: [
          // Top gradient background
          Container(
            height: size.height * 0.25,
            decoration: BoxDecoration(
              gradient: context.isLightTheme
                  ? AppColors.lightThemeGradient
                  : AppColors.darkThemeGradient,
            ),
          ),

          // Booking list
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(height: 16),
                _buildBookingCard(
                  title: 'AC Repair Service',
                  status: 'Completed',
                  date: '25 Jun 2025',
                  price: '₹1200',
                ),
                const SizedBox(height: 12),
                _buildBookingCard(
                  title: 'Pest Control',
                  status: 'Scheduled',
                  date: '30 Jun 2025',
                  price: '₹1500',
                ),
                const SizedBox(height: 12),
                _buildBookingCard(
                  title: 'Salon at Home',
                  status: 'Cancelled',
                  date: '20 Jun 2025',
                  price: '₹800',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Booking card widget
  Widget _buildBookingCard({
    required String title,
    required String status,
    required String date,
    required String price,
  }) {
    Color statusColor;

    switch (status) {
      case 'Completed':
        statusColor = Colors.green;
        break;
      case 'Scheduled':
        statusColor = Colors.orange;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CustomListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$date  •  ₹$price',
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
          ),
        ),
        onTap: () {
          // action
        },
      ),
    );
  }
}
