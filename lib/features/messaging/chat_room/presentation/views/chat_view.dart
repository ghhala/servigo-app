import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/widgets/chat_bubble.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/widgets/message_input_area.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_cubit.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_state.dart';

class ChatView extends StatelessWidget {
  final int chatId;
  final String otherPartyName;
  final String? otherPartyPhoto;

  const ChatView({
    super.key,
    required this.chatId,
    required this.otherPartyName,
    this.otherPartyPhoto,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = ChatCubit.buildImageUrl(otherPartyPhoto);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AppBackground(
        withScaffold: false,
        padding: EdgeInsets.only(top: 100.h),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height - 100.h,
          child: Column(
            children: [
              // ── Header ──
              Container(
                width: double.infinity,
                height: 80.h,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 135, 93, 143),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : const AssetImage('assets/images/user_avatar.jpg')
                              as ImageProvider,
                    ),
                    Gap(10.w),
                    Text(
                      otherPartyName,
                      style: TextStyles.font11WhiteW500,
                    ),
                  ],
                ),
              ),
              Gap(10),

              // ── Messages ──
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state.status == ChatStatus.loading &&
                        state.messages.isEmpty) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }

                    if (state.status == ChatStatus.error) {
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Error loading messages',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state.messages.isEmpty) {
                      return const Center(
                        child: Text('No messages yet. Say hello! 👋'),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final msg = state.messages[index];
                        return ChatBubble(
                          message: msg.content ?? '',
                          isMe: msg.isMine,
                          imageUrl: msg.imageUrl,
                          videoUrl: msg.videoUrl,
                          time: msg.time,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ── Input Area ──
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: MessageInputArea(
          onSendMessage: (content) {
            context.read<ChatCubit>().sendMessage(chatId, content);
          },
          onSendImage: (imageFile) {
            context.read<ChatCubit>().sendMessage(
                  chatId,
                  null,
                  image: imageFile,
                );
          },
        ),
      ),
    );
  }
}