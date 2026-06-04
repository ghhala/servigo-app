import 'package:dio/dio.dart';
import 'package:servi_go_app/core/network/api_error.dart';

class ApiException {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // إذا كان الرد قادماً من السيرفر على هيئة Map (JSON)
    if (data is Map<String, dynamic>) {
      String? customMessage = data["message"] is String ? data["message"] : null;
      Map<String, dynamic>? validationErrors;

      // التقاط أخطاء الـ Validation المخصصة من Laravel
      if (data["errors"] is Map<String, dynamic>) {
        validationErrors = data["errors"];
        
        // هنا حل مشكلة الـ Null Safety: استخدمنا التقييد الآمن داخل الـ if
        if (validationErrors != null && validationErrors.isNotEmpty) {
          if (customMessage == null || customMessage.contains('required')) {
            // وضعنا علامة (!) لأننا تأكدنا تماماً في السطر السابق أن المتغير ليس null
            final firstKey = validationErrors.keys.first; 
            
            if (validationErrors[firstKey] is List && (validationErrors[firstKey] as List).isNotEmpty) {
              customMessage = validationErrors[firstKey][0]; // مثل: "The name field is required."
            }
          }
        }
      }

      // إذا نجحنا في العثور على رسالة أو أخطاء تفصيلية من السيرفر
      if (customMessage != null || validationErrors != null) {
        return ApiError(
          message: customMessage ?? "Validation error occurred.",
          statusCode: statusCode,
          errors: validationErrors, 
        );
      }
    }

    // رسائل وأخطاء Dio المتعلقة بالاتصال والشبكة
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout, check your internet.");

      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout, please try again.");

      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response timeout, please try again.");

      case DioExceptionType.badResponse:
        if (statusCode == 422) {
          return ApiError(message: "Invalid data provided.", statusCode: statusCode);
        }
        return ApiError(
          message: "Server error (${statusCode ?? 'unknown'}).",
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return ApiError(message: "Request to server was cancelled.");

      default:
        return ApiError(
          message: "Unexpected error occurred, please try again.",
          statusCode: statusCode,
        );
    }
  }
}