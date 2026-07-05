
import 'dart:io';
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/models/chat_models.dart';

class ChatRepository {
  final ChatRemoteDataSource _dataSource;

  ChatRepository(this._dataSource);

  Future<List<ChatListItem>> getChatList() async {
    try {
      final response = await _dataSource.getChatList();
      final data = response['data'];
      final chats = data['chats'] as List? ?? [];
      return chats.map((e) => ChatListItem.fromJson(e)).toList();
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error loading chat list: $e');
    }
  }

  Future<StartChatResponse> startChat(int providerId) async {
    try {
      final response = await _dataSource.startChat(providerId);
      return StartChatResponse.fromJson(response);
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error starting chat: $e');
    }
  }

  Future<List<ChatMessage>> getMessages(int chatId) async {
    try {
      final response = await _dataSource.getMessages(chatId);
      final data = response['data'] as Map<String, dynamic>? ?? {};
      final messages = data['messages'] as List? ?? [];
      return messages.map((e) => ChatMessage.fromJson(e)).toList();
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error loading messages: $e');
    }
  }

  Future<ChatMessage> sendMessage(
    int chatId,
    String? content, {
    File? image,
    File? video,
  }) async {
    try {
      final response = await _dataSource.sendMessage(
        chatId,
        content,
        image: image,
        video: video,
      );
      return ChatMessage.fromJson(response['data']);
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error sending message: $e');
    }
  }
}