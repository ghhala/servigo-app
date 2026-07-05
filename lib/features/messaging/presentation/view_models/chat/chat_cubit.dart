
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/messaging/data/repositories/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatCubit(this._repository) : super(ChatState());

  
  Future<void> fetchChatList() async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      final chatList = await _repository.getChatList();
      emit(state.copyWith(status: ChatStatus.success, chatList: chatList));
    } catch (e) {
          print("❌ ChatCubit fetchChatList error: $e"); 

      emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
    }
  }

 
  Future<int?> startChat(int providerId) async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      final response = await _repository.startChat(providerId);
      emit(state.copyWith(
        status: ChatStatus.success,
        currentChatId: response.chatId,
      ));
     
      await fetchMessages(response.chatId);
      return response.chatId;
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
      return null;
    }
  }

  // ── جلب رسائل محادثة معينة ──
  Future<void> fetchMessages(int chatId) async {
    emit(state.copyWith(status: ChatStatus.loading, currentChatId: chatId));
    try {
      final messages = await _repository.getMessages(chatId);
      emit(state.copyWith(status: ChatStatus.success, messages: messages));
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
    }
  }

 
  Future<void> sendMessage(
    int chatId,
    String? content, {
    File? image,
    File? video,
  }) async {
    try {
      final newMessage = await _repository.sendMessage(
        chatId,
        content,
        image: image,
        video: video,
      );
   
      final updatedMessages = [...state.messages, newMessage];
      emit(state.copyWith(messages: updatedMessages));
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
    }
  }

 
  static String buildImageUrl(String? path) {
  if (path == null || path.isEmpty) return '';
  if (path.startsWith('http://') || path.startsWith('https://')) return path;
  if (path.contains('localhost')) {
    return path.replaceAll('localhost', '10.0.2.2');
  }
  return 'http://10.0.2.2/servigo/public/storage/$path';
}
}