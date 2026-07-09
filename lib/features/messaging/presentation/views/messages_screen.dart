import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/core/network/dio_client.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/admin_chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/repositories/admin_chat_repository.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/admin_chat/admin_chat_cubit.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/admin_chat/admin_chat_state.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_cubit.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_state.dart';
import 'package:servi_go_app/features/messaging/presentation/views/widgets/custom_tab.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    
    context.read<ChatCubit>().fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(top: 70.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Messages", style: TextStyles.font16BlackW700),
              Gap(16.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: CustomTab(
                      title: 'Customer',
                      isSelected: _selectedTab == 0,
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: CustomTab(
                      title: 'Admin',
                      isSelected: _selectedTab == 1,
                    ),
                  ),
                ],
              ),
              Gap(26.h),
              _selectedTab == 0
                  ? _buildCustomerChats()
                  : _buildAdminChats(),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildCustomerChats() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.status == ChatStatus.loading) {
          return const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == ChatStatus.error) {
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errorMessage ?? 'Error loading chats',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  Gap(12.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ChatCubit>().fetchChatList(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.chatList.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: Text('No conversations yet')),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.chatList.length,
          separatorBuilder: (_, __) => Gap(10.h),
          itemBuilder: (context, index) {
            final chat = state.chatList[index];
            return _ChatTileItem(
              name: chat.otherPartyName,
              photo: chat.otherPartyPhoto,
              lastMessage: chat.lastMessage,
              onTap: () => GoRouter.of(context).push(
                AppRouter.kChatRoom,
                extra: {
                  'chatId': chat.id,
                  'otherPartyName': chat.otherPartyName,
                  'otherPartyPhoto': chat.otherPartyPhoto,
                },
              ),
            );
          },
        );
      },
    );
  }

 
  Widget _buildAdminChats() {
    return BlocProvider(
      create: (_) => AdminChatCubit(
        AdminChatRepository(
          AdminChatRemoteDataSource(ApiService(DioClient())),
        ),
      )..fetchAdminList(),
      child: BlocBuilder<AdminChatCubit, AdminChatState>(
        builder: (context, state) {
          if (state.status == AdminChatStatus.loading) {
            return const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == AdminChatStatus.error) {
            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.errorMessage ?? 'Error loading admins',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Gap(12.h),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AdminChatCubit>().fetchAdminList(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.adminList.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(child: Text('No admins available')),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.adminList.length,
            separatorBuilder: (_, __) => Gap(10.h),
            itemBuilder: (context, index) {
              final admin = state.adminList[index];
              return _ChatTileItem(
                name: admin.adminName,
                photo: admin.adminPhoto,
                lastMessage: admin.adminChatId != null
                    ? 'Tap to continue conversation'
                    : 'Tap to start conversation',
                onTap: () => GoRouter.of(context).push(
                  AppRouter.kAdminChatRoom,
                  extra: {
                    'adminId': admin.adminId,
                    'adminChatId': admin.adminChatId,
                    'adminName': admin.adminName,
                    'adminPhoto': admin.adminPhoto,
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class _ChatTileItem extends StatelessWidget {
  final String name;
  final String? photo;
  final String? lastMessage;
  final VoidCallback onTap;

  const _ChatTileItem({
    required this.name,
    this.photo,
    this.lastMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    final imageUrl = ChatCubit.buildImageUrl(photo);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 353.w,
        height: 80.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : const AssetImage('assets/images/user_avatar.jpg')
                        as ImageProvider,
              ),
              Gap(10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font18BlackW500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: isDark ? onSurface : Colors.black,
                            size: 20.r,
                          ),
                        ],
                      ),
                      Gap(7),
                      Text(
                        lastMessage ?? '',
                        style: TextStyles.onCard(
                          context,
                          TextStyles.font12BlackW400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Gap(8),
            ],
          ),
        ),
      ),
    );
  }
}