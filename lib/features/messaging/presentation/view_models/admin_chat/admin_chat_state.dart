
import 'package:servi_go_app/features/messaging/data/models/admin_chat_models.dart';

enum AdminChatStatus { initial, loading, success, error }

class AdminChatState {
  final AdminChatStatus status;
  final List<AdminItem> adminList;
  final List<AdminChatMessage> messages;
  final int? currentAdminChatId;
  final String? errorMessage;

  AdminChatState({
    this.status = AdminChatStatus.initial,
    this.adminList = const [],
    this.messages = const [],
    this.currentAdminChatId,
    this.errorMessage,
  });

  AdminChatState copyWith({
    AdminChatStatus? status,
    List<AdminItem>? adminList,
    List<AdminChatMessage>? messages,
    int? currentAdminChatId,
    String? errorMessage,
  }) {
    return AdminChatState(
      status: status ?? this.status,
      adminList: adminList ?? this.adminList,
      messages: messages ?? this.messages,
      currentAdminChatId: currentAdminChatId ?? this.currentAdminChatId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}