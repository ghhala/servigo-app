import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/core/network/dio_client.dart';
import 'package:servi_go_app/core/widgets/terms_and_conditions.dart';
import 'package:servi_go_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';
import 'package:servi_go_app/features/auth/data/repositories/auth_repository.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/login/login_cubit.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/register_user/register_user_cubit.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/register_provider/register_provider_cubit.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/auth_landing_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/forget_password_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/log_in.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/otp_code_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/reset_password_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/sign_up_%20labourer_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/sign_up_user.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/user_type_view.dart';
import 'package:servi_go_app/features/auth/presentation/views/screens/verviciton_view.dart';
import 'package:servi_go_app/features/filter/data/data_sources/filter_remote_data_source.dart';
import 'package:servi_go_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:servi_go_app/features/home/data/repositories/home_repository.dart';
import 'package:servi_go_app/features/home/presentation/view_models/home/cubit/home_cubit.dart';
import 'package:servi_go_app/features/home/presentation/views/home_view.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/chat_admin_view.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/chat_view.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/admin_chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/repositories/admin_chat_repository.dart';
import 'package:servi_go_app/features/messaging/data/repositories/chat_repository.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/admin_chat/admin_chat_cubit.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_cubit.dart';
import 'package:servi_go_app/features/on_boarding/presentation/views/widgets/on_boarding_view_1.dart';
import 'package:servi_go_app/features/on_boarding/presentation/views/widgets/on_boarding_view_2.dart';
import 'package:servi_go_app/features/provider_profile/data/data_sources/complete_profile_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/data_sources/provider_profile_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/data_sources/sub_services_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/complete_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/provider_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/sub_services_repository.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/completeprofile/complete_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/sub_services/sub_services_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/complite_profile_provider_view.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/edite_profile_provider.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/move_to_complite.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/profile_labourer_view.dart';

import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';
import 'package:servi_go_app/features/splash/presentation/views/widgets/splash_view.dart';
import 'package:servi_go_app/features/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import 'package:servi_go_app/features/user_profile/data/models/user_profile_model.dart';
import 'package:servi_go_app/features/user_profile/data/repositories/user_profile_repository.dart';
import 'package:servi_go_app/features/user_profile/presentation/view_models/edit_profile/edit_profile_cubit.dart';
import 'package:servi_go_app/features/user_profile/presentation/views/edit%20_profile_user.dart';

