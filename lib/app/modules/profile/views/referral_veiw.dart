import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:fixbuddy/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferralView extends StatefulWidget {
  final String code;
  final int remainingReferrals;
  final int totalPoints;
  final int referralActionPoints;
  const ReferralView({
    super.key,
    required this.code,
    required this.remainingReferrals,
    required this.totalPoints,
    required this.referralActionPoints,
  });

  @override
  State<ReferralView> createState() => _ReferralViewState();
}

class _ReferralViewState extends State<ReferralView> {
  @override
  void initState() {
    super.initState();
    // FAnalytics.logScreen(screenName: 'Refer Friend');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 60.h, left: 20.w),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Refer to a friend",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Earn ${widget.referralActionPoints} points",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(AssetsConstants.refHorn, height: 105.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 59.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Steps To Follow",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                        for (int i = 0; i < 2; i++)
                          SizedBox(
                            height: 80.h,
                            child: TimelineTile(
                              isFirst: i == 0,
                              isLast: i == 1,
                              beforeLineStyle: LineStyle(
                                thickness: 2.w,
                                color: AppColors.primaryColor,
                              ),
                              indicatorStyle: IndicatorStyle(
                                indicator: Container(
                                  height: 50.w,
                                  width: 50.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: i == 0
                                      ? Image.asset(AssetsConstants.refLink)
                                      : Image.asset(AssetsConstants.refStar),
                                ),
                                width: 50.w,
                                height: 50.w,
                                color: AppColors.primaryColor,
                              ),
                              endChild: Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Text(
                                  i == 0
                                      ? "Invite your friend to download the app using the referral code."
                                      : "You get ${widget.referralActionPoints} points once your friend registers on the app.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 15.h),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                offset: const Offset(0, 1),
                                blurRadius: 6.r,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 16.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Remaining Referrals",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                height: 36.h,
                                width: 36.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.primaryColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Text(
                                  widget.remainingReferrals.toString(),
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          "Invite Code",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: widget.code));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowColor,
                                  offset: const Offset(0, 1),
                                  blurRadius: 6.r,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 16.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.code,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Image.asset(
                                  AssetsConstants.refCopy,
                                  height: 24.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Send Invite",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomButton(
                          onPressed: () {
                            ServexUtils.share(
                              "Hello! Sign up on Health Parliament App using my referral ${widget.code} and join world’s largest community of healthcare professionals.${AppConstants.shareLink}",
                            );
                          },
                          text: "Share your code",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 20.w,
                right: 20.w,
                top: 125.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.black.withOpacity(0.16),
                        color: Colors.black.withValues(alpha: 0.16 * 255),

                        offset: const Offset(0, 1),
                        blurRadius: 6.r,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(AssetsConstants.coin, height: 49.h),
                      SizedBox(width: 10.w),
                      Text(
                        "Total Points\nEarned",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 7.h,
                          horizontal: 13.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${widget.totalPoints}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              "pts",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
