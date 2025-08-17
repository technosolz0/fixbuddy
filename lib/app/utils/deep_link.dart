// import 'dart:async';
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:fixbuddy/app/routes/app_routes.dart';
// import 'package:fixbuddy/app/utils/servex_utils.dart';

class DeepLink {
  //   StreamSubscription<Uri>? _linkSubscription;

  //   Future initDeepLinks() async {
  //     AppLinks appLinksInstance = AppLinks();

  //     // Handling link's path using a listener
  //     _linkSubscription = appLinksInstance.uriLinkStream.listen(
  //       (uriValue) {
  //         // Got uri in foreground or background state
  //         String route = '';
  //         List<dynamic> args = [];
  //         (route, args) = getRouteNameFromURI(uriValue);
  //         handleDeeplinkNavigation(route, args);
  //       },
  //       onError: (err) {
  //         ServexUtils.dPrint('--->deeplink: error : $err');
  //       },
  //       onDone: () {
  //         _linkSubscription?.cancel();
  //       },
  //     );
  //   }

  //   // To get the Route name and it's arguments from the URI of deeplink
  //   (String, List<dynamic>) getRouteNameFromURI(Uri uri) {
  //     String path = uri.path;
  //     Map<String, dynamic> queries = uri.queryParameters;
  //     String defaultRoute = '';
  //     try {
  //       ServexUtils.dPrint(
  //           '--->deeplink: routing to path: $path with queries: $queries');
  //       if (path == '/settings') {
  //         return (Routes.SETTINGS, []);
  //       }
  //       if (path == '/notifications') {
  //         return (Routes.NOTIFICATIONS, []);
  //       }
  //       if (path == '/${AppConstants.taskReminderDLPath}') {
  //         String? encodedTaskID = queries[AppConstants.taskReminderDLIDQuery];
  //         if (encodedTaskID == null) {
  //           return (defaultRoute, []);
  //         }
  //         String taskID = utf8.fuse(base64).decode(encodedTaskID);
  //         ServexUtils.dPrint(
  //             '--->deeplink: fetched taskID at path: $path is $taskID');
  //         return (AppConstants.taskReminderDLPath, [taskID]);
  //       }
  //     } catch (e) {
  //       ServexUtils.showSnackbar(
  //           SnackType.INFO, 'There was some issue with the link!');
  //       return (defaultRoute, []);
  //     }

  //     return (defaultRoute, []);
  //   }

  //   /// To handle deeplink navigation
  //   static Future handleDeeplinkNavigation(
  //       String path, List<dynamic> args) async {
  //     if (path.isEmpty) {
  //       return;
  //     } else if (path == AppConstants.taskReminderDLPath && args.isNotEmpty) {
  //       // If a task reminder, then first search the task from local list
  //       String taskId = args[0];
  //       final HomeController homeController = Get.find<HomeController>();
  //       TaskModel? task;
  //       for (int i = 0; i < homeController.tasks.length; i++) {
  //         if (taskId == homeController.tasks[i].id) {
  //           task = homeController.tasks[i];
  //           break;
  //         }
  //       }

  //       if (task == null) {
  //         // No tasks were found for the taskId got from deep link
  //         ServexUtils.showSnackbar(SnackType.INFO, 'No tasks found for this link!');
  //         return;
  //       }

  //       // Then show the task input bottomsheet
  //       showTaskBottomSheet(
  //         task: task,
  //         forDate: task.frequency == TaskFrequency.daily ? DateTime.now() : null,
  //       );
  //       return;
  //     } else {
  //       // If other path, then route to provided path with its arguments
  //       Get.toNamed(path, arguments: args);
  //     }
  //   }
}
