import 'package:servi_go_app/core/network/api_service.dart';

class AdminChatRemoteDataSource {
  final ApiService _apiService;

  AdminChatRemoteDataSource(this._apiService);

  Future<dynamic> getAdminList() async {
    final response = await _apiService.get('chat/admins');
    print('RAW ADMIN RESPONSE: $response');
    return response;
  }

  Future<dynamic> getMessages(int adminChatId) async {
    return await _apiService.get('chat/admins/$adminChatId/messages');
  }

  Future<dynamic> sendMessage(int adminId, String? content) async {
    return await _apiService.post('chat/admins/$adminId/send', {
      if (content != null && content.isNotEmpty) 'content': content,
    });
  }
}
