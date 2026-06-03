import 'package:go_router/go_router.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/auth_landing_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/forget_password_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/log_in.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/otp_code_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/reset_password_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/sign_up_%20labourer_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/sign_up_user.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/user_type_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/verviciton_view.dart';
import 'package:servi_go_app/features/filter/presentation/views/filter_bottom_sheet.dart';
import 'package:servi_go_app/features/home/presentation/views/home_view.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';
import 'package:servi_go_app/features/on_boarding/presentation/views/widgets/on_boarding_view_1.dart';
import 'package:servi_go_app/features/on_boarding/presentation/views/widgets/on_boarding_view_2.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/complite_profile_view.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/edit_profile_labourer.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/profile_labourer_view.dart';
import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';
import 'package:servi_go_app/features/splash/presentation/views/widgets/splash_view.dart';
import 'package:servi_go_app/features/user_profile/presentation/views/edit%20_profile_user.dart';

abstract class AppRouter {
  static const kOnboarding1 = '/onboarding1';
  static const kOnboarding2 = '/onboarding2';
  static const kLogin = '/login';
  static const kauthlandingview = '/auth_landing_view';
  static const kusertypeview = '/user_type_view';
  static const ksignupuser = '/sign_up_user';
  static const klogIn = '/log_in';
  static const kforgetPassword = '/forget_password';
  static const kotpcode = '/otp_code_view';
  static const kresetpassword = '/reset_password_view';
  static const kuserlabourer = '/user_labourer_view';
  static final kVerviciton = '/Verviciton_View';
  static final kkLocation = '/Location_View';
  static final kSettings = '/settings';
  static const kHome = '/home';
  static const kEditeProfile = '/edit_profile';
  static const kProfileLabourer = '/profile_labourer';
  static const kCompliteProfile = '/complite_profile';
  static const kEditProfileLabourer = '/EditProfileLabourer';
  static const kfilterButtonSheet = '/filter_bottom_sheet';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: kOnboarding1,
        builder: (context, state) => const OnBoardingView1(),
      ),
      GoRoute(
        path: kOnboarding2,
        builder: (context, state) => const OnBoardingView2(),
      ),
      GoRoute(
        path: kauthlandingview,
        builder: (context, state) {
          final userType = state.extra as String;
          return AuthLandingView(userType: userType);
        },
      ),
      GoRoute(
        path: kusertypeview,
        builder: (context, state) => const UserTypeView(),
      ),
      GoRoute(
        path: ksignupuser,
        builder: (context, state) {
          final userType = state.extra as String;
          return SignUpUser(userType: userType);
        },
      ),
      GoRoute(
        path: klogIn,
        builder: (context, state) {
          final userType = state.extra as String;
          return LogIn(userType: userType);
        },
      ),
      GoRoute(
        path: kforgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kotpcode,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return OtpCodeView(
            receivedOtp: data['otp'],
            userEmail: data['email'],
          );
        },
      ),
      GoRoute(
        path: kresetpassword,
        builder: (context, state) {
          // 1. استلام الـ extra كـ Map بشكل مرن، وإذا كانت فارغة نضع Map فارغ
          final data = state.extra is Map<String, dynamic>
              ? state.extra as Map<String, dynamic>
              : {};

          // 2. تحويل القيم بأمان إلى نصوص String لتطابق الـ Constructor الخاص بالصفحة
          final String? otp = data['otp']?.toString();
          final String? email = data['email']?.toString();
          final String userType = data['userType']?.toString() ?? 'user';

          return ResetPasswordView(
            receivedOtp: otp,
            userEmail: email,
            userType: userType,
          );
        },
      ),
      GoRoute(
        path: kuserlabourer,
        builder: (context, state) {
          final userType = state.extra as String;
          return SignUplabourerView(userType: userType);
        },
      ),
      GoRoute(
        path: kVerviciton,
        builder: (context, state) {
          Map<String, dynamic> userData = {};
          String userType = 'user';

          // 👈 فحص ذكي: إذا كانت البيانات القادمة هي Map (تأتي من صفحة التسجيل المتقدمة)
          if (state.extra is Map<String, dynamic>) {
            final data = state.extra as Map<String, dynamic>;
            userType = data['userType'] as String? ?? 'user';
            userData = data['initialData'] as Map<String, dynamic>? ?? {};
          }
          // 👈 إذا كانت البيانات القادمة نص عادي String (تأتي من صفحة اختيار الحساب مباشرة)
          else if (state.extra is String) {
            userType = state.extra as String;
          }

          return VervicitonView(userData: userData, userType: userType);
        },
      ),
      GoRoute(
        path: kkLocation,
        builder: (context, state) => const CustomLocation(),
      ),
      GoRoute(
        path: AppRouter.kSettings,
        builder: (context, state) => const SettingsView(),
      ),

      GoRoute(
        path: kHome,
        builder: (context, state) {
          String userType = 'user'; // القيمة الافتراضية

          // 👈 1. إذا كان الـ extra القادم عبارة عن نص عادي String
          if (state.extra is String) {
            userType = state.extra as String;
          }
          // 👈 2. إذا قام مكان ما في التطبيق بإرسال الـ extra كـ Map بالخطأ
          else if (state.extra is Map<String, dynamic>) {
            final data = state.extra as Map<String, dynamic>;
            // استخراج الـ userType من داخل الـ Map إذا كان موجوداً، وإلا نضع 'user'
            userType = data['userType'] as String? ?? 'user';
          }

          // تمرير القيمة النصية الصافية والآمنة لشاشة الهوم
          return HomeView(userType: userType);
        },
      ),
      GoRoute(
        path: AppRouter.kEditeProfile,
        builder: (context, state) => const EditProfileUser(),
      ),
      GoRoute(
        path: AppRouter.kProfileLabourer,
        builder: (context, state) => const ProfileLabourerView(),
      ),
      GoRoute(
        path: AppRouter.kCompliteProfile,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final userType = data?['userType'] as String? ?? 'user';
          final userData = data?['userData'] as Map<String, dynamic>?;
          return CompliteProfileView(userData: userData, userType: userType);
        },
      ),
      GoRoute(
        path: AppRouter.kEditProfileLabourer,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final userType = data?['userType'] as String? ?? 'labourer';
          final userData = data?['userData'] as Map<String, dynamic>?;
          return EditProfileLabourer(userData: userData, userType: userType);
        },
      ),
      // GoRoute(
      //   path: kfilterButtonSheet,
      //   builder: (context, state) => FilterBottomSheet(),
      // ),
    ],
  );
}
