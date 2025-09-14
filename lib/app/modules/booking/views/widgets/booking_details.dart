import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/booking/controllers/booking_controller.dart';

class BookingDetailView extends StatelessWidget {
  final int bookingId;

  const BookingDetailView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    controller.fetchAllBookingDetails(bookingId);

    return Scaffold(
      backgroundColor: AppColors.lightGrayColor,
      appBar: CustomAppBar(title: 'Booking Details', centerTitle: true),
      body: Obx(() {
        if (controller.isLoadingBooking.value ||
            controller.isLoadingPayment.value ||
            controller.isLoadingVendor.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: AppColors.errorColor),
            ),
          );
        }

        final booking = controller.bookingDetails.value;
        final payment = controller.paymentDetails.value;
        final vendor = controller.vendorDetails.value;

        if (booking == null) {
          return const Center(child: Text('No booking details available'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(booking.status),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildDetailsCard(
                      'Booking Information',
                      Icons.receipt_long,
                      [
                        _buildInfoRow(
                          'Booking ID',
                          '#${booking.id}',
                          Icons.tag,
                        ),
                        _buildInfoRow(
                          'User ID',
                          booking.userId.toString(),
                          Icons.person_outline,
                        ),
                        _buildInfoRow(
                          'Vendor ID',
                          booking.serviceproviderId.toString(),
                          Icons.storefront,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (payment != null)
                      _buildDetailsCard('Payment Details', Icons.credit_card, [
                        _buildInfoRow(
                          'Amount',
                          '₹${payment.amount}',
                          Icons.currency_rupee,
                        ),
                        _buildInfoRow(
                          'Payment Status',
                          payment.status,
                          Icons.check_circle_outline,
                        ),
                      ]),
                    if (payment == null)
                      const Text('No payment details available'),
                    const SizedBox(height: 20),
                    if (vendor != null)
                      _buildDetailsCard('Vendor Details', Icons.person, [
                        _buildInfoRow('Name', vendor.name, Icons.person),
                        _buildInfoRow('Email', vendor.email, Icons.email),
                        _buildInfoRow('Phone', vendor.phone, Icons.phone),
                        _buildInfoRow(
                          'Address',
                          '${vendor.address}, ${vendor.city}',
                          Icons.location_on,
                        ),
                      ]),
                    if (vendor == null)
                      const Text('No vendor details available'),
                    const SizedBox(height: 20),

                    // Conditionally show the rating section
                    if (booking.status == 'Completed')
                      _buildRatingAndFeedbackSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // --- Helper Widgets for the Redesign ---

  Widget _buildHeaderSection(String status) {
    Color statusColor = AppColors.grayColor;
    if (status == 'Completed') {
      statusColor = AppColors.successColor;
    } else if (status == 'Pending') {
      statusColor = AppColors.warningColor;
    } else if (status == 'Cancelled') {
      statusColor = AppColors.errorColor;
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.lightThemeGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
        children: [
          const Text(
            'Booking Confirmed!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryColor),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const DashedLine(),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // New Widget for the Rating and Feedback Section
  Widget _buildRatingAndFeedbackSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Rate Your Experience',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star_rounded,
                  color: AppColors.primaryColor,
                  size: 35,
                );
              }),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Leave a feedback...',
                hintStyle: TextStyle(
                  color: AppColors.textColor.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.lightGrayColor,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logic to submit rating and feedback
                Get.snackbar(
                  'Thank You!',
                  'Your feedback has been submitted.',
                  backgroundColor: AppColors.successColor,
                  colorText: AppColors.whiteColor,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom DashedLine Widget for a receipt-like effect
class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 8.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1.5,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.grayColor),
              ),
            );
          }),
        );
      },
    );
  }
}
