
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/admin_chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/models/admin_chat_models.dart';

class AdminChatRepository {
  final AdminChatRemoteDataSource _dataSource;

  AdminChatRepository(this._dataSource);

  
  Future<List<AdminItem>> getAdminList() async {
    try {
      final response = await _dataSource.getAdminList();
      final data = response['data'] as List? ?? [];
      return data.map((e) => AdminItem.fromJson(e)).toList();
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error loading admin list: $e');
    }
  }


  Future<List<AdminChatMessage>> getMessages(int adminChatId) async {
    try {
      final response = await _dataSource.getMessages(adminChatId);
      final data = response['data'] as List? ?? [];
      return data.map((e) => AdminChatMessage.fromJson(e)).toList();
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error loading admin messages: $e');
    }
  }

 
  Future<AdminChatMessage> sendMessage(int adminId, String? content) async {
    try {
      final response = await _dataSource.sendMessage(adminId, content);
      return AdminChatMessage.fromJson(response['data']);
    } on ApiError {
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Error sending admin message: $e');
    }
  }
}