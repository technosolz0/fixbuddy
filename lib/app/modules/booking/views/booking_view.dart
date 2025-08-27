import 'package:fixbuddy/app/modules/booking/views/widgets/booking_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/constants/app_color.dart'; // Ensure this path is correct
import 'package:fixbuddy/app/modules/booking/controllers/booking_controller.dart';
import 'package:fixbuddy/app/modules/booking/models/booking_model.dart';
import 'package:fixbuddy/app/utils/extensions.dart'; // Assuming this is for context.isLightTheme
import 'package:fixbuddy/app/widgets/customListTile.dart'; // Keep this if you're using it, but we'll rebuild the card logic
import 'package:fixbuddy/app/widgets/custom_app_bar.dart'; // Your custom app bar

class BookingView extends StatelessWidget {
  BookingView({super.key});

  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    controller.fetchAllBookings();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: 'My Bookings', centerTitle: true),
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

          // Booking list with RefreshIndicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() {
              if (controller.isLoadingAllBookings.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: AppColors.errorColor),
                  ),
                );
              }

              if (controller.allBookings.isEmpty) {
                return const Center(
                  child: Text(
                    "No bookings found",
                    style: TextStyle(color: AppColors.grayColor, fontSize: 16),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchAllBookings(),
                color: AppColors.primaryColor,
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16.0),
                  itemCount: controller.allBookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final booking = controller.allBookings[index];
                    return _buildBookingCard(
                      title: booking.subcategory.name, // Service Name
                      status: booking.status,
                      date: booking.scheduledTime != null
                          ? booking.scheduledTime!.toLocal().toString().split(
                              ' ',
                            )[0]
                          : "Not Scheduled",
                      price: "₹1200", // Placeholder
                      booking: booking,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // --- New and improved _buildBookingCard widget ---
  Widget _buildBookingCard({
    required String title,
    required String status,
    required String date,
    required String price,
    required BookingResponse booking,
  }) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Completed':
        statusColor = AppColors.successColor;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'Scheduled':
        statusColor = AppColors.warningColor;
        statusIcon = Icons.pending_actions_rounded;
        break;
      case 'Cancelled':
        statusColor = AppColors.errorColor;
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusColor = AppColors.grayColor;
        statusIcon = Icons.info_outline;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => BookingDetailView(bookingId: booking.id));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusTag(status, statusColor, statusIcon),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 16,
                    color: AppColors.grayColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.currency_rupee_rounded,
                    size: 16,
                    color: AppColors.grayColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build the status tag
  Widget _buildStatusTag(String status, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
