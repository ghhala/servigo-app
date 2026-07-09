// lib/features/messaging/chat_room/presentation/views/admin_chat_view.dart
// شاشة الدردشة مع الأدمن — تُستدعى عند الضغط على أدمن من القائمة

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/widgets/chat_bubble.dart';
import 'package:servi_go_app/features/messaging/chat_room/presentation/views/widgets/message_input_area.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/admin_chat/admin_chat_cubit.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/admin_chat/admin_chat_state.dart';

class AdminChatView extends StatelessWidget {
  final int adminId;          
  final int? adminChatId;    
  final String adminName;
  final String? adminPhoto;

  const AdminChatView({
    super.key,
    required this.adminId,
    this.adminChatId,
    required this.adminName,
    this.adminPhoto,
  });

  String _buildImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    if (path.contains('localhost')) {
      return path.replaceAll('localhost', '10.0.2.2');
    }
    return 'http://10.0.2.2/servigo/public/$path';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _buildImageUrl(adminPhoto);

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
                    Text(adminName, style: TextStyles.font11WhiteW500),
                  ],
                ),
              ),
              Gap(10),

           
              Expanded(
                child: BlocBuilder<AdminChatCubit, AdminChatState>(
                  builder: (context, state) {
                    if (state.status == AdminChatStatus.loading &&
                        state.messages.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == AdminChatStatus.error) {
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

   
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: MessageInputArea(
          onSendMessage: (content) {
           
         
            context.read<AdminChatCubit>().sendMessage(adminId, content);
          },
        ),
      ),
    );
  }
}