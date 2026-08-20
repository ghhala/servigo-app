// lib/features/messaging/presentation/utils/open_admin_chat.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/core/network/dio_client.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/admin_chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/repositories/admin_chat_repository.dart';

Future<void> openAdminChat(BuildContext context) async {
  final repository = AdminChatRepository(
    AdminChatRemoteDataSource(ApiService(DioClient())),
  );

  try {
    final admins = await repository.getAdminList();
    if (admins.isEmpty) return;

    final admin = admins.firstWhere(
      (a) => a.adminChatId != null,
      orElse: () => admins.first,
    );

    if (context.mounted) {
      GoRouter.of(context).push(
        AppRouter.kAdminChatRoom,
        extra: {
          'adminId': admin.adminId,
          'adminChatId': admin.adminChatId,
          'adminName': admin.adminName,
          'adminPhoto': admin.adminPhoto,
        },
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح المحادثة مع الإدارة، حاولي مجدداً')),
      );
    }
  }
}