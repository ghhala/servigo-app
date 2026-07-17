import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/messaging/data/models/chat_models.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_cubit.dart';

class ChatTile extends StatelessWidget {
  final ChatListItem chat;
  final VoidCallback onTap;

  const ChatTile({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    final imageUrl = ChatCubit.buildImageUrl(chat.otherPartyPhoto);

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
                radius: 33.r,
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
                            chat.otherPartyName,
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
                        chat.lastMessage ?? '',
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
