import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @please_select_an_option.
  ///
  /// In en, this message translates to:
  /// **'Please select an option!'**
  String get please_select_an_option;

  /// No description provided for @input_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Input cannot be empty'**
  String get input_cannot_be_empty;

  /// No description provided for @cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'cannot be empty'**
  String get cannot_be_empty;

  /// No description provided for @is_invalid.
  ///
  /// In en, this message translates to:
  /// **'is invalid'**
  String get is_invalid;

  /// No description provided for @password_length_validation.
  ///
  /// In en, this message translates to:
  /// **'Password must contain 7 to 12 characters only'**
  String get password_length_validation;

  /// No description provided for @password_character_validation.
  ///
  /// In en, this message translates to:
  /// **'Password must contain atleast one letter, number and special character'**
  String get password_character_validation;

  /// No description provided for @password_didnt_match.
  ///
  /// In en, this message translates to:
  /// **'Password didn\'t match. Try again'**
  String get password_didnt_match;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @enter_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid mobile number'**
  String get enter_valid_number;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enter_email;

  /// No description provided for @otp_sent_to_email.
  ///
  /// In en, this message translates to:
  /// **'OTP has been sent to your email'**
  String get otp_sent_to_email;

  /// No description provided for @enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enter_otp;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @password_updated_success.
  ///
  /// In en, this message translates to:
  /// **'Your password has been updated successfully.'**
  String get password_updated_success;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get something_went_wrong;

  /// No description provided for @cannot_logout.
  ///
  /// In en, this message translates to:
  /// **'Cannot logout'**
  String get cannot_logout;

  /// No description provided for @please_select_time.
  ///
  /// In en, this message translates to:
  /// **'Please select a time duration'**
  String get please_select_time;

  /// No description provided for @input_amount_here.
  ///
  /// In en, this message translates to:
  /// **'Input Amount Here'**
  String get input_amount_here;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @learn_more.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learn_more;

  /// No description provided for @attempt_quiz.
  ///
  /// In en, this message translates to:
  /// **'Attempt Quiz'**
  String get attempt_quiz;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @blog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @your_category_goals.
  ///
  /// In en, this message translates to:
  /// **'Your <category> Goals'**
  String get your_category_goals;

  /// No description provided for @select_goal_type.
  ///
  /// In en, this message translates to:
  /// **'Select Goal Type'**
  String get select_goal_type;

  /// No description provided for @set_daily_reminder.
  ///
  /// In en, this message translates to:
  /// **'Set Daily Reminder'**
  String get set_daily_reminder;

  /// No description provided for @repeat_every.
  ///
  /// In en, this message translates to:
  /// **'Repeat Every'**
  String get repeat_every;

  /// No description provided for @set_date.
  ///
  /// In en, this message translates to:
  /// **'Set Date'**
  String get set_date;

  /// No description provided for @set_time.
  ///
  /// In en, this message translates to:
  /// **'Set Time'**
  String get set_time;

  /// No description provided for @please_set_reminder_time.
  ///
  /// In en, this message translates to:
  /// **'Please set a reminder time'**
  String get please_set_reminder_time;

  /// No description provided for @frequency_input_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Frequency input cannot be empty'**
  String get frequency_input_cannot_empty;

  /// No description provided for @of_every_month.
  ///
  /// In en, this message translates to:
  /// **'<date> of every month'**
  String get of_every_month;

  /// No description provided for @goal_setup_success.
  ///
  /// In en, this message translates to:
  /// **'Your goal has been set up successfully'**
  String get goal_setup_success;

  /// No description provided for @add_another_child.
  ///
  /// In en, this message translates to:
  /// **'Add Another Child'**
  String get add_another_child;

  /// No description provided for @your_childs_name.
  ///
  /// In en, this message translates to:
  /// **'Your Childs Name'**
  String get your_childs_name;

  /// No description provided for @your_childs_gender.
  ///
  /// In en, this message translates to:
  /// **'Your Childs Gender'**
  String get your_childs_gender;

  /// No description provided for @your_childs_dob.
  ///
  /// In en, this message translates to:
  /// **'Your Childs DOB'**
  String get your_childs_dob;

  /// No description provided for @task_submitted_success.
  ///
  /// In en, this message translates to:
  /// **'Task submitted successfully'**
  String get task_submitted_success;

  /// No description provided for @task_updated_success.
  ///
  /// In en, this message translates to:
  /// **'Task updated successfully'**
  String get task_updated_success;

  /// No description provided for @task_deleted_success.
  ///
  /// In en, this message translates to:
  /// **'Task deleted successfully'**
  String get task_deleted_success;

  /// No description provided for @challenge_submitted_success.
  ///
  /// In en, this message translates to:
  /// **'Challenge submitted successfully'**
  String get challenge_submitted_success;

  /// No description provided for @challenge_updated_success.
  ///
  /// In en, this message translates to:
  /// **'Challenge updated successfully'**
  String get challenge_updated_success;

  /// No description provided for @please_select_date.
  ///
  /// In en, this message translates to:
  /// **'Please select a date for your task'**
  String get please_select_date;

  /// No description provided for @complete_task.
  ///
  /// In en, this message translates to:
  /// **'Complete Task'**
  String get complete_task;

  /// No description provided for @how_to_get_reminders.
  ///
  /// In en, this message translates to:
  /// **'How would you like to get reminders?'**
  String get how_to_get_reminders;

  /// No description provided for @through_app_notifications.
  ///
  /// In en, this message translates to:
  /// **'Through App Notifications'**
  String get through_app_notifications;

  /// No description provided for @through_calendar.
  ///
  /// In en, this message translates to:
  /// **'Through Calendar'**
  String get through_calendar;

  /// No description provided for @challenge_missed.
  ///
  /// In en, this message translates to:
  /// **'Oops! Challenge Ended.'**
  String get challenge_missed;

  /// No description provided for @challenge_missed_desc.
  ///
  /// In en, this message translates to:
  /// **'You’ve been removed from the \'<name>\' challenge after missing your streak. Reach out to the challenger and ask them to send you the challenge again'**
  String get challenge_missed_desc;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @provide_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid number'**
  String get provide_valid_number;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirmation;

  /// No description provided for @task_delete_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this task?'**
  String get task_delete_confirmation;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @delete_account_message.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Delete account permanently?'**
  String get delete_account_message;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @your_journey.
  ///
  /// In en, this message translates to:
  /// **'Your <cat> Journey'**
  String get your_journey;

  /// No description provided for @tracking_period.
  ///
  /// In en, this message translates to:
  /// **'Tracking Period'**
  String get tracking_period;

  /// No description provided for @avg_step_count.
  ///
  /// In en, this message translates to:
  /// **'Avg. Step Count'**
  String get avg_step_count;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data;

  /// No description provided for @select_image.
  ///
  /// In en, this message translates to:
  /// **'Select a Photo'**
  String get select_image;

  /// No description provided for @from_gallery.
  ///
  /// In en, this message translates to:
  /// **'From Gallery'**
  String get from_gallery;

  /// No description provided for @from_camera.
  ///
  /// In en, this message translates to:
  /// **'From Camera'**
  String get from_camera;

  /// No description provided for @delete_request_submitted.
  ///
  /// In en, this message translates to:
  /// **'Your request has been submitted successfully'**
  String get delete_request_submitted;

  /// No description provided for @email_us_at.
  ///
  /// In en, this message translates to:
  /// **'Email us at'**
  String get email_us_at;

  /// No description provided for @unable_to_show_review.
  ///
  /// In en, this message translates to:
  /// **'Unable to show review dialog.'**
  String get unable_to_show_review;

  /// No description provided for @review_error_android.
  ///
  /// In en, this message translates to:
  /// **'Please make sure the Google Play Store is installed and your android version is Android 5 or higher.'**
  String get review_error_android;

  /// No description provided for @review_error_ios.
  ///
  /// In en, this message translates to:
  /// **'Please make sure the IOS version is 10.3 or higher'**
  String get review_error_ios;

  /// No description provided for @you_earned_badge.
  ///
  /// In en, this message translates to:
  /// **'You Earned a Badge!'**
  String get you_earned_badge;

  /// No description provided for @you_earned_badge_msg.
  ///
  /// In en, this message translates to:
  /// **'You\'ve just earned the \'<name>\' badge for consistently completing your tasks.'**
  String get you_earned_badge_msg;

  /// No description provided for @quiz_submitted.
  ///
  /// In en, this message translates to:
  /// **'Quiz Submitted'**
  String get quiz_submitted;

  /// No description provided for @quiz_score_msg.
  ///
  /// In en, this message translates to:
  /// **'Your quiz score is <score> out of <total>'**
  String get quiz_score_msg;

  /// No description provided for @topic_of_week.
  ///
  /// In en, this message translates to:
  /// **'Topic of the Week'**
  String get topic_of_week;

  /// No description provided for @badge_page_msg.
  ///
  /// In en, this message translates to:
  /// **'Earn exciting badges by consistently completing tasks in all categories'**
  String get badge_page_msg;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @posts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @upload_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from gallery'**
  String get upload_from_gallery;

  /// No description provided for @capture_from_camera.
  ///
  /// In en, this message translates to:
  /// **'Capture from camera'**
  String get capture_from_camera;

  /// No description provided for @record_from_camera.
  ///
  /// In en, this message translates to:
  /// **'Record from camera'**
  String get record_from_camera;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @desc_hint.
  ///
  /// In en, this message translates to:
  /// **'Let\'s hear your thoughts! Use \'@\' to tag your buddies....'**
  String get desc_hint;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @choose_category_msg.
  ///
  /// In en, this message translates to:
  /// **'Choose a category for your post'**
  String get choose_category_msg;

  /// No description provided for @manual_steps_ip_not_installed_msg_android.
  ///
  /// In en, this message translates to:
  /// **'We\'re not able to detect the Health Connect app. Please make sure that your device has Health Connect app installed and it is connected to device\'s default Health app.'**
  String get manual_steps_ip_not_installed_msg_android;

  /// No description provided for @manual_steps_ip_msg_android.
  ///
  /// In en, this message translates to:
  /// **'We\'re not able to fetch your steps automatically from the Health Connect app. Please make sure that your device has Health Connect app installed and it is connected to device\'s default Health app.'**
  String get manual_steps_ip_msg_android;

  /// No description provided for @manual_steps_ip_not_installed_msg_ios.
  ///
  /// In en, this message translates to:
  /// **'We\'re not able to detect the Health app. Please make sure that your device has Health app installed.'**
  String get manual_steps_ip_not_installed_msg_ios;

  /// No description provided for @manual_steps_ip_msg_ios.
  ///
  /// In en, this message translates to:
  /// **'We\'re not able to fetch your steps automatically from the Health app. Please make sure that your device has Health app installed.'**
  String get manual_steps_ip_msg_ios;

  /// No description provided for @manually_input_steps_quest.
  ///
  /// In en, this message translates to:
  /// **'Manually Input Steps?'**
  String get manually_input_steps_quest;

  /// No description provided for @input_manually.
  ///
  /// In en, this message translates to:
  /// **'Input Manually'**
  String get input_manually;

  /// No description provided for @upload_post.
  ///
  /// In en, this message translates to:
  /// **'Upload Post'**
  String get upload_post;

  /// No description provided for @post_desc_empty_msg.
  ///
  /// In en, this message translates to:
  /// **'Post description cannot be empty'**
  String get post_desc_empty_msg;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful!'**
  String get successful;

  /// No description provided for @post_creation_success.
  ///
  /// In en, this message translates to:
  /// **'Your post has been uploaded successfully, you can see it in your feed.'**
  String get post_creation_success;

  /// No description provided for @go_to_community.
  ///
  /// In en, this message translates to:
  /// **'Go to Community'**
  String get go_to_community;

  /// No description provided for @file_size_validation.
  ///
  /// In en, this message translates to:
  /// **'Please select a file of <size> only.'**
  String get file_size_validation;

  /// No description provided for @only_add_single_video.
  ///
  /// In en, this message translates to:
  /// **'You can only upload a single video in a post.'**
  String get only_add_single_video;

  /// No description provided for @no_video_with_images.
  ///
  /// In en, this message translates to:
  /// **'You cannot upload a video with images.'**
  String get no_video_with_images;

  /// No description provided for @no_image_with_video.
  ///
  /// In en, this message translates to:
  /// **'You cannot upload an image with video'**
  String get no_image_with_video;

  /// No description provided for @delete_post.
  ///
  /// In en, this message translates to:
  /// **'Delete Post'**
  String get delete_post;

  /// No description provided for @delete_comment.
  ///
  /// In en, this message translates to:
  /// **'Delete Comment'**
  String get delete_comment;

  /// No description provided for @delete_reply.
  ///
  /// In en, this message translates to:
  /// **'Delete Reply'**
  String get delete_reply;

  /// No description provided for @post_deletion_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this Post?'**
  String get post_deletion_confirmation;

  /// No description provided for @comment_deletion_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this Comment?'**
  String get comment_deletion_confirmation;

  /// No description provided for @reply_deletion_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this Reply?'**
  String get reply_deletion_confirmation;

  /// No description provided for @edit_vide.
  ///
  /// In en, this message translates to:
  /// **'Edit Video'**
  String get edit_vide;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @search_for_users.
  ///
  /// In en, this message translates to:
  /// **'Search for users, posts & more.'**
  String get search_for_users;

  /// No description provided for @results_for.
  ///
  /// In en, this message translates to:
  /// **'Results for \'<query>\''**
  String get results_for;

  /// No description provided for @post_details.
  ///
  /// In en, this message translates to:
  /// **'Post Details'**
  String get post_details;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @no_comments.
  ///
  /// In en, this message translates to:
  /// **'No comments at the moment.'**
  String get no_comments;

  /// No description provided for @no_posts.
  ///
  /// In en, this message translates to:
  /// **'No Posts Added Yet'**
  String get no_posts;

  /// No description provided for @no_replies.
  ///
  /// In en, this message translates to:
  /// **'No replies at the moment.'**
  String get no_replies;

  /// No description provided for @comment_replies.
  ///
  /// In en, this message translates to:
  /// **'Comment Replies'**
  String get comment_replies;

  /// No description provided for @other_reason.
  ///
  /// In en, this message translates to:
  /// **'Other reason'**
  String get other_reason;

  /// No description provided for @write_reason_here.
  ///
  /// In en, this message translates to:
  /// **'Write your reason here...'**
  String get write_reason_here;

  /// No description provided for @report_msg.
  ///
  /// In en, this message translates to:
  /// **'Help us to understand the problem. Why are you reporting?'**
  String get report_msg;

  /// No description provided for @write_here.
  ///
  /// In en, this message translates to:
  /// **'Write Here'**
  String get write_here;

  /// No description provided for @report_success.
  ///
  /// In en, this message translates to:
  /// **'Your report has been submitted successfully'**
  String get report_success;

  /// No description provided for @post_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Your post has been deleted successfully'**
  String get post_delete_success;

  /// No description provided for @comment_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Your comment has been deleted successfully'**
  String get comment_delete_success;

  /// No description provided for @reply_delete_success.
  ///
  /// In en, this message translates to:
  /// **'Your reply has been deleted successfully'**
  String get reply_delete_success;

  /// No description provided for @update_denied.
  ///
  /// In en, this message translates to:
  /// **'Update Denied'**
  String get update_denied;

  /// No description provided for @update_denied_msg.
  ///
  /// In en, this message translates to:
  /// **'You are required to update this app to continue using it!'**
  String get update_denied_msg;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @send_request.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get send_request;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @buddy_removed_success.
  ///
  /// In en, this message translates to:
  /// **'Buddy removed successfully'**
  String get buddy_removed_success;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get read_more;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @challenge_accepted.
  ///
  /// In en, this message translates to:
  /// **'Challenge Accepted!'**
  String get challenge_accepted;

  /// No description provided for @challenge_accepted_msg.
  ///
  /// In en, this message translates to:
  /// **'You\'ve joined the challenge! Track and log your progress from the Challenge tab on your home screen'**
  String get challenge_accepted_msg;

  /// No description provided for @you_did_it.
  ///
  /// In en, this message translates to:
  /// **'You Did It!'**
  String get you_did_it;

  /// No description provided for @challenge_complete_msg.
  ///
  /// In en, this message translates to:
  /// **'Challenge completed! Your hard work has paid off. Celebrate this milestone and keep pushing forward!'**
  String get challenge_complete_msg;

  /// No description provided for @challenge_buddy.
  ///
  /// In en, this message translates to:
  /// **'Challenge a buddy'**
  String get challenge_buddy;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @challenge_sent.
  ///
  /// In en, this message translates to:
  /// **'Challenge Sent!'**
  String get challenge_sent;

  /// No description provided for @challenge_sent_msg.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your challenge is now live. Start making progress!'**
  String get challenge_sent_msg;

  /// No description provided for @choose_task_for_challenge.
  ///
  /// In en, this message translates to:
  /// **'Choose a task for your challenge:'**
  String get choose_task_for_challenge;

  /// No description provided for @chosse_goal_duration.
  ///
  /// In en, this message translates to:
  /// **'Choose Goal Duration'**
  String get chosse_goal_duration;

  /// No description provided for @set_target_for_challenge.
  ///
  /// In en, this message translates to:
  /// **'Set the Target for your Challenge'**
  String get set_target_for_challenge;

  /// No description provided for @select_participants_for_challenge.
  ///
  /// In en, this message translates to:
  /// **'Select the Participants for This Challenge:'**
  String get select_participants_for_challenge;

  /// No description provided for @describe_challenge.
  ///
  /// In en, this message translates to:
  /// **'Describe What Your Challenge is About'**
  String get describe_challenge;

  /// No description provided for @create_challenge.
  ///
  /// In en, this message translates to:
  /// **'Create Challenge'**
  String get create_challenge;

  /// No description provided for @day_plural.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get day_plural;

  /// No description provided for @week_plural.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get week_plural;

  /// No description provided for @month_plural.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get month_plural;

  /// No description provided for @set_no_duration.
  ///
  /// In en, this message translates to:
  /// **'Set no. of <duration>:'**
  String get set_no_duration;

  /// No description provided for @everyone_in_community.
  ///
  /// In en, this message translates to:
  /// **'Everyone in the Community'**
  String get everyone_in_community;

  /// No description provided for @account_blocked.
  ///
  /// In en, this message translates to:
  /// **'Account Blocked'**
  String get account_blocked;

  /// No description provided for @account_blocked_msg.
  ///
  /// In en, this message translates to:
  /// **'Your account has been blocked by admin. Please contact the admin.'**
  String get account_blocked_msg;

  /// No description provided for @account_deleted.
  ///
  /// In en, this message translates to:
  /// **'Account Deleted'**
  String get account_deleted;

  /// No description provided for @account_deleted_msg.
  ///
  /// In en, this message translates to:
  /// **'Your account doesn\'t exists, It might have been deleted. Please contact admin.'**
  String get account_deleted_msg;

  /// No description provided for @deleted_user.
  ///
  /// In en, this message translates to:
  /// **'Deleted User'**
  String get deleted_user;

  /// No description provided for @challenger.
  ///
  /// In en, this message translates to:
  /// **'Challenger'**
  String get challenger;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @challenge_sent_success.
  ///
  /// In en, this message translates to:
  /// **'Challenge invitation sent successfully'**
  String get challenge_sent_success;

  /// No description provided for @already_rejected_msg.
  ///
  /// In en, this message translates to:
  /// **'Challenge already rejected. Please ask user to send again'**
  String get already_rejected_msg;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @assessment.
  ///
  /// In en, this message translates to:
  /// **'Assessment'**
  String get assessment;

  /// No description provided for @assessment_msg.
  ///
  /// In en, this message translates to:
  /// **'Please complete your monthly assessment'**
  String get assessment_msg;

  /// No description provided for @your_goals.
  ///
  /// In en, this message translates to:
  /// **'Your Goals'**
  String get your_goals;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @create_post_blocked.
  ///
  /// In en, this message translates to:
  /// **'You have been blocked from creating posts by Admin! Please contact Admin'**
  String get create_post_blocked;

  /// No description provided for @feedback_submitted_msg.
  ///
  /// In en, this message translates to:
  /// **'Your feedback has been submitted successfully'**
  String get feedback_submitted_msg;

  /// No description provided for @steps_pref_msg.
  ///
  /// In en, this message translates to:
  /// **'Change your steps preference to either enter manually or to fetch automatically from the health app.'**
  String get steps_pref_msg;

  /// No description provided for @please_setup_health_app.
  ///
  /// In en, this message translates to:
  /// **'Please setup Health app to update preference'**
  String get please_setup_health_app;

  /// No description provided for @steps_preference_updated.
  ///
  /// In en, this message translates to:
  /// **'Steps preference updated'**
  String get steps_preference_updated;

  /// No description provided for @install_health_connect.
  ///
  /// In en, this message translates to:
  /// **'Install Health Connect App'**
  String get install_health_connect;

  /// No description provided for @install_health_connect_msg.
  ///
  /// In en, this message translates to:
  /// **'To track your steps accurately, download the Health Connect app and enable step tracking'**
  String get install_health_connect_msg;

  /// No description provided for @download_from_playstore.
  ///
  /// In en, this message translates to:
  /// **'Download from Play Store'**
  String get download_from_playstore;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @connect_with.
  ///
  /// In en, this message translates to:
  /// **'Connect With'**
  String get connect_with;

  /// No description provided for @rate_us_on.
  ///
  /// In en, this message translates to:
  /// **'Rate us on <platform>'**
  String get rate_us_on;

  /// No description provided for @no_data_for_previous_month.
  ///
  /// In en, this message translates to:
  /// **'No data available for previous month'**
  String get no_data_for_previous_month;

  /// No description provided for @protected_apps.
  ///
  /// In en, this message translates to:
  /// **'Protected Apps'**
  String get protected_apps;

  /// No description provided for @protected_app_msg.
  ///
  /// In en, this message translates to:
  /// **'Due to system limitations, this permission is needed to avoid our app from being forcibly stopped and to accurately count your steps. Please select \'Unrestricted\' or \'No Restrictions\' when prompted.'**
  String get protected_app_msg;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @pedometer_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Please provide all required permissions to count your steps'**
  String get pedometer_permission_required;

  /// No description provided for @setup_pedometer.
  ///
  /// In en, this message translates to:
  /// **'Setup Pedometer'**
  String get setup_pedometer;

  /// No description provided for @pedometer.
  ///
  /// In en, this message translates to:
  /// **'Pedometer'**
  String get pedometer;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @track_progress.
  ///
  /// In en, this message translates to:
  /// **'Track Progress'**
  String get track_progress;

  /// No description provided for @step_progress.
  ///
  /// In en, this message translates to:
  /// **'Step Progress'**
  String get step_progress;

  /// No description provided for @update_step_goal.
  ///
  /// In en, this message translates to:
  /// **'Update Step Goal'**
  String get update_step_goal;

  /// No description provided for @update_steps_msg_pre.
  ///
  /// In en, this message translates to:
  /// **'You\'ve nailed your current goal, time to aim higher! Try '**
  String get update_steps_msg_pre;

  /// No description provided for @update_steps_msg_post.
  ///
  /// In en, this message translates to:
  /// **' steps a day.'**
  String get update_steps_msg_post;

  /// No description provided for @update_steps_confirm_msg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to update your step goal?'**
  String get update_steps_confirm_msg;

  /// No description provided for @update_steps_less_msg_pre.
  ///
  /// In en, this message translates to:
  /// **'Great work! You\'re averaging <avg> steps daily — just a little push, and '**
  String get update_steps_less_msg_pre;

  /// No description provided for @update_steps_less_msg_post.
  ///
  /// In en, this message translates to:
  /// **' steps is within reach. Keep it up!'**
  String get update_steps_less_msg_post;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @full_stop.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get full_stop;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get dob;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @your.
  ///
  /// In en, this message translates to:
  /// **'Your'**
  String get your;

  /// No description provided for @evaluation.
  ///
  /// In en, this message translates to:
  /// **'Evaluation'**
  String get evaluation;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @mins.
  ///
  /// In en, this message translates to:
  /// **'Mins'**
  String get mins;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_number;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @didnt_received_OTP.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t received OTP'**
  String get didnt_received_OTP;

  /// No description provided for @send_again.
  ///
  /// In en, this message translates to:
  /// **'Send Again'**
  String get send_again;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @login_msg_pre.
  ///
  /// In en, this message translates to:
  /// **'By continuing you are confirming that you have read, understood and agree to'**
  String get login_msg_pre;

  /// No description provided for @login_msg_post.
  ///
  /// In en, this message translates to:
  /// **''**
  String get login_msg_post;

  /// No description provided for @send_otp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get send_otp;

  /// No description provided for @sent_otp_msg.
  ///
  /// In en, this message translates to:
  /// **'OTP has been sent to your mobile number'**
  String get sent_otp_msg;

  /// No description provided for @resend_code_in.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in'**
  String get resend_code_in;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @code_sent_to_email.
  ///
  /// In en, this message translates to:
  /// **'6 digit code has been sent to your email id'**
  String get code_sent_to_email;

  /// No description provided for @try_again_in.
  ///
  /// In en, this message translates to:
  /// **'Try again in <time>'**
  String get try_again_in;

  /// No description provided for @login_failed_attempts_remaining.
  ///
  /// In en, this message translates to:
  /// **'Login failed. <attempts> attempt(s) remaining!'**
  String get login_failed_attempts_remaining;

  /// No description provided for @max_login_attempts_reached.
  ///
  /// In en, this message translates to:
  /// **'Maximum 3 attempts reached. Please try again after some time.'**
  String get max_login_attempts_reached;

  /// No description provided for @assessment_submitted_msg.
  ///
  /// In en, this message translates to:
  /// **'Assessment submitted successfully'**
  String get assessment_submitted_msg;

  /// No description provided for @password_validation.
  ///
  /// In en, this message translates to:
  /// **'Password must range between 7 and 12 characters and must contain 1 Number , 1 Special Char & 1 Capital Letter'**
  String get password_validation;

  /// No description provided for @installation_ready.
  ///
  /// In en, this message translates to:
  /// **'App ready for installation'**
  String get installation_ready;

  /// No description provided for @installation_ready_msg.
  ///
  /// In en, this message translates to:
  /// **'Update has been download and is now ready for installation. Click Install to continue. App might restart during the process'**
  String get installation_ready_msg;

  /// No description provided for @install.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @empty_today_msg.
  ///
  /// In en, this message translates to:
  /// **'Uh-oh! Your task list is empty. Let\'s fill it with awesome goals!'**
  String get empty_today_msg;

  /// No description provided for @setup_goals.
  ///
  /// In en, this message translates to:
  /// **'Set up Goals'**
  String get setup_goals;

  /// No description provided for @todays_tasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get todays_tasks;

  /// No description provided for @health_app_not_installed.
  ///
  /// In en, this message translates to:
  /// **'<health> is not installed on your device. Please install and try again.'**
  String get health_app_not_installed;

  /// No description provided for @provide_permission_for_health.
  ///
  /// In en, this message translates to:
  /// **'Please provide permission for <health> from Settings'**
  String get provide_permission_for_health;

  /// No description provided for @setup_health_app.
  ///
  /// In en, this message translates to:
  /// **'Setup Health App'**
  String get setup_health_app;

  /// No description provided for @health_app.
  ///
  /// In en, this message translates to:
  /// **'Health App'**
  String get health_app;

  /// No description provided for @edit_target.
  ///
  /// In en, this message translates to:
  /// **'Edit Target'**
  String get edit_target;

  /// No description provided for @update_target.
  ///
  /// In en, this message translates to:
  /// **'Update Target'**
  String get update_target;

  /// No description provided for @delete_target.
  ///
  /// In en, this message translates to:
  /// **'Delete Target'**
  String get delete_target;

  /// No description provided for @delete_task.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get delete_task;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications Yet!'**
  String get no_notifications;

  /// No description provided for @set_your_goals.
  ///
  /// In en, this message translates to:
  /// **'Set Your Goals'**
  String get set_your_goals;

  /// No description provided for @set_reminders.
  ///
  /// In en, this message translates to:
  /// **'Set Reminders'**
  String get set_reminders;

  /// No description provided for @overview_of_reminders.
  ///
  /// In en, this message translates to:
  /// **'Overview of Your Task Reminders'**
  String get overview_of_reminders;

  /// No description provided for @no_calendars_available.
  ///
  /// In en, this message translates to:
  /// **'No calendars are available on this device'**
  String get no_calendars_available;

  /// No description provided for @weekly_tasks.
  ///
  /// In en, this message translates to:
  /// **'Weekly Tasks'**
  String get weekly_tasks;

  /// No description provided for @monthly_tasks.
  ///
  /// In en, this message translates to:
  /// **'Monthly Tasks'**
  String get monthly_tasks;

  /// No description provided for @results_out_of.
  ///
  /// In en, this message translates to:
  /// **'OUT OF <total>'**
  String get results_out_of;

  /// No description provided for @your_results.
  ///
  /// In en, this message translates to:
  /// **'Your Results'**
  String get your_results;

  /// No description provided for @share_with_community.
  ///
  /// In en, this message translates to:
  /// **'Share with Community'**
  String get share_with_community;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @buddies.
  ///
  /// In en, this message translates to:
  /// **'Buddies'**
  String get buddies;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get weeks;

  /// No description provided for @month_singlular.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month_singlular;

  /// No description provided for @basic_details.
  ///
  /// In en, this message translates to:
  /// **'Basic Details'**
  String get basic_details;

  /// No description provided for @my_singular.
  ///
  /// In en, this message translates to:
  /// **'My'**
  String get my_singular;

  /// No description provided for @my_plural.
  ///
  /// In en, this message translates to:
  /// **'My'**
  String get my_plural;

  /// No description provided for @requests_received.
  ///
  /// In en, this message translates to:
  /// **'Requests Received'**
  String get requests_received;

  /// No description provided for @requests_sent.
  ///
  /// In en, this message translates to:
  /// **'Requests Sent'**
  String get requests_sent;

  /// No description provided for @no_requests_yet.
  ///
  /// In en, this message translates to:
  /// **'No Requests Yet'**
  String get no_requests_yet;

  /// No description provided for @no_buddies_yet.
  ///
  /// In en, this message translates to:
  /// **'No Buddies Yet'**
  String get no_buddies_yet;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @request_sent.
  ///
  /// In en, this message translates to:
  /// **'Request Sent'**
  String get request_sent;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @new_challenge.
  ///
  /// In en, this message translates to:
  /// **'New Challenge'**
  String get new_challenge;

  /// No description provided for @challenge.
  ///
  /// In en, this message translates to:
  /// **'Challenge'**
  String get challenge;

  /// No description provided for @new_post.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get new_post;

  /// No description provided for @people_joined_challenge.
  ///
  /// In en, this message translates to:
  /// **'<count> People Joined this Challenge'**
  String get people_joined_challenge;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @reminders_preference.
  ///
  /// In en, this message translates to:
  /// **'Reminders Preference'**
  String get reminders_preference;

  /// No description provided for @steps_preference.
  ///
  /// In en, this message translates to:
  /// **'Steps Preference'**
  String get steps_preference;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @rate_us.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rate_us;

  /// No description provided for @community_guidelines.
  ///
  /// In en, this message translates to:
  /// **'Community Guidelines'**
  String get community_guidelines;

  /// No description provided for @terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_conditions;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @account_deletion.
  ///
  /// In en, this message translates to:
  /// **'Account Deletion'**
  String get account_deletion;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @change_lang_msg.
  ///
  /// In en, this message translates to:
  /// **'Please select your preferred language from the options below'**
  String get change_lang_msg;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'&'**
  String get and;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @commented.
  ///
  /// In en, this message translates to:
  /// **'Commented'**
  String get commented;

  /// No description provided for @replied.
  ///
  /// In en, this message translates to:
  /// **'Replied'**
  String get replied;

  /// No description provided for @liked_your_post.
  ///
  /// In en, this message translates to:
  /// **'Liked your Post'**
  String get liked_your_post;

  /// No description provided for @liked_your_comment.
  ///
  /// In en, this message translates to:
  /// **'Liked your Comment'**
  String get liked_your_comment;

  /// No description provided for @liked_your_reply.
  ///
  /// In en, this message translates to:
  /// **'Liked your Reply'**
  String get liked_your_reply;

  /// No description provided for @tagged_in_post.
  ///
  /// In en, this message translates to:
  /// **'Tagged you in a Post'**
  String get tagged_in_post;

  /// No description provided for @tagged_in_comment.
  ///
  /// In en, this message translates to:
  /// **'Tagged you in a Comment'**
  String get tagged_in_comment;

  /// No description provided for @tagged_in_reply.
  ///
  /// In en, this message translates to:
  /// **'Tagged you in a Reply'**
  String get tagged_in_reply;

  /// No description provided for @sent_you_buddy_request.
  ///
  /// In en, this message translates to:
  /// **'has sent you a buddy request. Would you like to accept it?'**
  String get sent_you_buddy_request;

  /// No description provided for @has_accepted_buddy_request.
  ///
  /// In en, this message translates to:
  /// **'has accepted your buddy request. Start exploring together'**
  String get has_accepted_buddy_request;

  /// No description provided for @post_reported.
  ///
  /// In en, this message translates to:
  /// **'Post Reported'**
  String get post_reported;

  /// No description provided for @comment_reported.
  ///
  /// In en, this message translates to:
  /// **'Comment Reported'**
  String get comment_reported;

  /// No description provided for @reply_reported.
  ///
  /// In en, this message translates to:
  /// **'Reply Reported'**
  String get reply_reported;

  /// No description provided for @account_reported.
  ///
  /// In en, this message translates to:
  /// **'Account Reported'**
  String get account_reported;

  /// No description provided for @reported.
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get reported;

  /// No description provided for @account_reported_msg.
  ///
  /// In en, this message translates to:
  /// **'Your account has been reported'**
  String get account_reported_msg;

  /// No description provided for @challenged_you_for.
  ///
  /// In en, this message translates to:
  /// **'Challenged you for:'**
  String get challenged_you_for;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
