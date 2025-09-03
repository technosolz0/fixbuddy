// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomCard extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final List<Widget> children;

  const BottomCard({
    Key? key,
    required this.title,
    required this.children,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 1),
              blurRadius: 6.r)
        ],
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            titleWidget ?? const SizedBox.shrink(),
            if (title != '')
              Text(
                title,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
          ],
        ),
        ...children
      ]),
    );
  }
}
