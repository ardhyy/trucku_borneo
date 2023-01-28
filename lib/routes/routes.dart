import 'package:get/get.dart';
import 'package:trucku_borneo/logic/bindings/dashboard.dart';
import 'package:trucku_borneo/logic/bindings/edit_profile.dart';
import 'package:trucku_borneo/logic/bindings/home.dart';
import 'package:trucku_borneo/logic/bindings/login.dart';
import 'package:trucku_borneo/logic/bindings/pemesanan.dart';
import 'package:trucku_borneo/logic/bindings/profile.dart';
import 'package:trucku_borneo/logic/bindings/register.dart';
import 'package:trucku_borneo/logic/bindings/search_address.dart';
import 'package:trucku_borneo/page/dashboard/dashboard.dart';
import 'package:trucku_borneo/page/detail-armada/detail_armada.dart';
import 'package:trucku_borneo/page/edit_profile/edit_profile.dart';
import 'package:trucku_borneo/page/history_order/history_order.dart';
import 'package:trucku_borneo/page/home/home.dart';
import 'package:trucku_borneo/page/login/login.dart';
import 'package:trucku_borneo/page/pemesanan/pemesanan.dart';
import 'package:trucku_borneo/page/profile/profile.dart';
import 'package:trucku_borneo/page/register/register.dart';
import 'package:trucku_borneo/page/search_address/search_address.dart';
import 'package:trucku_borneo/page/splash/splash.dart';

class AppRoutes {
  static const splash = Routes.splash;
  static const login = Routes.login;
  static const register = Routes.register;
  static const dashboard = Routes.dashboard;
  static const home = Routes.home;
  static const historyOrder = Routes.historyOrder;
  static const profile = Routes.profile;
  static const editProfile = Routes.editProfile;
  static const detailArmada = Routes.detailArmada;
  static const pesanArmada = Routes.pesanArmada;
  static const searchAddress = Routes.searchAddress;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.historyOrder,
      page: () => const HistoryOrderPage(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
      arguments: EditProfilePage(),
    ),
    GetPage(
      name: Routes.detailArmada,
      page: () => DetailArmadaPage(),
      arguments: DetailArmadaPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.pesanArmada,
      page: () => PemesananPage(),
      binding: PemesananBinding(),
      arguments: PemesananPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.searchAddress,
      page: () => searchAddressPage(),
      binding: SearchAddresBinding(),
    ),
  ];
}

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const historyOrder = '/history-order';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const detailArmada = '/detail-armada';
  static const pesanArmada = '/pesan-armada';
  static const searchAddress = '/pemesanan/search-address';
}
