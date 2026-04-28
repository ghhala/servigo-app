import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 80.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("John ", style: TextStyles.font18BlackW500),
                      Gap(200),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        size: 20.r,
                      ),
                    ],
                  ),
                  Gap(7),
                  Text(
                    "When are you coming ?",
                    style: TextStyles.font12BlackW400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
