// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:health_parliament/app/modules/profile/models/redeem_tile_model.dart';
// import 'package:health_parliament/app/modules/profile/views/redeem_detail_view.dart';
// import 'package:health_parliament/app/utils/constants.dart';
// import 'package:health_parliament/app/utils/theme.dart';
// import 'package:intl/intl.dart';

// class RedeemTile extends StatelessWidget {
//   const RedeemTile({super.key, required this.reward});

//   final RedeemTileModel reward;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => RedeemDetailView(
//               reward: reward,
//             ));
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 18.h),
//         height: reward.points == null ? 118.h : 158.h,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(reward.points == null
//                   ? AssetsConstants.redeemedRewardBg
//                   : AssetsConstants.availableRewardBg),
//               fit: BoxFit.fitWidth,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: ThemeClass.shoadowColor09,
//                 blurRadius: 5.r,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//             borderRadius: BorderRadius.circular(16.r)),
//         child: Row(children: [
//           SizedBox(
//             width: 114.9.w,
//             child: Center(
//                 child: SizedBox(
//               height: 55.h,
//               width: 55.w,
//               child: CachedNetworkImage(
//                 imageUrl: reward.img,
//                 imageBuilder: (context, imageProvider) => Container(
//                   height: 55.h,
//                   width: 55.w,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: imageProvider, fit: BoxFit.cover),
//                   ),
//                 ),
//                 placeholder: (context, url) => const Center(
//                     child: CircularProgressIndicator(
//                   color: Colors.white,
//                 )),
//                 errorWidget: (context, url, error) =>
//                     const Center(child: Icon(Icons.error)),
//               ),
//             )),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 reward.title,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w600,
//                   color: ThemeClass.primaryColor,
//                 ),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               SizedBox(
//                   width: 175.w,
//                   child: Text(
//                     reward.description,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       color: ThemeClass.blackColor,
//                     ),
//                   )),
//               SizedBox(
//                 height: 10.h,
//               ),
//               if (reward.points != null)
//                 Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                   margin: EdgeInsets.only(bottom: 5.h),
//                   decoration: BoxDecoration(
//                       color: ThemeClass.ffe1e9eb,
//                       borderRadius: BorderRadius.circular(5.r)),
//                   child: Row(children: [
//                     Image.asset(
//                       AssetsConstants.coin,
//                       width: 22.w,
//                       height: 22.h,
//                     ),
//                     SizedBox(
//                       width: 6.w,
//                     ),
//                     Text(
//                       reward.points!.toString(),
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w700,
//                         color: ThemeClass.primaryColor,
//                       ),
//                     )
//                   ]),
//                 ),
//               Text(
//                 'Valid Upto: ${DateFormat('dd MMM').format(reward.expiry)}',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                   color: ThemeClass.primaryColor,
//                 ),
//               )
//             ]),
//           )
//         ]),
//       ),
//     );
//   }
// }
