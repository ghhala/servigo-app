import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servi_go_app/core/utils/app_router.dart';


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
      child: MaterialApp.router(
        //         theme: ThemeData.dark().copyWith(
        //           textTheme: GoogleFonts.poppinsTextTheme(),
        //           colorScheme:  ColorScheme.dark(
        //   onSurface: Colors.white,
        //   secondary:AppColors.grey,
        // ),

        //         ),
        theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),

        // darkTheme: ThemeData.dark(),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
     //  child: MaterialApp(home: HomeView()),
    );
  }
}
