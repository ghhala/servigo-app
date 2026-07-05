
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:servi_go_app/core/network/api_service.dart';

class ChatRemoteDataSource {
  final ApiService _apiService;

  ChatRemoteDataSource(this._apiService);

 Future<dynamic> getChatList() async {
  try {
    final result = await _apiService.get('chat/list');
    print("✅ chat/list response: $result");
    return result;
  } catch (e) {
    print("❌ chat/list error: $e");
    rethrow;
  }
}

  Future<dynamic> startChat(int providerId) async {
    return await _apiService.post('chat/start/$providerId', {});
  }

  Future<dynamic> getMessages(int chatId) async {
    return await _apiService.get('chat/$chatId/messages');
  }

  Future<dynamic> sendMessage(
    int chatId,
    String? content, {
    File? image,
    File? video,
  }) async {
    final formData = FormData.fromMap({
      if (content != null && content.isNotEmpty) 'content': content,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      if (video != null)
        'video': await MultipartFile.fromFile(
          video.path,
          filename: video.path.split('/').last,
        ),
    });

    return await _apiService.postFormData('chat/$chatId/send', formData);
  }
}