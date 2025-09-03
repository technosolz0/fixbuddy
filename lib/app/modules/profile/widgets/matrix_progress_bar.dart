import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatrixProgressBar extends StatelessWidget {
  const MatrixProgressBar({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    this.isDetail = false,
  });

  final int min;
  final int max;
  final int value;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    final double conWidth = isDetail ? 302.w : 251.w;
    final double percentage = ((value - min) / (max - min)) * 100;
    final double progressBarWidth = (percentage * conWidth) / 100;

    return SizedBox(
      width: isDetail ? 302.w : 251.w,
      child: Stack(
        children: [
          Container(
            height: isDetail ? 16.h : 10.h,
            width: conWidth,
            decoration: BoxDecoration(
                color: isDetail ? Colors.white : const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(isDetail ? 8.r : 5.r)),
          ),
          Container(
            width: progressBarWidth,
            height: isDetail ? 16.h : 10.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isDetail ? 8.r : 5.r),
                gradient: const LinearGradient(
                  colors: [Color(0xff3b8f3e), Color(0xff84c886)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
          )
        ],
      ),
    );
  }
}
