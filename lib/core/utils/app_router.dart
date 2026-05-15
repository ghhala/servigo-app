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
import 'package:servi_go_app/features/home/presentation/views/widgets/home_body.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';
import 'package:servi_go_app/features/on_boarding/presentation/views/widgets/on_boarding_view_1.dart';
import 'package:servi_go_app/features/on_boarding/presentation/views/widgets/on_boarding_view_2.dart';
import 'package:servi_go_app/features/profile/presentation/views/screens/edit_profile_labourer.dart';
import 'package:servi_go_app/features/profile/presentation/views/screens/profile_labourer_view.dart';
import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';
import 'package:servi_go_app/features/splash/presentation/views/widgets/splash_view.dart';

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
        builder: (context, state) => const AuthLandingView(),
      ),
      GoRoute(
        path: kusertypeview,
        builder: (context, state) => const UserTypeView(),
      ),
      GoRoute(path: ksignupuser, builder: (context, state) => SignUpUser()),
      GoRoute(path: klogIn, builder: (context, state) => LogIn()),
      GoRoute(
        path: kforgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kotpcode,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>; // استقبال البيانات
          return OtpCodeView(
            receivedOtp: data['otp'],
            userEmail: data['email'],
          );
        },
      ),
      GoRoute(
        path: kresetpassword,
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(
        path: kuserlabourer,
        builder: (context, state) => const SignUplabourerView(),
      ),
      GoRoute(
        path: kVerviciton,
        builder: (context, state) => const VervicitonView(),
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
        path: AppRouter.kHome,
        builder: (context, state) => const HomeBody(),
      ),
      GoRoute(
        path: AppRouter.kEditeProfile,
        builder: (context, state) => const EditProfileLabourer(),
      ),
      GoRoute(
        path: AppRouter.kProfileLabourer,
        builder: (context, state) => const ProfileLabourerView(),
      ),
    ],
  );
}
