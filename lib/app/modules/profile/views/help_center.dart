// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:health_parliament/app/utils/constants.dart';
// import 'package:health_parliament/app/utils/firebase_analytics.dart';

// import '../../../utils/theme.dart';

// class HelpCenter extends StatefulWidget {
//   const HelpCenter({super.key});

//   @override
//   State<HelpCenter> createState() => _HelpCenterState();
// }

// class _HelpCenterState extends State<HelpCenter> {
//   @override
//   void initState() {
//     super.initState();
//     // FAnalytics.logScreen(screenName: 'Help Center');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Help Center',
//           style: TextStyle(
//               fontSize: 22.sp,
//               fontWeight: FontWeight.w700,
//               color: ThemeClass.blackColor),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: AppConstants.helpCenterFaqs.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   color: ThemeClass.shadowColor,
//                   blurRadius: 3.r,
//                   offset: const Offset(0, 1))
//             ], color: Colors.white),
//             child: ExpansionTile(
//               shape: Border.all(color: Colors.transparent),
//               title: Text(
//                 AppConstants.helpCenterFaqs[index]['q'],
//                 style: TextStyle(fontSize: 16.sp, color: Colors.black),
//               ),
//               children: <Widget>[
//                 Container(
//                   color: Colors.grey.shade100,
//                   padding: EdgeInsets.all(20.w),
//                   child: Text(
//                     AppConstants.helpCenterFaqs[index]['a'],
//                     style: TextStyle(
//                         fontSize: 13.sp, color: ThemeClass.blackColor),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
