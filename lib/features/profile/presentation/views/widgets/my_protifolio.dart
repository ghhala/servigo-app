import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MyProtifolio extends StatefulWidget {
  const MyProtifolio({super.key});

  @override
  State<MyProtifolio> createState() => _MyProtifolioState();
}

class _MyProtifolioState extends State<MyProtifolio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 300.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "His Protifolio",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Gap(10),
              Row(
                children: [
                  Image.asset("assets/images/p1.png"),
                  Gap(10),
                  Image.asset("assets/images/p2.png"),
                  Gap(10),
                  Image.asset("assets/images/p3.png"),
                ],
              ),
              Gap(30),
              Text(
                "His certificates :",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Gap(10),
              Row(
                children: [
                  Image.asset("assets/images/p3.png"),
                  Gap(10),
                 // Image.asset("assets/images/P2.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
