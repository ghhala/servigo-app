import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/widgets/chat_bubble.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/widgets/message_input_area.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: AppBackground(
        withScaffold: false,
        padding: EdgeInsets.only(top: 100.h),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height - 100.h,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 93, 143),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 25.r, backgroundImage: AssetImage("")),
                    Gap(10.w),
                    Text("Ahmed Khaled", style: TextStyles.font11WhiteW500),
                  ],
                ),
              ),
              Gap(10),
              Expanded(
                child: ListView(
                  children: [
                    ChatBubble(
                      message: "Hello, When do you need me to start ?",
                      isMe: false,
                    ),
                    ChatBubble(
                      message: "Hi, I need you today at 3 PM.",
                      isMe: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const MessageInputArea(),
      ),
    );
  }
}
