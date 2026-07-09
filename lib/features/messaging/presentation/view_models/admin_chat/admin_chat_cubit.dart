
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/messaging/data/repositories/admin_chat_repository.dart';
import 'admin_chat_state.dart';

class AdminChatCubit extends Cubit<AdminChatState> {
  final AdminChatRepository _repository;

  AdminChatCubit(this._repository) : super(AdminChatState());


  Future<void> fetchAdminList() async {
    emit(state.copyWith(status: AdminChatStatus.loading));
    try {
      final adminList = await _repository.getAdminList();
      emit(state.copyWith(
        status: AdminChatStatus.success,
        adminList: adminList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AdminChatStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

 
  Future<void> fetchMessages(int adminChatId) async {
    emit(state.copyWith(
      status: AdminChatStatus.loading,
      currentAdminChatId: adminChatId,
    ));
    try {
      final messages = await _repository.getMessages(adminChatId);
      emit(state.copyWith(
        status: AdminChatStatus.success,
        messages: messages,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AdminChatStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }


  Future<void> sendMessage(int adminId, String? content) async {
    try {
      final newMessage = await _repository.sendMessage(adminId, content);
      
      final updatedMessages = [...state.messages, newMessage];
      emit(state.copyWith(messages: updatedMessages));
    } catch (e) {
      emit(state.copyWith(
        status: AdminChatStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}