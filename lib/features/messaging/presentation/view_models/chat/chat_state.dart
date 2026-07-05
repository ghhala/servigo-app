// lib/features/messaging/presentation/view_models/chat_state.dart

import 'package:servi_go_app/features/messaging/data/models/chat_models.dart';

enum ChatStatus { initial, loading, success, error }

class ChatState {
  final ChatStatus status;
  final List<ChatListItem> chatList;
  final List<ChatMessage> messages;
  final int? currentChatId;
  final String? otherPartyName;
  final String? otherPartyPhoto;
  final String? errorMessage;

  ChatState({
    this.status = ChatStatus.initial,
    this.chatList = const [],
    this.messages = const [],
    this.currentChatId,
    this.otherPartyName,
    this.otherPartyPhoto,
    this.errorMessage,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatListItem>? chatList,
    List<ChatMessage>? messages,
    int? currentChatId,
    String? otherPartyName,
    String? otherPartyPhoto,
    String? errorMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatList: chatList ?? this.chatList,
      messages: messages ?? this.messages,
      currentChatId: currentChatId ?? this.currentChatId,
      otherPartyName: otherPartyName ?? this.otherPartyName,
      otherPartyPhoto: otherPartyPhoto ?? this.otherPartyPhoto,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}