import 'package:servi_go_app/features/filter/data/repositories/filter_repository_impl.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_cubit.dart';
import 'package:servi_go_app/features/filter/presentation/views/filter_view.dart';

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
  static const kmoveToComplite = '/move_to_complite';
  static const kCompliteProfileProviderView = '/complite_profile_provider';
  static const kfilterButtonSheet = '/filter_bottom_sheet';
  static const kFilterView = '/filter_view';
  static const kChatRoom = '/chat_room';
  static const kAdminChatRoom = '/admin_chat_room';
  static const kEditProfileProvider = '/edit_profile_provider';
  static const kTermsAndConditionsScreen='/terms_and_conditions_screen';
  static const kOtpVerification = kotpcode;

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
          return BlocProvider(
            create: (context) => RegisterUserCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: SignUpUser(userType: userType),
          );
        },
      ),
      GoRoute(
        path: klogIn,
        builder: (context, state) {
          final userType = state.extra as String;
          return BlocProvider(
            create: (context) => LoginCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: LogIn(userType: userType),
          );
        },
      ),
  
      GoRoute(
        path: kforgetPassword,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => RegisterUserCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: const ForgetPasswordView(),
          );
        },
      ),

      GoRoute(
        path: kotpcode,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};

          final otpView = OtpCodeView(
            receivedOtp: data['otp']?.toString() ?? '',
            userEmail: data['email']?.toString() ?? '',
            userType: data['userType']?.toString() ?? 'user',
            isForgetPassword: data['isForgetPassword'] as bool? ?? false,
            authAction: data['authAction']?.toString(),
            mainServiceId: data['main_service_id'] != null
                ? int.tryParse(data['main_service_id'].toString())
                : null,
          );

          if (data['registerCubit'] is RegisterUserCubit) {
            return BlocProvider.value(
              value: data['registerCubit'] as RegisterUserCubit,
              child: otpView,
            );
          }

          if (data['registerProviderCubit'] is RegisterProviderCubit) {
            return BlocProvider.value(
              value: data['registerProviderCubit'] as RegisterProviderCubit,
              child: otpView,
            );
          }

          return BlocProvider(
            create: (context) => RegisterUserCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: otpView,
          );
        },
      ),
      GoRoute(
        path: kresetpassword,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};

          final String? otp = data['otp']?.toString();
          final String? email = data['email']?.toString();
          final String userType = data['userType']?.toString() ?? 'user';

          final resetView = ResetPasswordView(
            receivedOtp: otp,
            userEmail: email,
            userType: userType,
          );

          if (data['registerCubit'] is RegisterUserCubit) {
            return BlocProvider.value(
              value: data['registerCubit'] as RegisterUserCubit,
              child: resetView,
            );
          }

          return BlocProvider(
            create: (context) => RegisterUserCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: resetView,
          );
        },
      ),
      GoRoute(
        path: kuserlabourer,
        builder: (context, state) {
          final userType = state.extra as String;
          return BlocProvider(
            create: (context) => RegisterProviderCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: SignUplabourerView(userType: userType),
          );
        },
      ),
      GoRoute(
        path: kVerviciton,
        builder: (context, state) {
          Map<String, dynamic> userData = {};
          String userType = 'user';
          RegisterProviderRequestBody? requestBody;

          if (state.extra is Map<String, dynamic>) {
            final data = state.extra as Map<String, dynamic>;
            userType = data['userType'] as String? ?? 'user';
            userData = data['initialData'] as Map<String, dynamic>? ?? {};
            requestBody = data['requestBody'] as RegisterProviderRequestBody?;
          } else if (state.extra is RegisterProviderRequestBody) {
            requestBody = state.extra as RegisterProviderRequestBody;
            userType = 'labourer';
          } else if (state.extra is String) {
            userType = state.extra as String;
          }

          return BlocProvider(
            create: (context) => RegisterProviderCubit(
              AuthRepository(AuthRemoteDataSource(ApiService(DioClient()))),
            ),
            child: VervicitonView(
              userData: userData,
              userType: userType,
              requestBody: requestBody,
            ),
          );
        },
      ),
      GoRoute(
        path: kkLocation,
        builder: (context, state) => const CustomLocation(),
      ),
      GoRoute(
        path: AppRouter.kSettings,
        builder: (context, state) {
          final isProvider = state.extra as bool? ?? false;
          return SettingsView(isProvider: isProvider);
        },
      ),

      GoRoute(
        path: kHome,
        builder: (context, state) {
          String userType = 'user';
          dynamic userData;

          if (state.extra is String) {
            userType = state.extra as String;
          } else if (state.extra is Map<String, dynamic>) {
            final data = state.extra as Map<String, dynamic>;
            userType = data['userType'] as String? ?? 'user';
            userData = data['userData'];
          }

          return BlocProvider(
            create: (context) => HomeCubit(
              HomeRepository(HomeRemoteDataSource(ApiService(DioClient()))),
            )..fetchHomeData(),
            child: HomeView(userType: userType, userData: userData),
          );
        },
      ),
      GoRoute(
        path: AppRouter.kEditeProfile,
        builder: (context, state) {
          final userModel = state.extra as UserProfileData? ?? UserProfileData();

          return BlocProvider(
            create: (context) => EditProfileCubit(
              UserProfileRepository(
                UserProfileRemoteDataSource(ApiService(DioClient())),
              ),
            ),
            child: EditProfileUser(
              currentName: userModel.name,
              currentPhone: userModel.phone,
              currentEmail: userModel.email,
            ),
          );
        },
      ),

    
    
