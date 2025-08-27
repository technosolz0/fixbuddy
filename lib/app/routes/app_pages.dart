import 'package:fixbuddy/app/constants/category_search_screen.dart';
import 'package:fixbuddy/app/modules/address/binding/address_binding.dart';
import 'package:fixbuddy/app/modules/address/views/address_view.dart';
import 'package:fixbuddy/app/modules/allservices/bindings/all_service_binding.dart';
import 'package:fixbuddy/app/modules/allservices/views/all_service_view.dart';
import 'package:fixbuddy/app/modules/auth/bindings/verify_otp_binding.dart';
import 'package:fixbuddy/app/modules/auth/views/verify_otp_screen.dart';
import 'package:fixbuddy/app/modules/booking/bindings/booking_binding.dart';
import 'package:fixbuddy/app/modules/category/bindings/category_binding.dart';
import 'package:fixbuddy/app/modules/category/views/category_view.dart';
import 'package:fixbuddy/app/modules/language/bindings/language_binding.dart';
import 'package:fixbuddy/app/modules/language/views/language_view.dart';
import 'package:fixbuddy/app/modules/login/bindings/login_binding.dart';
import 'package:fixbuddy/app/modules/login/views/login_view.dart';
import 'package:fixbuddy/app/modules/register/bindings/registration_binding.dart';
import 'package:fixbuddy/app/modules/register/views/registration_view.dart';
import 'package:fixbuddy/app/modules/splash/bindings/splash_binding.dart';
import 'package:fixbuddy/app/modules/splash/views/splash_view.dart';
import 'package:fixbuddy/app/modules/subCategory/bindings/sub_category_binding.dart';
import 'package:fixbuddy/app/modules/subCategory/views/sub_category_view.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/Notification/bindings/notification_binding.dart';
import 'package:fixbuddy/app/modules/Notification/views/notification_view.dart';
import 'package:fixbuddy/app/modules/profile/bindings/profile_binding.dart'
    show ProfileBinding;
import 'package:fixbuddy/app/modules/settings/bindings/setting_binding.dart';
import 'package:fixbuddy/app/modules/settings/views/setting_view.dart';
import 'package:fixbuddy/app/modules/wallet/bindings/wallet_binding.dart'
    show WalletBinding;
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/widgets/main_screen.dart';
import 'package:fixbuddy/app/modules/home/views/home_view.dart';
import 'package:fixbuddy/app/modules/home/bindings/home_binding.dart';

import 'package:fixbuddy/app/modules/booking/views/booking_view.dart';

import 'package:fixbuddy/app/modules/wallet/views/wallet_view.dart';

import 'package:fixbuddy/app/modules/profile/views/profile_view.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: Routes.register,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: Routes.verifyOtp,
      page: () => OtpView(),
      binding: VerifyOtpBinding(),
    ),

    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Routes.booking,
      page: () => BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: Routes.wallet,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: Routes.notification,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.setting,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.language,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),

    GetPage(
      name: Routes.category,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.subcategory,
      page: () => SubCategoryView(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: Routes.allServices,
      page: () => const AllServicesView(),
      binding: AllServicesBinding(),
    ),

    GetPage(name: Routes.categorySearch, page: () => CategorySearchScreen()),
    GetPage(
      name: Routes.address,
      page: () => AddressView(),
      binding: AddressBinding(),
    ),
  ];
}
