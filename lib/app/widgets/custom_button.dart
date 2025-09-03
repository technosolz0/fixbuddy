import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primaryColor,
        foregroundColor: textColor ?? AppColors.blackColor,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