GoRoute(
  path: AppRouter.kProfileLabourer,
  builder: (context, state) {
    final providerId = (state.extra as int?) ?? 0;
    return BlocProvider<ProviderProfileCubit>(
      create: (context) => ProviderProfileCubit(
        ProviderProfileRepository(
          ProviderProfileRemoteDataSource(ApiService(DioClient())),
        ),
      ),
      child: ProfileLabourerView(providerId: providerId),
    );
  },
),
      GoRoute(
        path: AppRouter.kmoveToComplite,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final userType = data?['userType'] as String? ?? 'user';
          final userData = data?['userData'] as Map<String, dynamic>?;
          return MoveToComplite(userData: userData, userType: userType);
        },
      ),
      GoRoute(
        path: AppRouter.kCompliteProfileProviderView,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final userType = data?['userType'] as String? ?? 'labourer';
          final userData = data?['userData'] as Map<String, dynamic>?;

          return MultiBlocProvider(
            providers: [
              BlocProvider<SubServicesCubit>(
                create: (context) => SubServicesCubit(
                  SubServicesRepository(
                    SubServicesRemoteDataSource(ApiService(DioClient())),
                  ),
                ),
              ),
              BlocProvider<CompleteProfileCubit>(
                create: (context) => CompleteProfileCubit(
                  CompleteProfileRepository(
                    CompleteProfileRemoteDataSource(ApiService(DioClient())),
                  ),
                ),
              ),
            ],
            child: CompliteProfileProviderView(
              userData: userData,
              userType: userType,
            ),
          );
        },
      ),

      GoRoute(
        path: kFilterView,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?; 

          if (data == null) {
            return const Scaffold(
              body: Center(child: Text('خطأ: لم تصل بيانات الخدمة')),
            );
          }

          final mainServiceId = data['mainServiceId'] as int? ?? 0;
          final mainServiceName =
              data['mainServiceName'] as String? ?? 'Service';

          return BlocProvider(
            create: (context) => FilterCubit(
              filterRepository: FilterRepository(
                remoteDataSource: FilterRemoteDataSourceImpl(
                  apiService: ApiService(DioClient()),
                ),
              ),
            ),
            child: FilterView(
              mainServiceId: mainServiceId,
              mainServiceName: mainServiceName,
            ),
          );
        },
      ),
      GoRoute(
        path: '/chat_room',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final chatId = data['chatId'] as int;
          final otherPartyName = data['otherPartyName'] as String;
          final otherPartyPhoto = data['otherPartyPhoto'] as String?;

          return BlocProvider(
            create: (_) => ChatCubit(
              ChatRepository(ChatRemoteDataSource(ApiService(DioClient()))),
            )..fetchMessages(chatId),
            child: ChatView(
              chatId: chatId,
              otherPartyName: otherPartyName,
              otherPartyPhoto: otherPartyPhoto,
            ),
          );
        },
      ),
      GoRoute(
  path: AppRouter.kAdminChatRoom,
  builder: (context, state) {
    final data = state.extra as Map<String, dynamic>;
    final adminId = data['adminId'] as int;
    final adminChatId = data['adminChatId'] as int?;
    final adminName = data['adminName'] as String;
    final adminPhoto = data['adminPhoto'] as String?;

    return BlocProvider(
      create: (_) {
        final cubit = AdminChatCubit(
          AdminChatRepository(
            AdminChatRemoteDataSource(ApiService(DioClient())),
          ),
        );
     
        if (adminChatId != null) {
          cubit.fetchMessages(adminChatId);
        }
        return cubit;
      },
      child: AdminChatView(
        adminId: adminId,
        adminChatId: adminChatId,
        adminName: adminName,
        adminPhoto: adminPhoto,
      ),
    );
  },
),

      

GoRoute(
  path: kEditProfileProvider,
  builder: (context, state) => const EditProfileProviderView(),
),

GoRoute(path: kTermsAndConditionsScreen, builder: (context, state) => const TermsAndConditionsScreen())


    ],
  );
}
