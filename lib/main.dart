import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/features/profile/presentation/views/screens/edit_profile_labourer.dart';
import 'package:servi_go_app/features/settings/presentation/views/settings_view.dart';
import 'package:servi_go_app/features/user_profile/presentation/views/edit%20_profile_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      // child: MaterialApp.router(
      //   //         theme: ThemeData.dark().copyWith(
      //   //           textTheme: GoogleFonts.poppinsTextTheme(),
      //   //           colorScheme:  ColorScheme.dark(
      //   //   onSurface: Colors.white,
      //   //   secondary:AppColors.grey,
      //   // ),

      //   //         ),
      //   theme: ThemeData.light().copyWith(
      //     textTheme: GoogleFonts.poppinsTextTheme(),
      //   ),

      //   // darkTheme: ThemeData.dark(),
      //   routerConfig: AppRouter.router,
      //   debugShowCheckedModeBanner: false,
      // ),
      child: MaterialApp(home: EditProfileLabourer()),
    );
  }
}
