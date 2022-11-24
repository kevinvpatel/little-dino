import 'package:get/get.dart';

import 'package:little_dino_app/app/modules/dashboard/About_Us/bindings/dashboard_about_us_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/About_Us/views/dashboard_about_us_view.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/bindings/dashboard_my_save_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/views/dashboard_my_save_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Privacy_Policy/bindings/dashboard_privacy_policy_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/Privacy_Policy/views/dashboard_privacy_policy_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Quiz/bindings/dashboard_quiz_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/Quiz/views/dashboard_quiz_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Recet/bindings/dashboard_recet_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/Recet/views/dashboard_recet_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Setting/bindings/dashboard_setting_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/Setting/views/dashboard_setting_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/bindings/dashboard_details_first_detail_page_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/dashboard_details_first_detail_page_view.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/completed/bindings/dashboard_levelscreens_completed_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/completed/views/dashboard_levelscreens_completed_view.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/bindings/levelscreens_quiz_screen_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/views/levelscreens_quiz_screen_view.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/bindings/dashboard_quiz_caterogies_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/dashboard_quiz_caterogies_view.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/bindings/dashboard_score_board_binding.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/views/dashboard_score_board_view.dart';
import 'package:little_dino_app/app/modules/forgate_Password/bindings/forgate_password_binding.dart';
import 'package:little_dino_app/app/modules/forgate_Password/views/forgate_password_main_view.dart';

import '../modules/BottomnavigationBar/bindings/bottomnavigation_bar_binding.dart';
import '../modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import '../modules/Onboarding/bindings/onboarding_binding.dart';
import '../modules/Onboarding/views/onboarding_view.dart';
import '../modules/dashboard/Home/bindings/dashboard_home_binding.dart';
import '../modules/dashboard/Home/views/dashboard_home_view.dart';
import '../modules/dashboard/Quiz/bindings/dashboard_quiz_binding.dart';
import '../modules/dashboard/Quiz/views/dashboard_quiz_view.dart';
import '../modules/dashboard/category/bindings/dashboard_category_binding.dart';
import '../modules/dashboard/category/views/dashboard_category_view.dart';
import '../modules/dashboard/details/alphabets/bindings/dashboard_details_alphabets_binding.dart';
import '../modules/dashboard/details/alphabets/views/dashboard_details_alphabets_view.dart';
import '../modules/dashboard/profile/bindings/dashboard_profile_binding.dart';
import '../modules/dashboard/profile/views/dashboard_profile_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.BOTTOMNAVIGATION_BAR,
      page: () => BottomnavigationBarView(),
      binding: BottomnavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_CATEGORY,
      page: () => DashboardCategoryView(),
      binding: DashboardCategoryBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_HOME,
      page: () => DashboardHomeView(),
      binding: DashboardHomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_QUIZ,
      page: () => DashboardQuizView(),
      binding: DashboardQuizBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_PROFILE,
      page: () => DashboardProfileView(),
      binding: DashboardProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_DETAILS_ALPHABETS,
      page: () => DashboardDetailsAlphabetsView(),
      binding: DashboardDetailsAlphabetsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_SCORE_BOARD,
      page: () => DashboardScoreBoardView(),
      binding: DashboardScoreBoardBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_MY_SAVE,
      page: () => DashboardMySaveView(),
      binding: DashboardMySaveBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_ABOUT_US,
      page: () => DashboardAboutUsView(),
      binding: DashboardAboutUsBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_PRIVACY_POLICY,
      page: () => DashboardPrivacyPolicyView(),
      binding: DashboardPrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_SETTING,
      page: () => DashboardSettingView(),
      binding: DashboardSettingBinding(),
    ),
    GetPage(
      name: _Paths.LEVELSCREENS_QUIZ_SCREEN,
      page: () => LevelscreensQuizScreenView(),
      binding: LevelscreensQuizScreenBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_LEVELSCREENS_COMPLETED,
      page: () => DashboardLevelscreensCompletedView(),
      binding: DashboardLevelscreensCompletedBinding(),
    ),
    GetPage(
      name: _Paths.FORGATE_PASSWORD,
      page: () => ForgatePasswordMainView(),
      binding: ForgatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_RECET,
      page: () => DashboardRecetView(),
      binding: DashboardRecetBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_QUIZ_CATEROGIES,
      page: () => DashboardQuizCaterogiesView(),
      binding: DashboardQuizCaterogiesBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_DETAILS_FIRST_DETAIL_PAGE,
      page: () => DashboardDetailsFirstDetailPageView(),
      binding: DashboardDetailsFirstDetailPageBinding(),
    ),
  ];
}
