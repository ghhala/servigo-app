import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/localization/locale_cubit.dart';
import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/core/network/dio_client.dart';
import 'package:servi_go_app/core/theme/app_theme.dart';
import 'package:servi_go_app/core/theme/theme_bloc.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';

import 'package:servi_go_app/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/repositories/chat_repository.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_cubit.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await PrefHelper.init();
//   runApp(
//     MultiProvider(
//       providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (_) => ThemeBloc()),
//           BlocProvider(create: (_) => LocaleCubit()..loadLocale()),
//         ],
//         child: const MyApp(),
//       ),
//     ),
//   );
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefHelper.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => LocaleCubit()..loadLocale()),
          // ✅ ChatCubit بقى Global، متاح من أي route في التطبيق
          BlocProvider(
            create: (_) => ChatCubit(
              ChatRepository(ChatRemoteDataSource(ApiService(DioClient()))),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                routerConfig: AppRouter.router,

                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
