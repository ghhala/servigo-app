import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/chat_view.dart';
import 'package:servi_go_app/features/messaging/presentation/views/widgets/chat_tile.dart';
import 'package:servi_go_app/features/messaging/presentation/views/widgets/custom_tab.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(top: 70.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Messages", style: TextStyles.font16BlackW700),
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    CustomTab(title: 'Customer'),
                    Gap(20),
                    CustomTab(title: 'Admin'),
                  ],
                ),
                Gap(26),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatView()),
                    );
                  },
                  child: ChatTile(),
                ),
                Gap(10),
                ChatTile(),
                Gap(10),
                ChatTile(),
                Gap(10),
                ChatTile(),
                Gap(10),
                ChatTile(),
                Gap(10),
                ChatTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
