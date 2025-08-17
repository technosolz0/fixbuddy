import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/widgets/custom_app_bar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification', centerTitle: true),
      body: Center(
        child: Text(
          "Notification",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
