import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;

  const AppBackground({
    super.key,
    required this.child,
    this.padding,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/images/Vector1.png'),
          ),
          Positioned(
            top: 0,
            left: 16.w,
            child: Image.asset(
              'assets/images/Vector(2).png',
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/images/Vector(4).png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/Vector(3).png',
              width: 200.h,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: padding ?? EdgeInsets.only(top: 136.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                ),

                child: SizedBox(width: double.infinity, child: child),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
