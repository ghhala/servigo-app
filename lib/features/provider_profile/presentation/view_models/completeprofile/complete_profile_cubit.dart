import 'package:dio/dio.dart'; // 👈 تأكدي من إضافة هذا الاستيراد لقراءة DioException
import 'package:flutter/material.dart'; // 👈 لإستخدام debugPrint
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_model.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/complete_profile_repository.dart';

import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final CompleteProfileRepository _repository;

  CompleteProfileCubit(this._repository) : super(CompleteProfileInitial());

  Future<void> submitCompleteProfile(CompleteProfileModel model) async {
    emit(CompleteProfileLoading());
    try {
      final response = await _repository.completeProfile(model);
      emit(CompleteProfileSuccess(response));
    } catch (e, stackTrace) {
      // 🚀 طباعة تفاصيل الخطأ المحلي بالكامل ومكان حدوثه في الملفات
      debugPrint("🚨 EMERGENCY DEBUG - SHOW ME EVERYTHING:");
      debugPrint("Exception Type: ${e.runtimeType}");
      debugPrint("Error Message: $e");
      debugPrint("StackTrace: $stackTrace"); // 👈 هذا السطر سيخبرنا برقم السطر والملف المسبب للأزمة
      
      if (e is DioException) {
        debugPrint("=================== SERVER VALIDATION ERROR ===================");
        debugPrint("Status Code: ${e.response?.statusCode}");
        debugPrint("Response Data: ${e.response?.data}");
        debugPrint("===============================================================");
        final serverMessage = e.response?.data['message'] ?? e.toString();
        emit(CompleteProfileFailure(serverMessage));
      } else {
        emit(CompleteProfileFailure(e.toString()));
      }
    }
  }
}