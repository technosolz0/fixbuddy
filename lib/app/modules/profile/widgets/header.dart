// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/theme.dart';

class Header extends SliverPersistentHeaderDelegate {
  final Widget actions;
  final Widget? leading;
  Header({
    this.leading,
    required this.actions,
  });

  @override
  double get minExtent => 80.h;

  @override
  double get maxExtent => 130.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeClass.primaryColor,
        borderRadius: shrinkOffset == 0
            ? BorderRadius.only(
                bottomLeft: Radius.circular(47.r),
                bottomRight: Radius.circular(47.r),
              )
            : null,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading ??
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
              actions
            ],
          ),
        ),
      ),
    );
  }
}
